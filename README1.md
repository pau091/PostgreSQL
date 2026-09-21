Proyecto SST/PESV — PostgreSQL
Base de datos relacional multi-tenant para la gestión de Seguridad y Salud en el Trabajo (SST) y Plan Estratégico de Seguridad Vial (PESV), desarrollada como proyecto académico de la Especialización en Seguridad Informática (UNAD) según el enunciado de Examen.md.

Contenido de este repositorio
Archivo	Contenido
schema_sst_pesv.sql	Script DDL con las 17 tablas del modelo físico (listo para importar en DrawSQL)
guia_sst_pesv.md	Guía completa: creación de la BD, datos de prueba y las 106 consultas/objetos resueltos, con enunciado, SQL y explicación de cada etiqueta
Diagrama Mermaid	Entregado en el chat, listo para pegar en draw.io / diagrams.net
1. Ejercicios resueltos
Se resolvieron 106 puntos del examen, organizados en las 7 secciones que exige el documento:

Sección	Cantidad	Objetos principales
1. Consultas SQL básicas	15/15	SELECT, WHERE, ORDER BY, LIKE, BETWEEN, IS NULL
2. Consultas SQL intermedias	20/20	INNER JOIN, LEFT JOIN, GROUP BY, HAVING
3. Consultas SQL avanzadas	25/25	Subconsultas, CTE, funciones de ventana (OVER, RANK), CASE, FILTER
4. Vistas y vistas materializadas	8/8 + 2 auxiliares	CREATE VIEW, CREATE MATERIALIZED VIEW, REFRESH, índices
5. Procedimientos almacenados	15/15	PL/pgSQL, CALL, manejo de excepciones
6. Funciones almacenadas	8/8	Funciones escalares y tabulares (RETURNS TABLE)
7. Triggers	15/15	BEFORE/AFTER, NEW/OLD, auditoría, validación
Cada ejercicio está documentado en guia_sst_pesv.md con: enunciado exacto, SQL, explicación de cada etiqueta usada (por qué y efecto) y justificación de cómo cumple el requisito.

Correcciones aplicadas durante el desarrollo (registradas como parte de la trazabilidad técnica):

5.3 (organizaciones con todos los módulos de un sistema SST): se corrigió un system_id fijo por una subconsulta que resuelve el id por nombre (WHERE nombre = 'SST'), para no depender del orden de inserción del catálogo.
6.9 (vistas materializadas vm_template_sst_docs_summary / vm_template_pesv_docs_summary): mismo tipo de corrección, resolviendo el sistema por nombre dentro de la condición del JOIN.
5.15 (acumulado de documentos finalizados): se ajustó la función de ventana de RANGE (por defecto) a ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW, para garantizar un acumulado fila por fila incluso con fechas de creación repetidas.
Orden de ejecución (5.10-5.14, 5.22-5.24): estas consultas reutilizan vistas materializadas de la sección de vistas; el enunciado del examen las numera antes de la sección de vistas, así que hay que crear esas vistas primero o la consulta falla con relation does not exist. Se agregó un bloque de prerrequisito explícito en la guía justo antes de 5.10.
5.17 (cargo con ocupación superior al promedio de su organización): la consulta era correcta, pero los datos de prueba originales asignaban exactamente 1 persona por cargo, por lo que el resultado salía vacío (ningún cargo supera un promedio de 1). Se documentó un INSERT adicional para generar variación y poder verificar el resultado.
2. Modelo de datos — tablas
El modelo físico contempla 17 tablas, con nombres en inglés (tal como los referencia el examen) y columnas en español:

Tabla	Propósito	Relaciones clave
countries	Catálogo de países	Padre de departments
departments	Departamentos/regiones	FK a countries; padre de cities
cities	Municipios/ciudades	FK a departments; referenciada por tenants
tenant_sizes	Catálogo de tamaños de empresa	Referenciada por tenants
tenants	Organizaciones (entidad central multi-tenant)	FK a tenant_sizes, cities
positions	Cargos, propios de cada organización	FK a tenants
persons	Personas/trabajadores	FK a tenants, positions
type_system_sst	Catálogo de sistemas (SST, PESV)	Referenciada por tenantsystems, modules, templates
tenantsystems	Habilitación de sistemas por organización (N:M)	PK compuesta (tenant_id, system_id)
modules	Módulos funcionales de cada sistema	FK a type_system_sst
tenant_modules	Asignación de módulos por organización (N:M)	PK compuesta (tenant_id, module_id)
formats_sst	Formatos documentales de cada módulo	FK a modules
phva_stages	Catálogo de etapas del ciclo PHVA	Referenciada por templates
templates	Plantillas documentales (sistema + etapa + formato)	FK a type_system_sst, phva_stages, formats_sst
tenanttemplates	Asignación de plantillas por organización	FK a tenants, templates
evaluations	Evaluaciones asociadas a una plantilla	FK a templates
documents	Documentos generados (base del cumplimiento)	FK a tenants, templates
editing_locks	Bloqueos de edición (control de concurrencia)	Genérica por tipo_recurso + recurso_id
tenant_audit	Auditoría de cambios sobre tenants	FK a tenants
3. Normalización aplicada
El modelo se diseñó cumpliendo hasta 4FN. Resumen por forma normal y dónde se aplicó:

1FN — valores atómicos, sin grupos repetidos
Dónde: todas las tablas. Ningún atributo almacena listas ni valores compuestos. Por qué: por ejemplo, en vez de una columna tenants.modulos_habilitados = "1,2,3", cada asignación módulo–organización vive como una fila independiente en tenant_modules. Esto permite filtrar, indexar y validar cada asignación individualmente (y es lo que hace posible los triggers de "no duplicados").

2FN — sin dependencia parcial de una llave compuesta
Dónde: tenantsystems (tenant_id, system_id) y tenant_modules (tenant_id, module_id), las únicas tablas con PRIMARY KEY compuesta. Por qué: su columna adicional (habilitado_en, asignado_en) depende de la combinación completa de la llave, no de una sola mitad. Si asignado_en dependiera solo de tenant_id (por ejemplo, "fecha en que el tenant empezó a usar el sistema"), habría que sacarla a otra tabla; aquí depende genuinamente del par completo (cuándo se asignó ese módulo a ese tenant).

3FN — sin dependencias transitivas
Dónde: todas las tablas con llave simple (tenants, persons, modules, templates, documents, etc.). Por qué: ninguna columna no-clave depende de otra columna no-clave. Ejemplo: en templates, nombre depende del id de la plantilla, no de stage_id ni de format_id; los datos de la etapa o el formato viven en sus propias tablas (phva_stages, formats_sst) y se acceden por JOIN, no se copian dentro de templates.

BCNF (forma normal de Boyce-Codd)
Dónde: aplica igual que 3FN en este modelo, porque cada tabla tiene una sola llave candidata natural (el id autogenerado, o la combinación en las tablas intermedias) y todas las dependencias funcionales parten de esa llave.

4FN — sin dependencias multivaluadas independientes
Dónde: las tres relaciones N:M del modelo (tenant_modules, tenantsystems, tenanttemplates) están separadas en tablas binarias independientes, cada una relacionando solo dos entidades. Por qué: una violación de 4FN ocurre cuando una tabla mezcla dos hechos multivaluados que no tienen relación entre sí (ej. una tabla persona-habilidad-idioma donde habilidades e idiomas de una persona son independientes entre sí, pero quedan mezclados en la misma tabla generando filas redundantes). Aquí, en cambio, "los módulos que tiene una organización" y "los sistemas que tiene habilitados" y "las plantillas que tiene asignadas" viven en tres tablas distintas (tenant_modules, tenantsystems, tenanttemplates), no combinadas en una sola. Esto evita la explosión combinatoria de filas redundantes que causaría mezclar dos hechos independientes en una misma tabla.

Punto de diseño documentado (no es una violación de 4FN)
persons.tenant_id es técnicamente derivable a través de persons.position_id → positions.tenant_id, lo que introduce una redundancia controlada (no una dependencia multivaluada). Se mantuvo a propósito porque en una arquitectura multi-tenant es práctica estándar tener tenant_id explícito en cada tabla de negocio, para poder filtrar/indexar directamente por organización sin depender de un JOIN adicional, y porque simplifica las políticas de aislamiento de datos entre organizaciones. La consistencia entre ambos valores la garantiza el trigger trg_persons_check_position (sección 9.6 de la guía), que impide asignar un cargo de una organización distinta a la del tenant_id de la persona.

4. Cómo usar este repositorio
Ejecuta schema_sst_pesv.sql en tu base de datos PostgreSQL (o impórtalo en DrawSQL para ver el diagrama).
Sigue guia_sst_pesv.md en orden: creación de BD → tablas → datos de prueba → consultas básicas → intermedias → avanzadas → vistas → procedimientos → funciones → triggers.
Cada bloque de la guía es independiente y ejecutable directamente en psql.


**imagenes de las tablas**

**TABLA DRAW SQL**

--> https://ibb.co/Kzx157DX

**TABLA DIAGRAMS.IO**

--> https://ibb.co/NGsfRKW
--> https://ibb.co/VYr03z39
--> https://ibb.co/x8BtjT07 
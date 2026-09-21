Guía paso a paso — Base de datos SST/PESV en PostgreSQL
Esta guía cubre: (0) cómo crear la base de datos desde tu terminal, (1) el significado y el "por qué/efecto" de cada etiqueta SQL que vas a usar, (2) el modelo físico (tablas) que soporta todos los ejercicios del examen, y (3) cada consulta/vista/procedimiento/función/trigger pedido, con el SQL y la explicación de qué hace y por qué se escribe así.

Nota: los nombres de las tablas se mantienen en inglés (tenants, persons, positions, etc., tal como los nombra el examen). Las columnas/etiquetas de cada tabla están en español (nombre, correo, activo, creado_en...).

0. Crear la base de datos desde la terminal
Tu terminal ya está conectada con psql a una base llamada bkddb (usuario bkseducate). Esa base es la que trae tu entorno de trabajo por defecto; no la reutilices para el examen, crea una nueva para no mezclar datos.

Con el prompt bkddb=# ya abierto, escribe:

CREATE DATABASE sst_pesv_db;
Por qué: CREATE DATABASE crea un contenedor lógico separado; así tu proyecto queda aislado de bkddb.
Efecto: PostgreSQL crea un nuevo cluster de catálogos/objetos con ese nombre.
Conéctate a ella sin salir de psql:

\c sst_pesv_db
\c es un comando de psql (no SQL), cambia la sesión activa a la base indicada. Verás que el prompt cambia a sst_pesv_db=#.
Comandos de psql que usarás seguido (no llevan ; porque no son SQL):

Comando	Efecto
\l	Lista las bases de datos existentes
\dt	Lista las tablas de la base actual
\d nombre_tabla	Muestra columnas, tipos y llaves de una tabla
\dv	Lista vistas
\df	Lista funciones
\q	Sale de psql
Si en algún momento cierras la terminal, vuelve a entrar igual que en tu captura pero apuntando ya a tu base:

psql -h postgres_db -p 5432 -U bkseducate -d sst_pesv_db
A partir de aquí, todo lo que pegues en la terminal son sentencias SQL (terminan en ;).

1. Glosario de etiquetas/cláusulas — por qué se usan y qué efecto producen
Esta tabla es tu referencia; en las secciones siguientes solo se explica lo nuevo o lo específico de cada ejercicio para no repetir.

1.1 Definición de tablas (DDL)
Etiqueta	Por qué se usa	Efecto
CREATE TABLE	Define una nueva entidad del modelo	Crea la estructura vacía en el catálogo
SERIAL / GENERATED ALWAYS AS IDENTITY	Necesitas un identificador único autogenerado	PostgreSQL crea una secuencia interna y asigna el siguiente número en cada INSERT
PRIMARY KEY	Cada fila debe tener un identificador único e irrepetible	Crea automáticamente un índice único y prohíbe NULL en esa columna
FOREIGN KEY ... REFERENCES	Garantiza que una relación (ej. persons.tenant_id) apunte a un registro real	PostgreSQL rechaza el INSERT/UPDATE si el valor no existe en la tabla referenciada (integridad referencial)
NOT NULL	El dato es obligatorio para que el registro tenga sentido (ej. nombre de la organización)	Rechaza filas donde esa columna venga vacía
UNIQUE	El valor no se puede repetir, pero no es la llave primaria (ej. correo)	Crea un índice único; el segundo valor igual es rechazado
CHECK	Se necesita validar una regla de negocio dentro de un rango o lista (ej. porcentaje_cumplimiento BETWEEN 0 AND 100)	Rechaza el INSERT/UPDATE si la condición es falsa
DEFAULT	Un valor tiene un estado inicial lógico (ej. activo DEFAULT true, creado_en DEFAULT now())	Si no se envía el valor, se usa el definido
ON DELETE CASCADE	Al borrar el "padre" tiene sentido borrar sus "hijos" (ej. borrar un tenant y sus asignaciones)	Ejecuta automáticamente el borrado en cascada
ON DELETE RESTRICT	No se debe permitir borrar un registro si tiene dependientes (lo usarás en triggers de bloqueo de borrado también)	PostgreSQL lanza error si existen hijos
TIMESTAMP / TIMESTAMPTZ	Se necesita registrar cuándo ocurrió algo (creado_en, actualizado_en)	Almacena fecha y hora; TIMESTAMPTZ además guarda zona horaria
VARCHAR(n) / TEXT	Tipo de dato para texto	VARCHAR limita longitud, TEXT es libre
BOOLEAN	Campos de sí/no (ej. activo)	Solo acepta true/false
1.2 Consultas
Etiqueta	Por qué	Efecto
SELECT	Elegir qué columnas quieres ver	Devuelve solo esas columnas, no toda la fila
WHERE	Filtrar filas antes de agrupar/mostrar	Elimina las filas que no cumplen la condición
ORDER BY	Orden de lectura pedido (alfabético, fecha, etc.)	Ordena el resultado final, no la tabla
DISTINCT	Evitar duplicados en el resultado	Colapsa filas idénticas en una sola
LIKE '%texto%'	Búsqueda parcial de texto	Compara con comodines (%=cualquier cadena, _=un carácter)
IN (...)	Comparar contra una lista de valores	Equivale a varios OR encadenados
BETWEEN a AND b	Rango de fechas o números	Incluye los extremos a y b
IS NULL / IS NOT NULL	NULL no se compara con =	Evalúa explícitamente ausencia de valor
LIMIT	Restringir cantidad de filas devueltas	Corta el resultado tras N filas
INNER JOIN	Solo interesan las filas que sí tienen relación en ambas tablas	Descarta las que no coinciden en la condición ON
LEFT JOIN	Quieres conservar todos los registros de la tabla izquierda aunque no tengan relación (ej. tenants sin personas)	Rellena con NULL el lado derecho cuando no hay coincidencia
GROUP BY	Necesitas un resultado por grupo (por organización, por cargo, etc.)	Colapsa filas del mismo grupo en una sola fila resumen
HAVING	Filtrar después de agregar (ej. COUNT(*) > 5)	A diferencia de WHERE, actúa sobre el resultado agregado
COUNT/SUM/AVG/MAX/MIN	Funciones de agregación	Calculan un solo valor a partir de varias filas
CASE WHEN ... THEN ... END	Clasificar valores en categorías (bajo/medio/alto)	Devuelve una columna calculada según condiciones
Subconsulta (... WHERE x IN (SELECT ...))	Necesitas el resultado de una consulta para filtrar otra	Se ejecuta primero la interna, luego la externa usa su resultado
WITH nombre AS (...) (CTE)	Simplificar consultas complejas en pasos legibles y reutilizar un cálculo	Crea una tabla temporal con nombre, válida solo dentro de esa consulta
Funciones de ventana OVER (PARTITION BY ... ORDER BY ...)	Necesitas un cálculo (ranking, acumulado) sin colapsar filas como GROUP BY	Cada fila conserva su detalle y además recibe el valor calculado sobre su "ventana"
RANK() / ROW_NUMBER()	Generar un ranking	Asigna una posición según el ORDER BY de la ventana
SUM(...) OVER (ORDER BY ...)	Acumulado (running total)	Suma progresivamente fila a fila
1.3 Vistas, funciones, procedimientos, triggers
Etiqueta	Por qué	Efecto
CREATE VIEW	Guardar una consulta compleja y reutilizarla como si fuera una tabla	PostgreSQL la re-ejecuta cada vez que la consultas (siempre datos frescos)
CREATE MATERIALIZED VIEW	La consulta es pesada y se repite mucho (reportes)	Guarda el resultado físicamente; no se actualiza sola
REFRESH MATERIALIZED VIEW	Los datos base cambiaron y el reporte quedó desactualizado	Recalcula y reemplaza el contenido guardado
CREATE OR REPLACE FUNCTION	Necesitas un valor de retorno (escalar o tabla) para usarlo en un SELECT	Se comporta como una expresión: SELECT fn_calcular(1)
RETURNS TABLE(...)	La función debe devolver varias filas/columnas	Se consulta con SELECT * FROM fn(...) como una tabla
CREATE OR REPLACE PROCEDURE	Necesitas ejecutar una operación (insertar, actualizar, controlar transacción) sin que devuelva un valor para SELECT	Se ejecuta con CALL nombre_procedimiento(...)
LANGUAGE plpgsql	El cuerpo tiene lógica procedural (IF, LOOP, variables)	Habilita el intérprete de PL/pgSQL
DECLARE	Necesitas variables temporales dentro de la función/procedimiento	Reserva espacio y tipo para esa variable en la sesión de ejecución
IF ... THEN ... END IF	Bifurcar lógica según condición	Ejecuta un bloque u otro
RAISE NOTICE	Mostrar un mensaje informativo en consola	Imprime el texto al ejecutar, sin detener el proceso
RAISE EXCEPTION	Debes impedir que continúe una operación inválida	Aborta la transacción y devuelve el mensaje de error
BEGIN ... EXCEPTION WHEN ... END	Controlar errores esperables (ej. violación de unicidad)	Si ocurre el error indicado, ejecuta el bloque de manejo en vez de romper todo
CREATE TRIGGER ... BEFORE/AFTER ... FOR EACH ROW EXECUTE FUNCTION	Automatizar una acción cuando ocurre un evento (INSERT/UPDATE/DELETE)	PostgreSQL ejecuta la función asociada en cada fila afectada
NEW / OLD	Dentro de un trigger necesitas ver el valor nuevo o el anterior de la fila	NEW = fila que entra/queda; OLD = fila antes del cambio
CREATE INDEX	Una columna se filtra o se une (JOIN) muy seguido	Crea una estructura de búsqueda rápida (evita recorrer toda la tabla)
SELECT ... FOR UPDATE	Evitar que dos transacciones editen la misma fila a la vez	Bloquea la fila hasta que la transacción actual termine (COMMIT/ROLLBACK)
2. Modelo físico propuesto (DDL)
El documento no trae el diagrama entidad-relación con columnas, así que aquí tienes un modelo coherente con todos los nombres de tabla que el examen menciona. Los nombres de tabla quedan como en el enunciado; las columnas van en español.




-- 2.1 Geografía
CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais_id INT NOT NULL REFERENCES countries(id)
);

CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    departamento_id INT NOT NULL REFERENCES departments(id)
);

-- 2.2 Parametrización de empresa
CREATE TABLE tenant_sizes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE   -- ej. Pequeña, Mediana, Grande
);

-- 2.3 Organizaciones (multi-tenant)
CREATE TABLE tenants (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    nit VARCHAR(30) NOT NULL UNIQUE,
    correo_contacto VARCHAR(150),
    telefono VARCHAR(30),
    tamano_id INT REFERENCES tenant_sizes(id),
    ciudad_id INT REFERENCES cities(id),
    activo BOOLEAN NOT NULL DEFAULT true,
    creado_en TIMESTAMP NOT NULL DEFAULT now(),
    actualizado_en TIMESTAMP NOT NULL DEFAULT now()
);

-- 2.4 Cargos (pertenecen a una organización)
CREATE TABLE positions (
    id SERIAL PRIMARY KEY,
    tenant_id INT NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    descripcion VARCHAR(150) NOT NULL
);

-- 2.5 Personas
CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    tenant_id INT NOT NULL REFERENCES tenants(id),
    position_id INT REFERENCES positions(id),
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE,
    activo BOOLEAN NOT NULL DEFAULT true,
    creado_en TIMESTAMP NOT NULL DEFAULT now(),
    actualizado_en TIMESTAMP NOT NULL DEFAULT now()
);

-- 2.6 Sistemas SST y su habilitación por tenant
CREATE TABLE type_system_sst (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE   -- ej. SST, PESV
);

CREATE TABLE tenantsystems (
    tenant_id INT NOT NULL REFERENCES tenants(id),
    system_id INT NOT NULL REFERENCES type_system_sst(id),
    habilitado_en TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (tenant_id, system_id)
);

-- 2.7 Módulos y su asignación
CREATE TABLE modules (
    id SERIAL PRIMARY KEY,
    system_id INT NOT NULL REFERENCES type_system_sst(id),
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    orden INT
);

CREATE TABLE tenant_modules (
    tenant_id INT NOT NULL REFERENCES tenants(id),
    module_id INT NOT NULL REFERENCES modules(id),
    asignado_en TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (tenant_id, module_id)
);

-- 2.8 Formatos
CREATE TABLE formats_sst (
    id SERIAL PRIMARY KEY,
    module_id INT NOT NULL REFERENCES modules(id),
    nombre VARCHAR(150) NOT NULL
);

-- 2.9 Ciclo PHVA
CREATE TABLE phva_stages (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL UNIQUE   -- Planear, Hacer, Verificar, Actuar
);

-- 2.10 Plantillas y su asignación
CREATE TABLE templates (
    id SERIAL PRIMARY KEY,
    system_id INT NOT NULL REFERENCES type_system_sst(id),
    stage_id INT NOT NULL REFERENCES phva_stages(id),
    format_id INT REFERENCES formats_sst(id),
    nombre VARCHAR(150) NOT NULL
);

CREATE TABLE tenanttemplates (
    id SERIAL PRIMARY KEY,
    tenant_id INT NOT NULL REFERENCES tenants(id),
    template_id INT NOT NULL REFERENCES templates(id),
    asignado_en TIMESTAMP NOT NULL DEFAULT now(),
    actualizado_en TIMESTAMP NOT NULL DEFAULT now(),
    actualizado_por VARCHAR(100)
);

-- 2.11 Evaluaciones
CREATE TABLE evaluations (
    id SERIAL PRIMARY KEY,
    template_id INT NOT NULL REFERENCES templates(id),
    nombre VARCHAR(150) NOT NULL,
    creado_en TIMESTAMP NOT NULL DEFAULT now()
);

-- 2.12 Documentos generados (base de los indicadores de cumplimiento)
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    tenant_id INT NOT NULL REFERENCES tenants(id),
    template_id INT NOT NULL REFERENCES templates(id),
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('finalizado','borrador','no_iniciado','pendiente')),
    creado_en TIMESTAMP NOT NULL DEFAULT now(),
    actualizado_en TIMESTAMP NOT NULL DEFAULT now()
);

-- 2.13 Bloqueos de edición (concurrencia)
CREATE TABLE editing_locks (
    id SERIAL PRIMARY KEY,
    tipo_recurso VARCHAR(50) NOT NULL,
    recurso_id INT NOT NULL,
    bloqueado_por VARCHAR(100) NOT NULL,
    bloqueado_en TIMESTAMP NOT NULL DEFAULT now(),
    expira_en TIMESTAMP NOT NULL
);

-- 2.14 Auditoría
CREATE TABLE tenant_audit (
    id SERIAL PRIMARY KEY,
    tenant_id INT NOT NULL REFERENCES tenants(id),
    campo VARCHAR(100),
    valor_anterior TEXT,
    valor_nuevo TEXT,
    modificado_en TIMESTAMP NOT NULL DEFAULT now(),
    modificado_por VARCHAR(100)
);
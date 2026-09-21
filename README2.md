**CONSULTAS**

3. Consultas SQL básicas
Estas consultas evalúan SELECT, WHERE, ORDER BY, DISTINCT, operadores relacionales, LIKE, IN, BETWEEN, IS NULL y limitación de resultados (según el propio enunciado del examen).

3.1
Enunciado: "El estudiante deberá consultar todos los registros almacenados en la tabla tenants, mostrando la información disponible de cada organización registrada en el sistema."

SELECT * FROM tenants;
SELECT *: pide todas las columnas de la fila; se usa aquí porque el enunciado dice "mostrando la información disponible" (no pide columnas puntuales).
FROM tenants: indica de qué tabla se lee.
Cumple el requisito porque devuelve, sin filtrar ni limitar, cada organización con todos sus datos — exactamente "todos los registros... la información disponible".
3.2
Enunciado: "El estudiante deberá consultar el nombre, correo de contacto y teléfono de todas las organizaciones registradas en la tabla tenants."

SELECT nombre, correo_contacto, telefono FROM tenants;
SELECT nombre, correo_contacto, telefono: aquí ya no se usa * porque el enunciado pide columnas específicas; listar solo esas tres es la forma correcta de responder exactamente lo pedido, sin sobrar información.
Cumple el requisito porque el enunciado nombra tres datos puntuales (nombre, correo, teléfono) y la consulta trae exactamente esos tres, de todas las filas.
3.3
Enunciado: "El estudiante deberá listar las personas registradas en la tabla persons, mostrando sus nombres, apellidos y correo electrónico."

SELECT nombres, apellidos, correo FROM persons;
Igual que el caso anterior: proyección de columnas puntuales en vez de *.
Cumple el requisito porque expone justo los tres campos que pide el enunciado (nombres, apellidos, correo) de cada persona.
3.4
Enunciado: "El estudiante deberá consultar las personas cuyo estado se encuentre activo dentro de la plataforma."

SELECT * FROM persons WHERE activo = true;
WHERE activo = true: filtra las filas antes de que lleguen al resultado; es la etiqueta que traduce la palabra "cuyo estado se encuentre activo" del enunciado a una condición SQL.
Cumple el requisito porque solo deja pasar personas con activo = true; con los datos de prueba excluye a Jorge Martínez (que quedó false).
3.5
Enunciado: "El estudiante deberá obtener las organizaciones cuyo nombre contenga una determinada palabra proporcionada como criterio de búsqueda."

SELECT * FROM tenants WHERE nombre ILIKE '%trans%';
ILIKE: comparación de texto que ignora mayúsculas/minúsculas (a diferencia de LIKE, que sí distingue). Se usa porque una búsqueda de usuario no debería fallar por mayúsculas.
%trans%: los símbolos % significan "cualquier texto antes/después"; así detecta la palabra en cualquier posición del nombre.
Cumple el requisito porque "contenga una palabra" es exactamente lo que hace ILIKE '%...%' — no busca coincidencia exacta, busca coincidencia parcial. (Reemplaza trans por lo que el usuario escriba en cada búsqueda real.)
3.6
Enunciado: "El estudiante deberá listar todos los países almacenados en la tabla countries, ordenándolos alfabéticamente por nombre."

SELECT * FROM countries ORDER BY nombre ASC;
ORDER BY nombre ASC: ordena el resultado (no la tabla) de la A a la Z; ASC es ascendente y es el valor por defecto, pero se deja explícito porque el enunciado dice "alfabéticamente".
Cumple el requisito porque entrega la lista completa de países en orden alfabético, tal como se pide.
3.7
Enunciado: "El estudiante deberá consultar los departamentos o regiones pertenecientes a un país determinado."

SELECT d.* FROM departments d WHERE d.pais_id = 1;
WHERE d.pais_id = 1: filtra por el país específico que se está consultando (aquí, Colombia = id 1).
Alias d: no es obligatorio con una sola tabla, pero se deja por consistencia con las consultas de join que vienen después.
Cumple el requisito porque "pertenecientes a un país determinado" se traduce en filtrar por la llave foránea que conecta departments con countries.
3.8
Enunciado: "El estudiante deberá listar los municipios o ciudades correspondientes a un departamento o región específica."

SELECT c.* FROM cities c WHERE c.departamento_id = 1;
Mismo patrón que el punto anterior, un nivel más abajo en la jerarquía geográfica (cities depende de departments).
Cumple el requisito porque filtra las ciudades por el departamento indicado (departamento_id).
3.9
Enunciado: "El estudiante deberá consultar todos los cargos registrados en la tabla positions, ordenándolos por descripción."

SELECT * FROM positions ORDER BY descripcion;
ORDER BY descripcion: ordena alfabéticamente por el texto del cargo.
Cumple el requisito porque lista todos los cargos y respeta el orden pedido por el enunciado.
3.10
Enunciado: "El estudiante deberá consultar las personas que pertenezcan a una organización determinada mediante su identificador tenant_id."

SELECT * FROM persons WHERE tenant_id = 1;
WHERE tenant_id = 1: filtra directamente por la llave foránea que identifica a la organización — el enunciado pide explícitamente usar ese identificador.
Cumple el requisito porque devuelve solo las personas de la organización 1 (Constructora Andina), no todas.
3.11
Enunciado: "El estudiante deberá obtener las organizaciones que actualmente se encuentren habilitadas o activas dentro del sistema."

SELECT * FROM tenants WHERE activo = true;
Igual lógica que 3.4 pero sobre tenants: activo = true traduce "habilitadas o activas".
Cumple el requisito porque con los datos de prueba excluye a Textiles Bucaramanga (activo = false) y deja las otras dos.
3.12
Enunciado: "El estudiante deberá identificar las organizaciones que hayan sido registradas dentro de un período determinado utilizando la fecha de creación."

SELECT * FROM tenants
WHERE creado_en BETWEEN '2026-01-01' AND '2026-12-31';
BETWEEN a AND b: comprueba que creado_en esté dentro de un rango, incluyendo ambos extremos. Es la etiqueta pensada exactamente para "período determinado".
Cumple el requisito porque delimita las organizaciones cuya fecha de creación cae dentro del año indicado (ajusta las fechas al período real que te pidan evaluar).
3.13
Enunciado: "El estudiante deberá listar los diferentes tamaños de empresa almacenados en la tabla tenant_sizes."

SELECT * FROM tenant_sizes;
Consulta simple, sin filtro: el enunciado pide "los diferentes tamaños", es decir, el catálogo completo (que además ya es único por el UNIQUE en nombre).
Cumple el requisito al mostrar el catálogo completo de tamaños de empresa.
3.14
Enunciado: "El estudiante deberá consultar los diferentes tipos de sistemas SST registrados en la tabla type_system_sst."

SELECT * FROM type_system_sst;
Mismo patrón que el anterior sobre la tabla de sistemas (SST, PESV).
Cumple el requisito al listar el catálogo completo de sistemas disponibles.
3.15
Enunciado: "El estudiante deberá listar los módulos registrados en el sistema mostrando su título, descripción y orden de presentación."

SELECT titulo, descripcion, orden FROM modules
ORDER BY orden;
Proyección de las tres columnas pedidas + ORDER BY orden para que aparezcan en el orden de presentación real (no en el orden de inserción).
Cumple el requisito porque expone justo título, descripción y orden, ordenados como se van a mostrar en pantalla.
4. Consultas SQL intermedias
Esta sección incorpora INNER JOIN, LEFT JOIN, funciones agregadas, GROUP BY, HAVING y consultas que relacionan varias entidades (según el enunciado del examen).

4.1
Enunciado: "El estudiante deberá consultar todas las personas registradas, mostrando el nombre completo de la persona y el nombre de la organización a la cual pertenece."

SELECT p.nombres, p.apellidos, t.nombre AS tenant_nombre
FROM persons p
INNER JOIN tenants t ON p.tenant_id = t.id;
INNER JOIN ... ON: combina persons con tenants usando la relación tenant_id = id; solo trae personas que sí tienen una organización válida (siempre será el caso por la FOREIGN KEY, pero es la forma correcta de combinar dos tablas relacionadas).
Alias t: evita ambigüedad porque tanto persons como tenants van a tener columna nombre/nombres.
Cumple el requisito porque cada fila del resultado junta el nombre de la persona con el nombre de su organización, que es justo lo que pide el enunciado.
4.2
Enunciado: "El estudiante deberá consultar cada persona junto con el cargo que desempeña dentro de su organización."

SELECT p.nombres, p.apellidos, pos.descripcion AS cargo
FROM persons p
INNER JOIN positions pos ON p.position_id = pos.id;
INNER JOIN entre persons y positions por position_id.
Cumple el requisito porque muestra a cada persona junto a la descripción de su cargo actual.
4.3
Enunciado: "El estudiante deberá mostrar cada organización junto con el tamaño de empresa que tiene asignado."

SELECT t.nombre, ts.nombre AS tamano
FROM tenants t
LEFT JOIN tenant_sizes ts ON t.tamano_id = ts.id;
LEFT JOIN en vez de INNER JOIN: tamano_id puede ser NULL (la columna lo permite); con LEFT JOIN la organización aparece igual, con tamano = NULL, en vez de desaparecer del resultado.
Cumple el requisito porque muestra todas las organizaciones (el enunciado dice "cada organización") junto a su tamaño, exista o no ese dato.
4.4
Enunciado: "El estudiante deberá consultar cada organización mostrando la ciudad, departamento o región y país donde se encuentra registrada."

SELECT t.nombre, c.nombre AS ciudad, d.nombre AS departamento, co.nombre AS pais
FROM tenants t
LEFT JOIN cities c ON t.ciudad_id = c.id
LEFT JOIN departments d ON c.departamento_id = d.id
LEFT JOIN countries co ON d.pais_id = co.id;
Tres LEFT JOIN encadenados: cada uno sube un nivel en la jerarquía geográfica (tenant → ciudad → departamento → país). Se usa LEFT en los tres porque si falta cualquier eslabón (por ejemplo, ciudad_id es NULL), igual quieres ver la organización.
Cumple el requisito porque entrega los tres niveles geográficos pedidos (ciudad, departamento, país) para cada organización.
4.5
Enunciado: "El estudiante deberá determinar cuántas personas se encuentran registradas en cada organización."

SELECT t.nombre, COUNT(p.id) AS total_personas
FROM tenants t
LEFT JOIN persons p ON p.tenant_id = t.id
GROUP BY t.nombre;
LEFT JOIN: para que las organizaciones sin personas salgan con 0, no desaparezcan del resultado.
COUNT(p.id): cuenta cuántas filas de persons calzaron con cada organización; se cuenta p.id (no t.id) porque si no hay coincidencia, p.id es NULL y COUNT ignora los NULL, dando 0 correctamente.
GROUP BY t.nombre: colapsa todas las filas de una misma organización en un solo renglón resumen — es lo que hace posible "cuántas... en cada organización".
Cumple el requisito porque produce exactamente un total de personas por cada organización.
4.6
Enunciado: "El estudiante deberá identificar las organizaciones que tengan más de una cantidad determinada de personas registradas."

SELECT t.nombre, COUNT(p.id) AS total_personas
FROM tenants t
JOIN persons p ON p.tenant_id = t.id
GROUP BY t.nombre
HAVING COUNT(p.id) > 1;
HAVING COUNT(p.id) > 1: filtra después de agrupar; no se puede usar WHERE COUNT(...) porque en el momento de WHERE el conteo todavía no existe.
Cumple el requisito porque aplica la condición ("más de una cantidad determinada") sobre el total ya agregado, no sobre filas individuales. (Cambia el 1 por el umbral que te pidan.)
4.7
Enunciado: "El estudiante deberá consultar los módulos habilitados para cada organización mediante la relación existente en tenant_modules."

SELECT t.nombre, m.titulo
FROM tenant_modules tm
JOIN tenants t ON tm.tenant_id = t.id
JOIN modules m ON tm.module_id = m.id;
Dos JOIN: tenant_modules es la tabla intermedia (relación muchos-a-muchos) que conecta tenants con modules; se necesitan ambos joins para "traducir" los ids a nombres legibles.
Cumple el requisito porque usa exactamente la tabla tenant_modules que pide el enunciado para mostrar la relación organización-módulo.
4.8
Enunciado: "El estudiante deberá determinar cuántos módulos tiene habilitados cada organización."

SELECT t.nombre, COUNT(tm.module_id) AS total_modulos
FROM tenants t
LEFT JOIN tenant_modules tm ON tm.tenant_id = t.id
GROUP BY t.nombre;
Mismo patrón de conteo + LEFT JOIN + GROUP BY que el punto 4.5, aplicado a módulos.
Cumple el requisito porque entrega el total de módulos por organización, incluyendo las que tengan cero.
4.9
Enunciado: "El estudiante deberá consultar los sistemas SST habilitados para cada organización utilizando las tablas tenantsystems y type_system_sst."

SELECT t.nombre, s.nombre AS sistema
FROM tenantsystems ts
JOIN tenants t ON ts.tenant_id = t.id
JOIN type_system_sst s ON ts.system_id = s.id;
Igual lógica que 4.7, pero con la tabla intermedia tenantsystems (en vez de tenant_modules).
Cumple el requisito porque usa exactamente las dos tablas que pide el enunciado.
4.10
Enunciado: "El estudiante deberá mostrar los módulos existentes junto con el sistema SST al cual pertenecen."

SELECT m.titulo, s.nombre AS sistema
FROM modules m
JOIN type_system_sst s ON m.system_id = s.id;
Aquí no hace falta tabla intermedia: modules ya tiene la FK system_id directa hacia type_system_sst.
Cumple el requisito porque relaciona cada módulo con su sistema padre.
4.11
Enunciado: "El estudiante deberá consultar los formatos registrados en formats_sst, mostrando el módulo al cual pertenece cada formato."

SELECT f.nombre AS formato, m.titulo AS modulo
FROM formats_sst f
JOIN modules m ON f.module_id = m.id;
Cumple el requisito porque parte de la tabla que pide el enunciado (formats_sst) y la une a modules por module_id.
4.12
Enunciado: "El estudiante deberá determinar cuántos formatos se encuentran asociados a cada módulo."

SELECT m.titulo, COUNT(f.id) AS total_formatos
FROM modules m
LEFT JOIN formats_sst f ON f.module_id = m.id
GROUP BY m.titulo;
Mismo patrón de conteo por grupo, ahora agrupando por módulo.
Cumple el requisito porque entrega el total de formatos por cada módulo (incluidos los que tengan cero).
4.13
Enunciado: "El estudiante deberá consultar las plantillas asignadas a cada organización mediante la tabla tenanttemplates."

SELECT t.nombre, tt.id AS asignacion_id, tt.template_id
FROM tenanttemplates tt
JOIN tenants t ON tt.tenant_id = t.id;
Cumple el requisito porque parte directamente de tenanttemplates, la tabla que el enunciado exige usar.
4.14
Enunciado: "El estudiante deberá mostrar cada plantilla asignada indicando la organización, el sistema SST y la etapa PHVA relacionada."

SELECT t.nombre AS tenant, tpl.nombre AS plantilla, s.nombre AS sistema, ph.nombre AS etapa
FROM tenanttemplates tt
JOIN tenants t ON tt.tenant_id = t.id
JOIN templates tpl ON tt.template_id = tpl.id
JOIN type_system_sst s ON tpl.system_id = s.id
JOIN phva_stages ph ON tpl.stage_id = ph.id;
Cuatro JOIN encadenados: cada uno agrega el dato pedido (organización, plantilla, sistema, etapa) siguiendo la cadena de llaves foráneas.
Cumple el requisito porque cada fila del resultado trae los cuatro datos que el enunciado pide ver juntos.
4.15
Enunciado: "El estudiante deberá determinar cuántas plantillas tiene asignada cada organización."

SELECT t.nombre, COUNT(tt.id) AS total_plantillas
FROM tenants t
LEFT JOIN tenanttemplates tt ON tt.tenant_id = t.id
GROUP BY t.nombre;
Mismo patrón conteo + LEFT JOIN + GROUP BY.
Cumple el requisito entregando el total de plantillas por organización.
4.16
Enunciado: "El estudiante deberá consultar las organizaciones que actualmente no tengan personas registradas utilizando una combinación externa entre tenants y persons."

SELECT t.*
FROM tenants t
LEFT JOIN persons p ON p.tenant_id = t.id
WHERE p.id IS NULL;
LEFT JOIN ("combinación externa" es justamente el nombre en español de outer join): conserva todas las organizaciones aunque no tengan personas.
WHERE p.id IS NULL: el truco central — si no hubo coincidencia, p.id queda vacío; filtrar por eso aísla las organizaciones "huérfanas" de personas. Se usa IS NULL (no = NULL) porque NULL nunca es igual a nada, ni siquiera a sí mismo.
Cumple el requisito literalmente: usa LEFT JOIN (combinación externa) entre tenants y persons, como pide el enunciado.
4.17
Enunciado: "El estudiante deberá identificar los módulos que todavía no hayan sido asignados a ninguna organización."

SELECT m.*
FROM modules m
LEFT JOIN tenant_modules tm ON tm.module_id = m.id
WHERE tm.module_id IS NULL;
Mismo patrón "outer join + IS NULL" que el punto anterior, ahora sobre módulos.
Cumple el requisito porque aísla los módulos sin ninguna fila relacionada en tenant_modules.
4.18
Enunciado: "El estudiante deberá consultar las etapas PHVA mostrando el número de plantillas que se encuentran asociadas a cada una."

SELECT ph.nombre, COUNT(tpl.id) AS total_plantillas
FROM phva_stages ph
LEFT JOIN templates tpl ON tpl.stage_id = ph.id
GROUP BY ph.nombre;
Cumple el requisito entregando, para cada una de las 4 etapas PHVA, cuántas plantillas le pertenecen.
4.19
Enunciado: "El estudiante deberá determinar cuántas organizaciones se encuentran registradas en cada municipio o ciudad."

SELECT c.nombre AS ciudad, COUNT(t.id) AS total_organizaciones
FROM cities c
LEFT JOIN tenants t ON t.ciudad_id = c.id
GROUP BY c.nombre;
Cumple el requisito agrupando las organizaciones por su ciudad y contando cuántas hay en cada una.
4.20
Enunciado: "El estudiante deberá consultar los cargos existentes en cada organización y determinar cuántas personas ocupan cada cargo."

SELECT t.nombre AS tenant, pos.descripcion AS cargo, COUNT(p.id) AS total_personas
FROM positions pos
JOIN tenants t ON pos.tenant_id = t.id
LEFT JOIN persons p ON p.position_id = pos.id
GROUP BY t.nombre, pos.descripcion;
GROUP BY t.nombre, pos.descripcion: se agrupa por dos columnas porque el enunciado pide el detalle por organización y por cargo dentro de ella (un mismo texto de cargo puede repetirse en distintas organizaciones).
Cumple el requisito mostrando, para cada cargo de cada organización, cuántas personas lo ocupan.
5. Consultas SQL avanzadas
Esta sección trabaja subconsultas, CTE, funciones de ventana, agregaciones condicionales, vistas y vistas materializadas (según el enunciado del examen).

5.1
Enunciado: "El estudiante deberá identificar la organización que tenga la mayor cantidad de personas registradas, mostrando el nombre de la organización y el número total de personas asociadas."

SELECT t.nombre, COUNT(p.id) AS total_personas
FROM tenants t
JOIN persons p ON p.tenant_id = t.id
GROUP BY t.nombre
ORDER BY total_personas DESC
LIMIT 1;
ORDER BY total_personas DESC: ordena de mayor a menor cantidad de personas.
LIMIT 1: corta el resultado a una sola fila, la de mayor valor.
Cumple el requisito porque "la organización que tenga la mayor cantidad" es, precisamente, la primera fila tras ordenar de mayor a menor.
5.2
Enunciado: "El estudiante deberá consultar las organizaciones cuya cantidad de personas registradas sea superior al promedio general de personas por organización."

SELECT t.nombre, COUNT(p.id) AS total_personas
FROM tenants t
JOIN persons p ON p.tenant_id = t.id
GROUP BY t.nombre
HAVING COUNT(p.id) > (
    SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt FROM persons GROUP BY tenant_id
    ) sub
);
Subconsulta interna (SELECT COUNT(*) ... GROUP BY tenant_id): calcula cuántas personas tiene cada tenant, fila por fila.
Subconsulta externa (SELECT AVG(cnt) FROM (...) sub): promedia esos conteos → el "promedio general de personas por organización" (distinto de promediar todas las personas de una vez).
HAVING COUNT(p.id) > (...): compara el conteo de cada grupo contra ese promedio ya calculado.
Cumple el requisito exactamente porque compara cada organización contra el promedio de personas por organización, no contra el total de personas del sistema.
5.3
Enunciado: "El estudiante deberá identificar las organizaciones que tengan habilitados todos los módulos existentes para un sistema SST determinado."

SELECT t.id, t.nombre
FROM tenants t
WHERE NOT EXISTS (
    SELECT m.id FROM modules m
    WHERE m.system_id = (SELECT id FROM type_system_sst WHERE nombre = 'SST')
    AND NOT EXISTS (
        SELECT 1 FROM tenant_modules tm
        WHERE tm.tenant_id = t.id AND tm.module_id = m.id
    )
);
(SELECT id FROM type_system_sst WHERE nombre = 'SST'): subconsulta escalar que resuelve el id del sistema por nombre, en vez de asumir un número fijo (1); así la consulta identifica de forma explícita "un sistema SST determinado" tal como exige el enunciado, y sigue funcionando aunque cambie el orden de inserción del catálogo.
Doble NOT EXISTS: es la llamada "división relacional" — se lee de adentro hacia afuera: "no existe un módulo de ese sistema que la organización NO tenga asignado". Si esa condición interna nunca se cumple para ningún módulo, la organización pasa el filtro externo.
Cumple el requisito porque "tener todos los módulos" no se puede resolver con un simple IN; se necesita verificar que no falte ninguno (doble negación), y el sistema queda determinado dinámicamente por su nombre, no por un id arbitrario.
5.4
Enunciado: "El estudiante deberá determinar las organizaciones que tengan al menos un módulo configurado pero que todavía no tengan plantillas asignadas."

SELECT DISTINCT t.id, t.nombre
FROM tenants t
JOIN tenant_modules tm ON tm.tenant_id = t.id
WHERE t.id NOT IN (SELECT tenant_id FROM tenanttemplates);
JOIN tenant_modules: exige que exista al menos un módulo asignado (si no tuviera ninguno, no aparecería en el join).
NOT IN (SELECT tenant_id FROM tenanttemplates): excluye a las organizaciones que sí tengan alguna plantilla.
DISTINCT: una organización puede tener varios módulos (varias filas en el join); DISTINCT evita que aparezca repetida.
Cumple el requisito combinando ambas condiciones: "al menos un módulo" (JOIN) y "sin plantillas" (NOT IN).
5.5
Enunciado: "El estudiante deberá consultar las organizaciones que tengan plantillas asociadas a todas las etapas PHVA disponibles en el sistema."

SELECT tt.tenant_id
FROM tenanttemplates tt
JOIN templates tpl ON tt.template_id = tpl.id
GROUP BY tt.tenant_id
HAVING COUNT(DISTINCT tpl.stage_id) = (SELECT COUNT(*) FROM phva_stages);
COUNT(DISTINCT tpl.stage_id): cuenta etapas diferentes cubiertas por la organización (sin DISTINCT contaría plantillas repetidas de la misma etapa).
Comparación contra (SELECT COUNT(*) FROM phva_stages): el total de etapas que existen en el catálogo (4, en este proyecto).
Cumple el requisito porque solo pasan las organizaciones cuyo número de etapas distintas cubiertas iguala el total de etapas posibles — es decir, no les falta ninguna.
5.6
Enunciado: "El estudiante deberá calcular la cantidad de plantillas asignadas a cada organización discriminadas por etapa PHVA."

SELECT t.nombre, ph.nombre AS etapa, COUNT(tt.id) AS total
FROM tenanttemplates tt
JOIN tenants t ON tt.tenant_id = t.id
JOIN templates tpl ON tt.template_id = tpl.id
JOIN phva_stages ph ON tpl.stage_id = ph.id
GROUP BY t.nombre, ph.nombre;
GROUP BY t.nombre, ph.nombre: agrupa por dos niveles (organización y etapa) para que "discriminadas por etapa" quede reflejado como una fila por combinación.
Cumple el requisito entregando el detalle pedido: organización + etapa + conteo.
5.7
Enunciado: "El estudiante deberá construir una consulta que presente en columnas independientes la cantidad de plantillas correspondientes a Planear, Hacer, Verificar y Actuar para cada organización."

SELECT t.nombre,
    COUNT(*) FILTER (WHERE ph.nombre = 'Planear')   AS planear,
    COUNT(*) FILTER (WHERE ph.nombre = 'Hacer')      AS hacer,
    COUNT(*) FILTER (WHERE ph.nombre = 'Verificar')  AS verificar,
    COUNT(*) FILTER (WHERE ph.nombre = 'Actuar')     AS actuar
FROM tenanttemplates tt
JOIN tenants t ON tt.tenant_id = t.id
JOIN templates tpl ON tt.template_id = tpl.id
JOIN phva_stages ph ON tpl.stage_id = ph.id
GROUP BY t.nombre;
COUNT(*) FILTER (WHERE ...): es una agregación condicional — cuenta solo las filas que cumplen esa condición, sin necesidad de un CASE anidado dentro de SUM. Cada FILTER se comporta como un contador independiente.
Cumple el requisito literalmente: convierte las 4 etapas en 4 columnas independientes, tal como pide el enunciado (esto es un "pivot" manual).
5.8
Enunciado: "El estudiante deberá determinar el porcentaje que representa cada etapa PHVA sobre el total de plantillas asignadas a una organización."

SELECT t.nombre, ph.nombre AS etapa,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY t.nombre), 2) AS porcentaje
FROM tenanttemplates tt
JOIN tenants t ON tt.tenant_id = t.id
JOIN templates tpl ON tt.template_id = tpl.id
JOIN phva_stages ph ON tpl.stage_id = ph.id
GROUP BY t.nombre, ph.nombre;
SUM(COUNT(*)) OVER (PARTITION BY t.nombre): función de ventana — recalcula el total de plantillas de cada organización sin colapsar las filas por etapa (a diferencia de un segundo GROUP BY, que perdería el detalle de etapa). PARTITION BY define "la ventana" como el conjunto de filas de la misma organización.
* 100.0 / ...: el 100.0 (con decimal) evita que PostgreSQL haga división entera y trunque el resultado a cero.
Cumple el requisito porque cada fila conserva su etapa y además muestra qué porcentaje representa sobre el total de su organización.
5.9
Enunciado: "El estudiante deberá identificar la etapa PHVA que tenga la mayor cantidad de plantillas asignadas dentro de cada organización."

SELECT tenant_nombre, etapa, total FROM (
    SELECT t.nombre AS tenant_nombre, ph.nombre AS etapa, COUNT(*) AS total,
        RANK() OVER (PARTITION BY t.nombre ORDER BY COUNT(*) DESC) AS rnk
    FROM tenanttemplates tt
    JOIN tenants t ON tt.tenant_id = t.id
    JOIN templates tpl ON tt.template_id = tpl.id
    JOIN phva_stages ph ON tpl.stage_id = ph.id
    GROUP BY t.nombre, ph.nombre
) sub
WHERE rnk = 1;
RANK() OVER (PARTITION BY t.nombre ORDER BY COUNT(*) DESC): numera las etapas de cada organización de mayor a menor cantidad de plantillas, reiniciando el ranking en cada partición (cada organización).
WHERE rnk = 1 en la consulta externa: se queda solo con la etapa top de cada organización.
Cumple el requisito porque identifica la etapa líder dentro de cada organización, no un único ganador global.
⚠️ Prerrequisito obligatorio antes de continuar (5.10 en adelante)
Las consultas 5.10 a 5.14, 5.22, 5.23 y 5.24 reutilizan las vistas y vistas materializadas de la sección 6 (así lo piden sus propios enunciados: "utilizando la información disponible en las vistas de resumen"). Si tu \dt no muestra ninguna vista, es porque \dt solo lista tablas — pero si además te da error relation "vm_tenant_docs_summary" does not exist, es porque todavía no las has creado. Ejecuta este bloque completo una sola vez antes de seguir (usa exactamente las 19 tablas que ya tienes):

-- Vista materializada de cumplimiento general (detalle completo en la sección 6.6)
CREATE MATERIALIZED VIEW vm_tenant_docs_summary AS
SELECT t.id AS tenant_id, t.nombre,
    COUNT(d.id) AS total_documentos,
    COUNT(*) FILTER (WHERE d.estado = 'finalizado')   AS finalizados,
    COUNT(*) FILTER (WHERE d.estado = 'borrador')      AS borradores,
    COUNT(*) FILTER (WHERE d.estado = 'no_iniciado')   AS no_iniciados,
    COUNT(*) FILTER (WHERE d.estado = 'pendiente')     AS pendientes,
    ROUND(
      COUNT(*) FILTER (WHERE d.estado = 'finalizado') * 100.0 / NULLIF(COUNT(d.id),0), 2
    ) AS porcentaje_cumplimiento
FROM tenants t
LEFT JOIN documents d ON d.tenant_id = t.id
GROUP BY t.id, t.nombre;

CREATE UNIQUE INDEX idx_vm_tenant_docs_tenant ON vm_tenant_docs_summary (tenant_id);

-- Vistas materializadas por sistema (necesarias para 5.22 y 5.24; detalle en la sección 6.9)
CREATE MATERIALIZED VIEW vm_template_sst_docs_summary AS
SELECT t.id AS tenant_id, t.nombre,
    COUNT(d.id) AS total_documentos,
    COUNT(*) FILTER (WHERE d.estado = 'finalizado') AS finalizados,
    COUNT(*) FILTER (WHERE d.estado = 'pendiente')  AS pendientes,
    ROUND(COUNT(*) FILTER (WHERE d.estado = 'finalizado') * 100.0 / NULLIF(COUNT(d.id),0), 2) AS porcentaje_cumplimiento
FROM tenants t
LEFT JOIN documents d ON d.tenant_id = t.id
LEFT JOIN templates tpl ON tpl.id = d.template_id
    AND tpl.system_id = (SELECT id FROM type_system_sst WHERE nombre = 'SST')
GROUP BY t.id, t.nombre;

CREATE MATERIALIZED VIEW vm_template_pesv_docs_summary AS
SELECT t.id AS tenant_id, t.nombre,
    COUNT(d.id) AS total_documentos,
    COUNT(*) FILTER (WHERE d.estado = 'finalizado') AS finalizados,
    COUNT(*) FILTER (WHERE d.estado = 'pendiente')  AS pendientes,
    ROUND(COUNT(*) FILTER (WHERE d.estado = 'finalizado') * 100.0 / NULLIF(COUNT(d.id),0), 2) AS porcentaje_cumplimiento
FROM tenants t
LEFT JOIN documents d ON d.tenant_id = t.id
LEFT JOIN templates tpl ON tpl.id = d.template_id
    AND tpl.system_id = (SELECT id FROM type_system_sst WHERE nombre = 'PESV')
GROUP BY t.id, t.nombre;
Verifica que ya existen con:

\dm
(\dm lista vistas materializadas; \dv listaría vistas normales — por eso no aparecían en tu \dt, que solo muestra tablas base).

A partir de aquí, 5.10 a 5.14, 5.22, 5.23 y 5.24 funcionan sin cambios: el SQL de esas consultas ya era correcto, solo les faltaba este prerrequisito.

5.10
Enunciado: "El estudiante deberá calcular el porcentaje de documentos finalizados frente al total de documentos asociados a cada organización utilizando la información disponible en las vistas de resumen."

SELECT tenant_id, nombre, total_documentos, finalizados, porcentaje_cumplimiento
FROM vm_tenant_docs_summary;
Esta consulta reutiliza la vista materializada vm_tenant_docs_summary (creada en el bloque de prerrequisitos / sección 6.6), que ya trae el cálculo finalizados * 100.0 / total_documentos resuelto.
Cumple el requisito al pie de la letra: pide explícitamente usar "la información disponible en las vistas de resumen", en vez de recalcular todo desde documents.
5.11
Enunciado: "El estudiante deberá determinar las organizaciones cuyo porcentaje de cumplimiento documental se encuentre por debajo del promedio general del sistema."

SELECT nombre, porcentaje_cumplimiento
FROM vm_tenant_docs_summary
WHERE porcentaje_cumplimiento < (SELECT AVG(porcentaje_cumplimiento) FROM vm_tenant_docs_summary);
Subconsulta escalar (SELECT AVG(...) FROM ...): calcula un único número (el promedio de todas las organizaciones) para comparar contra cada fila.
Cumple el requisito comparando cada organización contra el promedio general, no contra un valor fijo.
5.12
Enunciado: "El estudiante deberá clasificar las organizaciones según su porcentaje de cumplimiento, estableciendo categorías como bajo, medio y alto mediante una expresión CASE."

SELECT nombre, porcentaje_cumplimiento,
    CASE
        WHEN porcentaje_cumplimiento >= 80 THEN 'alto'
        WHEN porcentaje_cumplimiento >= 50 THEN 'medio'
        ELSE 'bajo'
    END AS nivel_cumplimiento
FROM vm_tenant_docs_summary;
CASE WHEN ... THEN ... ELSE ... END: evalúa las condiciones en orden; la primera que se cumpla define el valor. Es una columna calculada, no almacenada.
Cumple el requisito literalmente: usa CASE para traducir un número en una categoría textual.
5.13
Enunciado: "El estudiante deberá generar un ranking de organizaciones de acuerdo con su porcentaje de cumplimiento documental utilizando funciones de ventana."

SELECT nombre, porcentaje_cumplimiento,
    RANK() OVER (ORDER BY porcentaje_cumplimiento DESC) AS ranking
FROM vm_tenant_docs_summary;
RANK() OVER (ORDER BY ... DESC) sin PARTITION BY: al no partir en grupos, la ventana es "todas las filas", así que genera un ranking único y global.
Cumple el requisito usando exactamente una función de ventana (RANK), como exige el enunciado.
5.14
Enunciado: "El estudiante deberá mostrar para cada organización su porcentaje de cumplimiento y la diferencia existente respecto al promedio general de cumplimiento."

SELECT nombre, porcentaje_cumplimiento,
    ROUND(porcentaje_cumplimiento - AVG(porcentaje_cumplimiento) OVER (), 2) AS diferencia_vs_promedio
FROM vm_tenant_docs_summary;
AVG(...) OVER (): función de ventana con paréntesis vacíos — significa "toda la tabla es la ventana"; calcula el promedio global sin colapsar filas (a diferencia de un GROUP BY que dejaría una sola fila).
Cumple el requisito porque cada organización conserva su propio detalle y además exhibe cuánto se aleja del promedio general.
5.15
Enunciado: "El estudiante deberá determinar la cantidad acumulada de documentos finalizados por organización utilizando una función de ventana."

SELECT tenant_id, id, creado_en, estado,
    SUM(CASE WHEN estado = 'finalizado' THEN 1 ELSE 0 END)
        OVER (PARTITION BY tenant_id ORDER BY creado_en, id
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS acumulado_finalizados
FROM documents;
SUM(...) OVER (PARTITION BY tenant_id ORDER BY creado_en, id ...): al llevar ORDER BY dentro de la ventana, la suma se vuelve progresiva (running total) — cada fila suma los finalizados desde el inicio hasta ese punto, reiniciando por organización gracias al PARTITION BY. Se agrega id como segundo criterio de orden para desempatar filas con la misma fecha exacta y que el acumulado quede determinado de forma única.
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW: define el marco de la ventana por fila individual. Sin esto, PostgreSQL usa por defecto RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW, que trata como "un solo bloque" a todas las filas con el mismo valor de ORDER BY (mismo creado_en) y les asigna a todas el mismo acumulado ya incluyendo a las demás — no es un acumulado fila por fila real. ROWS fuerza a que cada fila reciba su propio valor acumulado, uno a la vez.
Cumple el requisito porque entrega un acumulado documento a documento, no un total final único, y es correcto incluso si varios documentos comparten la misma fecha de creación.
5.16
Enunciado: "El estudiante deberá identificar las organizaciones que compartan el mismo municipio pero tengan diferente tamaño empresarial."

SELECT a.nombre AS organizacion_a, b.nombre AS organizacion_b, c.nombre AS ciudad
FROM tenants a
JOIN tenants b ON a.ciudad_id = b.ciudad_id AND a.id < b.id
JOIN cities c ON a.ciudad_id = c.id
WHERE a.tamano_id IS DISTINCT FROM b.tamano_id;
Auto-join (tenants a contra tenants b): compara la tabla consigo misma para encontrar pares de organizaciones.
a.id < b.id: evita comparar una organización consigo misma y evita duplicar el mismo par en ambos sentidos (A-B y B-A).
IS DISTINCT FROM: compara tamaños permitiendo que alguno sea NULL sin comportarse de forma extraña (a diferencia de <>, que con NULL no da ni verdadero ni falso).
Cumple el requisito encontrando pares de organizaciones de la misma ciudad con tamaño distinto.
5.17
Enunciado: "El estudiante deberá encontrar las personas cuyo cargo sea utilizado por más personas que el promedio de ocupación de los cargos dentro de su organización."

WITH ocupacion AS (
    SELECT position_id, tenant_id, COUNT(*) AS total_personas
    FROM persons
    GROUP BY position_id, tenant_id
),
promedio_por_tenant AS (
    SELECT tenant_id, AVG(total_personas) AS promedio
    FROM ocupacion
    GROUP BY tenant_id
)
SELECT p.nombres, p.apellidos, pos.descripcion AS cargo, o.total_personas
FROM persons p
JOIN positions pos ON pos.id = p.position_id
JOIN ocupacion o ON o.position_id = p.position_id AND o.tenant_id = p.tenant_id
JOIN promedio_por_tenant pp ON pp.tenant_id = p.tenant_id
WHERE o.total_personas > pp.promedio;
Dos CTE encadenados: ocupacion cuenta cuántas personas hay por cargo en cada organización; promedio_por_tenant promedia esas ocupaciones por organización. Separarlo en pasos con nombre hace legible una consulta que, escrita de un solo golpe, sería muy difícil de seguir.
Cumple el requisito comparando la ocupación del cargo de cada persona contra el promedio de ocupación de su propia organización (no un promedio global).
Por qué te sale vacía: la consulta está correcta, pero con los datos de prueba de la sección 2.5 cada cargo tiene exactamente 1 persona (nadie comparte cargo todavía), así que el promedio de ocupación de cada organización es 1, y ninguna fila logra "más que el promedio". Para verla funcionar, agrega una segunda persona a un cargo ya existente:

INSERT INTO persons (tenant_id, position_id, nombres, apellidos, correo, activo) VALUES
(1, 3, 'Miguel', 'Torres', 'miguel.torres@andina.com', true);
Con esto, la organización 1 (Andina) queda con ocupación (1, 1, 2) para sus tres cargos → promedio = 1.33 → el cargo "Operario de obra" (2 personas) sí supera el promedio, y la consulta devuelve a Andrés Pérez y Miguel Torres.

5.18
Enunciado: "El estudiante deberá utilizar una expresión común de tabla, CTE, para calcular inicialmente la cantidad de personas por organización y posteriormente seleccionar únicamente las organizaciones que superen el promedio."

WITH conteo_personas AS (
    SELECT tenant_id, COUNT(*) AS total FROM persons GROUP BY tenant_id
)
SELECT t.nombre, cp.total
FROM conteo_personas cp
JOIN tenants t ON t.id = cp.tenant_id
WHERE cp.total > (SELECT AVG(total) FROM conteo_personas);
WITH conteo_personas AS (...): define una tabla temporal, válida solo dentro de esta consulta, que calcula el conteo una sola vez y se reutiliza tanto en el JOIN como en la subconsulta del promedio (evita repetir el mismo GROUP BY dos veces).
Cumple el requisito al pie de la letra: usa un CTE, primero calcula el conteo y después filtra contra el promedio.
5.19
Enunciado: "El estudiante deberá utilizar un CTE para consolidar la cantidad de módulos, plantillas y personas correspondientes a cada organización."

WITH resumen AS (
    SELECT
        t.id,
        t.nombre,
        (SELECT COUNT(*) FROM tenant_modules tm WHERE tm.tenant_id = t.id) AS total_modulos,
        (SELECT COUNT(*) FROM tenanttemplates tt WHERE tt.tenant_id = t.id) AS total_plantillas,
        (SELECT COUNT(*) FROM persons p WHERE p.tenant_id = t.id) AS total_personas
    FROM tenants t
)
SELECT * FROM resumen;
El CTE agrupa tres subconsultas escalares (una por métrica) en una sola definición reutilizable; así el SELECT final queda simple y legible.
Cumple el requisito consolidando en una sola fila por organización los tres conteos pedidos.
5.20
Enunciado: "El estudiante deberá determinar las organizaciones que no tengan configurada alguna etapa PHVA requerida dentro de sus plantillas."

SELECT t.id, t.nombre, ph.nombre AS etapa_faltante
FROM tenants t
CROSS JOIN phva_stages ph
WHERE NOT EXISTS (
    SELECT 1 FROM tenanttemplates tt
    JOIN templates tpl ON tpl.id = tt.template_id
    WHERE tt.tenant_id = t.id AND tpl.stage_id = ph.id
);
CROSS JOIN phva_stages: genera todas las combinaciones posibles organización × etapa (el producto cartesiano); es el punto de partida necesario para poder detectar qué combinaciones "no existen" después.
NOT EXISTS: para cada combinación generada, verifica si existe al menos una plantilla de esa organización en esa etapa; si no existe, esa etapa es una etapa faltante para esa organización.
Cumple el requisito identificando, organización por organización, qué etapas PHVA le faltan por cubrir.
5.21
Enunciado: "El estudiante deberá consultar la última fecha de actualización registrada para cada organización considerando sus plantillas asociadas."

SELECT t.nombre, MAX(tt.actualizado_en) AS ultima_actualizacion
FROM tenanttemplates tt
JOIN tenants t ON tt.tenant_id = t.id
GROUP BY t.nombre;
MAX(tt.actualizado_en): de todas las fechas de actualización de las plantillas de una organización, se queda con la más reciente.
Cumple el requisito entregando una sola fecha por organización: la última modificación registrada entre sus plantillas asignadas.
5.22
Enunciado: "El estudiante deberá determinar cuáles organizaciones presentan registros documentales pendientes utilizando las vistas vm_template_pesv_docs_summary y vm_template_sst_docs_summary."

SELECT s.tenant_id, s.nombre, 'SST' AS sistema, s.pendientes
FROM vm_template_sst_docs_summary s
WHERE s.pendientes > 0
UNION ALL
SELECT p.tenant_id, p.nombre, 'PESV' AS sistema, p.pendientes
FROM vm_template_pesv_docs_summary p
WHERE p.pendientes > 0;
UNION ALL: combina verticalmente los resultados de las dos vistas materializadas (una por sistema) en un solo listado, conservando duplicados si una organización aparece en ambos sistemas (a diferencia de UNION, que eliminaría duplicados exactos innecesariamente aquí, ya que llevan una etiqueta sistema distinta).
Estas dos vistas se crean en la sección 6.9 (son necesarias para este punto y el siguiente).
Cumple el requisito usando exactamente las dos vistas nombradas en el enunciado, filtrando las que tengan pendientes > 0.
5.23
Enunciado: "El estudiante deberá generar un informe consolidado que muestre por organización el total de documentos, documentos finalizados, documentos en borrador, documentos no iniciados, documentos pendientes y porcentaje de cumplimiento."

SELECT nombre, total_documentos, finalizados, borradores, no_iniciados, pendientes, porcentaje_cumplimiento
FROM vm_tenant_docs_summary;
Reutiliza vm_tenant_docs_summary (ampliada en la sección 6.6 para incluir las 4 categorías de estado, no solo finalizados/pendientes).
Cumple el requisito porque expone las seis columnas exactas que pide el enunciado, ya calculadas.
5.24
Enunciado: "El estudiante deberá comparar el porcentaje de cumplimiento SST y PESV de cada organización, identificando aquellas en las cuales exista una diferencia superior a un valor establecido."

SELECT
    s.tenant_id,
    s.nombre,
    s.porcentaje_cumplimiento AS cumplimiento_sst,
    p.porcentaje_cumplimiento AS cumplimiento_pesv,
    ABS(s.porcentaje_cumplimiento - p.porcentaje_cumplimiento) AS diferencia
FROM vm_template_sst_docs_summary s
JOIN vm_template_pesv_docs_summary p ON p.tenant_id = s.tenant_id
WHERE ABS(s.porcentaje_cumplimiento - p.porcentaje_cumplimiento) > 20;
JOIN entre las dos vistas por tenant_id: pone lado a lado el cumplimiento SST y PESV de la misma organización.
ABS(...): valor absoluto de la resta, porque "diferencia superior a un valor" no debe importar cuál de los dos porcentajes es mayor.
Cumple el requisito filtrando solo las organizaciones cuya diferencia (en cualquier dirección) supera el umbral (aquí 20, ajustable al "valor establecido" real).
5.25
Enunciado: "El estudiante deberá construir una vista que consolide la cantidad de personas, módulos, plantillas y sistemas habilitados para cada organización."

CREATE VIEW vw_tenant_resumen_general AS
SELECT
    t.id AS tenant_id,
    t.nombre,
    (SELECT COUNT(*) FROM persons p WHERE p.tenant_id = t.id) AS total_personas,
    (SELECT COUNT(*) FROM tenant_modules tm WHERE tm.tenant_id = t.id) AS total_modulos,
    (SELECT COUNT(*) FROM tenanttemplates tt WHERE tt.tenant_id = t.id) AS total_plantillas,
    (SELECT COUNT(*) FROM tenantsystems ts WHERE ts.tenant_id = t.id) AS total_sistemas
FROM tenants t;
Es prácticamente el mismo cálculo del CTE del punto 5.19, pero guardado como CREATE VIEW para que quede disponible permanentemente y se pueda reutilizar con un simple SELECT * FROM vw_tenant_resumen_general; en cualquier consulta futura.
Cumple el requisito porque entrega, en una sola vista, las cuatro métricas consolidadas por organización que pide el enunciado.
6. Vistas y vistas materializadas
6.1
Enunciado: "El estudiante deberá crear una vista denominada vw_tenant_persons que permita consultar las organizaciones junto con sus personas y cargos asociados."

CREATE VIEW vw_tenant_persons AS
SELECT t.id AS tenant_id, t.nombre AS tenant_nombre,
       p.id AS person_id, p.nombres, p.apellidos, pos.descripcion AS cargo
FROM tenants t
JOIN persons p ON p.tenant_id = t.id
JOIN positions pos ON p.position_id = pos.id;
CREATE VIEW: guarda la definición del SELECT, no los datos; cada vez que consultes vw_tenant_persons, PostgreSQL vuelve a ejecutar el join contra las tablas reales (siempre datos frescos).
Cumple el requisito porque la vista se llama exactamente vw_tenant_persons y junta organización + persona + cargo, tal como pide el enunciado.
6.2
Enunciado: "El estudiante deberá crear una vista que consolide la información geográfica de las organizaciones incluyendo municipio, departamento o región y país."

CREATE VIEW vw_tenant_location AS
SELECT t.id, t.nombre, c.nombre AS ciudad, d.nombre AS departamento, co.nombre AS pais
FROM tenants t
LEFT JOIN cities c ON t.ciudad_id = c.id
LEFT JOIN departments d ON c.departamento_id = d.id
LEFT JOIN countries co ON d.pais_id = co.id;
Cumple el requisito consolidando los tres niveles geográficos (municipio, departamento, país) en una sola vista reutilizable.
6.3
Enunciado: "El estudiante deberá crear una vista que muestre los módulos habilitados para cada organización y el sistema SST al cual pertenecen."

CREATE VIEW vw_tenant_modules_system AS
SELECT t.id AS tenant_id, t.nombre AS tenant_nombre, m.titulo AS modulo, s.nombre AS sistema
FROM tenant_modules tm
JOIN tenants t ON tm.tenant_id = t.id
JOIN modules m ON tm.module_id = m.id
JOIN type_system_sst s ON m.system_id = s.id;
Cumple el requisito mostrando, para cada módulo habilitado de cada organización, a qué sistema SST pertenece.
6.4
Enunciado: "El estudiante deberá crear una vista que presente la cantidad total de plantillas asociadas a cada organización y etapa PHVA."

CREATE VIEW vw_templates_by_stage AS
SELECT t.id AS tenant_id, t.nombre, ph.nombre AS etapa, COUNT(*) AS total
FROM tenanttemplates tt
JOIN tenants t ON tt.tenant_id = t.id
JOIN templates tpl ON tt.template_id = tpl.id
JOIN phva_stages ph ON tpl.stage_id = ph.id
GROUP BY t.id, t.nombre, ph.nombre;
Nota: una vista normal sí puede llevar GROUP BY (a diferencia de la creencia común de que solo sirve para selects simples); guarda la consulta agregada completa.
Cumple el requisito entregando el conteo de plantillas por organización y etapa como una vista reutilizable.
6.5
Enunciado: "El estudiante deberá crear una vista que permita consultar el total de personas existentes por organización y cargo."

CREATE VIEW vw_persons_by_position AS
SELECT t.id AS tenant_id, t.nombre, pos.descripcion AS cargo, COUNT(p.id) AS total
FROM positions pos
JOIN tenants t ON pos.tenant_id = t.id
LEFT JOIN persons p ON p.position_id = pos.id
GROUP BY t.id, t.nombre, pos.descripcion;
Cumple el requisito entregando el total de personas por cargo dentro de cada organización.
6.6
Enunciado: "El estudiante deberá crear una vista materializada que consolide el número total de documentos, documentos finalizados, documentos pendientes y porcentaje de cumplimiento por organización."

CREATE MATERIALIZED VIEW vm_tenant_docs_summary AS
SELECT t.id AS tenant_id, t.nombre,
    COUNT(d.id) AS total_documentos,
    COUNT(*) FILTER (WHERE d.estado = 'finalizado')   AS finalizados,
    COUNT(*) FILTER (WHERE d.estado = 'borrador')      AS borradores,
    COUNT(*) FILTER (WHERE d.estado = 'no_iniciado')   AS no_iniciados,
    COUNT(*) FILTER (WHERE d.estado = 'pendiente')     AS pendientes,
    ROUND(
      COUNT(*) FILTER (WHERE d.estado = 'finalizado') * 100.0 / NULLIF(COUNT(d.id),0), 2
    ) AS porcentaje_cumplimiento
FROM tenants t
LEFT JOIN documents d ON d.tenant_id = t.id
GROUP BY t.id, t.nombre;
MATERIALIZED: a diferencia de una vista normal, guarda físicamente el resultado; se usa aquí porque este cálculo (varios COUNT... FILTER) es costoso y se va a consultar mucho desde dashboards/reportes (5.10, 5.11, 5.23).
NULLIF(COUNT(d.id), 0): si una organización no tiene documentos, COUNT(d.id) es 0; dividir entre 0 rompería la consulta, así que NULLIF convierte ese 0 en NULL, y dividir por NULL da NULL (sin error) en vez de un error de división.
Cumple el requisito incluyendo las 4 categorías de estado más el porcentaje, todo por organización.
6.7
Enunciado: "El estudiante deberá actualizar una vista materializada mediante REFRESH MATERIALIZED VIEW y verificar que los valores consolidados reflejen los últimos cambios realizados en las tablas relacionadas."

-- 1) Genera un cambio real en los datos base:
UPDATE documents SET estado = 'finalizado' WHERE id = 2;

-- 2) Refresca la vista materializada:
REFRESH MATERIALIZED VIEW vm_tenant_docs_summary;

-- 3) Verifica que el cambio ya se refleja:
SELECT * FROM vm_tenant_docs_summary WHERE tenant_id = 1;
REFRESH MATERIALIZED VIEW: recalcula y reemplaza el contenido guardado de la vista; es obligatorio ejecutarlo tras cada cambio relevante, porque a diferencia de una vista normal, esta no se actualiza sola.
Cumple el requisito mostrando el ciclo completo: cambio en la tabla base → REFRESH → verificación de que el número cambió.
6.8
Enunciado: "El estudiante deberá analizar qué columnas de la vista materializada deberían contar con índices para optimizar las consultas de seguimiento por organización."

CREATE UNIQUE INDEX idx_vm_tenant_docs_tenant ON vm_tenant_docs_summary (tenant_id);
CREATE INDEX: se usa sobre tenant_id porque es la columna por la que casi siempre se va a filtrar o unir ("consultas de seguimiento por organización"); sin índice, cada consulta recorrería la vista completa.
UNIQUE: además de acelerar la búsqueda, garantiza que no haya dos filas para el mismo tenant y habilita REFRESH MATERIALIZED VIEW CONCURRENTLY (refrescar sin bloquear lecturas simultáneas).
Cumple el requisito identificando y creando el índice sobre la columna clave de acceso (tenant_id).
6.9 Vistas materializadas adicionales (necesarias para las consultas 5.22 y 5.24)
El examen nombra estas dos vistas por sistema, así que hay que crearlas explícitamente:

CREATE MATERIALIZED VIEW vm_template_sst_docs_summary AS
SELECT t.id AS tenant_id, t.nombre,
    COUNT(d.id) AS total_documentos,
    COUNT(*) FILTER (WHERE d.estado = 'finalizado') AS finalizados,
    COUNT(*) FILTER (WHERE d.estado = 'pendiente')  AS pendientes,
    ROUND(COUNT(*) FILTER (WHERE d.estado = 'finalizado') * 100.0 / NULLIF(COUNT(d.id),0), 2) AS porcentaje_cumplimiento
FROM tenants t
LEFT JOIN documents d ON d.tenant_id = t.id
LEFT JOIN templates tpl ON tpl.id = d.template_id
    AND tpl.system_id = (SELECT id FROM type_system_sst WHERE nombre = 'SST')
GROUP BY t.id, t.nombre;

CREATE MATERIALIZED VIEW vm_template_pesv_docs_summary AS
SELECT t.id AS tenant_id, t.nombre,
    COUNT(d.id) AS total_documentos,
    COUNT(*) FILTER (WHERE d.estado = 'finalizado') AS finalizados,
    COUNT(*) FILTER (WHERE d.estado = 'pendiente')  AS pendientes,
    ROUND(COUNT(*) FILTER (WHERE d.estado = 'finalizado') * 100.0 / NULLIF(COUNT(d.id),0), 2) AS porcentaje_cumplimiento
FROM tenants t
LEFT JOIN documents d ON d.tenant_id = t.id
LEFT JOIN templates tpl ON tpl.id = d.template_id
    AND tpl.system_id = (SELECT id FROM type_system_sst WHERE nombre = 'PESV')
GROUP BY t.id, t.nombre;
(SELECT id FROM type_system_sst WHERE nombre = 'SST' / 'PESV'): igual que en la corrección del ejercicio 5.3, resuelve el id del sistema por nombre en vez de asumir un número fijo — así la vista sigue siendo correcta sin importar el orden en que se hayan insertado los sistemas.
Esa subconsulta va dentro de la condición del ON (no en un WHERE): como es un LEFT JOIN, si el filtro estuviera en WHERE, PostgreSQL evaluaría el filtro después del join y descartaría las filas sin coincidencia, comportándose como un INNER JOIN y haciendo desaparecer a las organizaciones sin documentos de ese sistema. Puesto en el ON, el filtro solo decide qué filas de templates califican para unirse, pero la organización sigue apareciendo (con ceros) aunque ningún documento suyo pertenezca a ese sistema.
Cumple el requisito de la sección 5 al proveer, por separado y de forma correcta, el resumen documental de SST y de PESV para cada organización.
7. Procedimientos almacenados (CALL)
7.1
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita registrar una nueva organización, validando previamente que no exista otra organización con los mismos datos de identificación definidos por el sistema."

CREATE OR REPLACE PROCEDURE sp_create_tenant(
    p_nombre VARCHAR, p_nit VARCHAR, p_correo VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM tenants WHERE nit = p_nit) THEN
        RAISE EXCEPTION 'Ya existe una organización con NIT %', p_nit;
    END IF;
    INSERT INTO tenants (nombre, nit, correo_contacto) VALUES (p_nombre, p_nit, p_correo);
END;
$$;

CALL sp_create_tenant('Cybertec','900123456-1','a@a.com');
CREATE OR REPLACE PROCEDURE ... LANGUAGE plpgsql: define un objeto que se ejecuta con CALL (no se consulta con SELECT), pensado para realizar una acción.
BEGIN ... END;: delimita el cuerpo del procedimiento en PL/pgSQL (no es una transacción manual, es la sintaxis obligatoria del bloque).
IF EXISTS (...) THEN RAISE EXCEPTION ... END IF;: valida primero la regla de negocio ("no exista otra organización con el mismo NIT") y, si se viola, aborta antes de llegar al INSERT.
Cumple el requisito porque valida duplicados antes de insertar, exactamente como pide el enunciado ("validando previamente").
7.2
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita registrar una nueva persona y asociarla a una organización y a un cargo determinado."

CREATE OR REPLACE PROCEDURE sp_create_person(
    p_tenant_id INT, p_position_id INT, p_nombres VARCHAR, p_apellidos VARCHAR, p_correo VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO persons (tenant_id, position_id, nombres, apellidos, correo)
    VALUES (p_tenant_id, p_position_id, p_nombres, p_apellidos, p_correo);
END;
$$;
Los parámetros p_tenant_id y p_position_id son justamente "una organización y un cargo determinado" que pide el enunciado.
Cumple el requisito insertando la persona ya asociada a ambos datos en una sola operación.
7.3
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita cambiar el estado de una organización entre activa e inactiva."

CREATE OR REPLACE PROCEDURE sp_toggle_tenant_status(p_tenant_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE tenants SET activo = NOT activo WHERE id = p_tenant_id;
END;
$$;
NOT activo: invierte el booleano actual (si era true pasa a false y viceversa) — es la forma más directa de implementar "cambiar entre activa e inactiva" sin necesitar saber el valor actual de antemano.
Cumple el requisito alternando el estado con una sola sentencia.
7.4
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita asignar un módulo determinado a una organización evitando asignaciones duplicadas."

CREATE OR REPLACE PROCEDURE sp_assign_module(p_tenant_id INT, p_module_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM tenant_modules WHERE tenant_id = p_tenant_id AND module_id = p_module_id) THEN
        RAISE NOTICE 'El módulo % ya estaba asignado a la organización %', p_module_id, p_tenant_id;
        RETURN;
    END IF;
    INSERT INTO tenant_modules (tenant_id, module_id) VALUES (p_tenant_id, p_module_id);
END;
$$;
RAISE NOTICE + RETURN: si ya existe, avisa y termina ahí mismo sin llegar al INSERT (RETURN dentro de un procedimiento simplemente corta la ejecución, no "devuelve" un valor).
Cumple el requisito evitando duplicados de forma explícita, con aviso incluido.
7.5
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita habilitar un sistema SST para una organización determinada."

CREATE OR REPLACE PROCEDURE sp_enable_system(p_tenant_id INT, p_system_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO tenantsystems (tenant_id, system_id)
    VALUES (p_tenant_id, p_system_id)
    ON CONFLICT DO NOTHING;
END;
$$;
ON CONFLICT DO NOTHING: aprovecha que tenantsystems tiene llave primaria compuesta (tenant_id, system_id); si el par ya existe, simplemente no hace nada, en vez de lanzar un error de duplicado.
Cumple el requisito habilitando el sistema de forma segura, sin fallar si ya estaba habilitado.
7.6
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita asignar una plantilla a una organización indicando sistema, etapa PHVA y formato correspondiente."

CREATE OR REPLACE PROCEDURE sp_assign_template(
    p_tenant_id INT, p_system_id INT, p_stage_id INT, p_format_id INT
)
LANGUAGE plpgsql AS $$
DECLARE
    v_template_id INT;
BEGIN
    SELECT id INTO v_template_id FROM templates
    WHERE system_id = p_system_id AND stage_id = p_stage_id AND format_id = p_format_id
    LIMIT 1;

    IF v_template_id IS NULL THEN
        RAISE EXCEPTION 'No existe una plantilla para ese sistema/etapa/formato';
    END IF;

    INSERT INTO tenanttemplates (tenant_id, template_id) VALUES (p_tenant_id, v_template_id);
END;
$$;
DECLARE v_template_id INT;: reserva una variable temporal para "recordar" el id de la plantilla encontrada.
SELECT id INTO v_template_id: guarda el resultado de la búsqueda en la variable, en vez de mostrarlo.
Cumple el requisito recibiendo exactamente los tres criterios (sistema, etapa, formato) que el enunciado pide para localizar la plantilla correcta.
7.7
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita cambiar el cargo de una persona dentro de una organización."

CREATE OR REPLACE PROCEDURE sp_change_position(p_person_id INT, p_position_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE persons SET position_id = p_position_id WHERE id = p_person_id;
END;
$$;
Cumple el requisito con un UPDATE directo sobre la columna position_id.
7.8
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita trasladar una persona de una organización a otra, actualizando las relaciones necesarias."

CREATE OR REPLACE PROCEDURE sp_transfer_person(p_person_id INT, p_new_tenant_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE persons
    SET tenant_id = p_new_tenant_id, position_id = NULL
    WHERE id = p_person_id;
END;
$$;
position_id = NULL: "actualizando las relaciones necesarias" incluye soltar el cargo anterior, porque ese cargo pertenece a la organización de origen (el trigger 9.6 impediría dejarlo si no coincide con el nuevo tenant).
Cumple el requisito actualizando ambas relaciones (organización y cargo) en una sola operación consistente.
7.9
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita deshabilitar todos los módulos asociados a una organización que haya sido marcada como inactiva."

CREATE OR REPLACE PROCEDURE sp_disable_modules_if_inactive(p_tenant_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF (SELECT activo FROM tenants WHERE id = p_tenant_id) = false THEN
        DELETE FROM tenant_modules WHERE tenant_id = p_tenant_id;
    END IF;
END;
$$;
IF (SELECT activo ...) = false THEN: valida la condición ("que haya sido marcada como inactiva") antes de ejecutar el DELETE.
Cumple el requisito eliminando los módulos solo si la organización efectivamente está inactiva.
7.10
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita eliminar de manera controlada una asignación de módulo, validando previamente que no existan registros dependientes que impidan la operación."

CREATE OR REPLACE PROCEDURE sp_remove_module_assignment(p_tenant_id INT, p_module_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM formats_sst f
        JOIN templates tpl ON tpl.format_id = f.id
        JOIN tenanttemplates tt ON tt.template_id = tpl.id
        WHERE tt.tenant_id = p_tenant_id AND f.module_id = p_module_id
    ) THEN
        RAISE EXCEPTION 'No se puede eliminar: existen plantillas asignadas dependientes de ese módulo';
    END IF;

    DELETE FROM tenant_modules WHERE tenant_id = p_tenant_id AND module_id = p_module_id;
END;
$$;
La validación recorre la cadena formats_sst → templates → tenanttemplates para comprobar si el módulo tiene plantillas asignadas dependientes antes de borrar.
Cumple el requisito ("de manera controlada... validando previamente") al impedir el borrado cuando hay dependientes.
7.11
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que determine el número total de plantillas asociadas a una organización y muestre el resultado mediante RAISE NOTICE."

CREATE OR REPLACE PROCEDURE sp_count_templates(p_tenant_id INT)
LANGUAGE plpgsql AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total FROM tenanttemplates WHERE tenant_id = p_tenant_id;
    RAISE NOTICE 'La organización % tiene % plantillas asignadas', p_tenant_id, v_total;
END;
$$;
RAISE NOTICE 'texto %', valor: imprime un mensaje informativo en la consola de psql, sin detener la ejecución ni devolver una fila de resultado.
Cumple el requisito literalmente: calcula el total y lo muestra mediante RAISE NOTICE, tal como exige el enunciado.
7.12
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que determine el porcentaje de cumplimiento documental de una organización a partir de sus documentos finalizados y pendientes."

CREATE OR REPLACE PROCEDURE sp_compliance_percentage(p_tenant_id INT)
LANGUAGE plpgsql AS $$
DECLARE
    v_finalizados INT;
    v_total INT;
BEGIN
    SELECT COUNT(*) FILTER (WHERE estado = 'finalizado'), COUNT(*)
    INTO v_finalizados, v_total
    FROM documents WHERE tenant_id = p_tenant_id;

    IF v_total = 0 THEN
        RAISE NOTICE 'La organización % no tiene documentos registrados', p_tenant_id;
    ELSE
        RAISE NOTICE 'Cumplimiento: %%%', ROUND(v_finalizados * 100.0 / v_total, 2);
    END IF;
END;
$$;
SELECT ... INTO v_finalizados, v_total: una sola consulta llena dos variables a la vez, en el mismo orden en que se listan.
Cumple el requisito calculando el porcentaje a partir justamente de finalizados y del total de documentos.
7.13
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que reciba una organización y una etapa PHVA y determine la cantidad de documentos correspondientes a dicha etapa."

CREATE OR REPLACE PROCEDURE sp_docs_by_stage(p_tenant_id INT, p_stage_id INT)
LANGUAGE plpgsql AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM documents d
    JOIN templates tpl ON tpl.id = d.template_id
    WHERE d.tenant_id = p_tenant_id AND tpl.stage_id = p_stage_id;

    RAISE NOTICE 'Documentos en la etapa %: %', p_stage_id, v_total;
END;
$$;
El JOIN con templates es necesario porque documents no guarda la etapa directamente; se llega a ella a través de la plantilla.
Cumple el requisito recibiendo ambos parámetros (organización y etapa) y devolviendo el conteo correspondiente.
7.14
Enunciado: "El estudiante deberá desarrollar un procedimiento almacenado que permita modificar simultáneamente los datos de contacto de una organización y registre la fecha de actualización correspondiente."

CREATE OR REPLACE PROCEDURE sp_update_contact(p_tenant_id INT, p_correo VARCHAR, p_telefono VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE tenants
    SET correo_contacto = p_correo, telefono = p_telefono, actualizado_en = now()
    WHERE id = p_tenant_id;
END;
$$;
Un solo UPDATE cambia tres columnas a la vez (correo, teléfono y fecha) — "simultáneamente" se traduce en una sola sentencia, no en tres UPDATE separados.
Cumple el requisito actualizando datos de contacto y registrando la fecha en la misma operación.
7.15
Enunciado: "El estudiante deberá implementar manejo de excepciones dentro de un procedimiento encargado de asignar plantillas, de manera que cualquier error producido durante la operación pueda ser controlado adecuadamente."

CREATE OR REPLACE PROCEDURE sp_assign_template_safe(
    p_tenant_id INT, p_template_id INT
)
LANGUAGE plpgsql AS $$
BEGIN
    BEGIN
        INSERT INTO tenanttemplates (tenant_id, template_id) VALUES (p_tenant_id, p_template_id);
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE NOTICE 'La organización o la plantilla no existen';
        WHEN unique_violation THEN
            RAISE NOTICE 'Esa plantilla ya estaba asignada';
        WHEN OTHERS THEN
            RAISE NOTICE 'Error inesperado: %', SQLERRM;
    END;
END;
$$;
BEGIN ... EXCEPTION WHEN condición THEN ... END; (bloque interno): aísla la operación riesgosa (INSERT) para poder capturar errores específicos por nombre, en vez de dejar que cualquier error tumbe todo el procedimiento.
WHEN OTHERS THEN ... SQLERRM: red de seguridad final que captura cualquier error no anticipado y muestra el mensaje real que dio PostgreSQL.
Cumple el requisito ("cualquier error... pueda ser controlado adecuadamente") cubriendo tanto los errores esperables como uno genérico de respaldo.
8. Funciones almacenadas
8.1
Enunciado: "El estudiante deberá implementar una función que reciba el identificador de una organización y retorne la cantidad total de personas asociadas."

CREATE OR REPLACE FUNCTION fn_total_persons(p_tenant_id INT)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total FROM persons WHERE tenant_id = p_tenant_id;
    RETURN v_total;
END;
$$;

SELECT fn_total_persons(1);
RETURNS INT: a diferencia de un procedimiento, una función debe declarar qué tipo de valor entrega; eso es lo que permite usarla dentro de un SELECT como si fuera una columna calculada.
Cumple el requisito: recibe el id de la organización y retorna un número, exactamente lo pedido.
8.2
Enunciado: "El estudiante deberá implementar una función que reciba el identificador de una organización y retorne su porcentaje de cumplimiento documental."

CREATE OR REPLACE FUNCTION fn_compliance_percentage(p_tenant_id INT)
RETURNS NUMERIC LANGUAGE plpgsql AS $$
DECLARE v_pct NUMERIC;
BEGIN
    SELECT ROUND(COUNT(*) FILTER (WHERE estado='finalizado') * 100.0 / NULLIF(COUNT(*),0), 2)
    INTO v_pct FROM documents WHERE tenant_id = p_tenant_id;
    RETURN COALESCE(v_pct, 0);
END;
$$;
COALESCE(v_pct, 0): si la organización no tiene documentos, v_pct queda NULL; COALESCE lo reemplaza por 0 para no devolver un valor vacío.
Cumple el requisito retornando un único número (el porcentaje) por organización.
8.3
Enunciado: "El estudiante deberá implementar una función que determine si una organización tiene habilitado un módulo específico y retorne un valor booleano."

CREATE OR REPLACE FUNCTION fn_has_module(p_tenant_id INT, p_module_id INT)
RETURNS BOOLEAN LANGUAGE plpgsql AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM tenant_modules WHERE tenant_id = p_tenant_id AND module_id = p_module_id
    );
END;
$$;
RETURNS BOOLEAN + EXISTS(...): EXISTS ya devuelve true/false por sí mismo, así que se retorna directamente sin variable intermedia.
Cumple el requisito retornando exactamente un booleano.
8.4
Enunciado: "El estudiante deberá implementar una función que reciba el identificador de una persona y retorne su nombre completo."

CREATE OR REPLACE FUNCTION fn_full_name(p_person_id INT)
RETURNS VARCHAR LANGUAGE plpgsql AS $$
DECLARE v_nombre_completo VARCHAR;
BEGIN
    SELECT nombres || ' ' || apellidos INTO v_nombre_completo FROM persons WHERE id = p_person_id;
    RETURN v_nombre_completo;
END;
$$;
||: operador de concatenación de texto en PostgreSQL; une nombres, un espacio y apellidos en un solo valor.
Cumple el requisito retornando el nombre completo como un único texto.
8.5
Enunciado: "El estudiante deberá implementar una función que retorne la cantidad de plantillas existentes para una organización y una etapa PHVA determinada."

CREATE OR REPLACE FUNCTION fn_templates_by_stage(p_tenant_id INT, p_stage_id INT)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM tenanttemplates tt JOIN templates tpl ON tpl.id = tt.template_id
    WHERE tt.tenant_id = p_tenant_id AND tpl.stage_id = p_stage_id;
    RETURN v_total;
END;
$$;
Cumple el requisito recibiendo ambos parámetros y retornando el conteo puntual pedido.
8.6
Enunciado: "El estudiante deberá implementar una función tabular que retorne todos los módulos habilitados para una organización."

CREATE OR REPLACE FUNCTION fn_tenant_modules(p_tenant_id INT)
RETURNS TABLE(module_id INT, titulo VARCHAR) LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT m.id, m.titulo FROM tenant_modules tm
    JOIN modules m ON m.id = tm.module_id
    WHERE tm.tenant_id = p_tenant_id;
END;
$$;

SELECT * FROM fn_tenant_modules(1);
RETURNS TABLE(...) + RETURN QUERY: a diferencia de las funciones anteriores (que devuelven un solo valor), esta devuelve varias filas; se consulta igual que una tabla con SELECT * FROM fn(...).
Cumple el requisito ("función tabular") devolviendo el listado completo de módulos, no un solo dato.
8.7
Enunciado: "El estudiante deberá implementar una función tabular que retorne las personas pertenecientes a una organización junto con sus respectivos cargos."

CREATE OR REPLACE FUNCTION fn_persons_with_position(p_tenant_id INT)
RETURNS TABLE(person_id INT, nombre_completo TEXT, cargo VARCHAR) LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT p.id, p.nombres || ' ' || p.apellidos, pos.descripcion
    FROM persons p
    JOIN positions pos ON pos.id = p.position_id
    WHERE p.tenant_id = p_tenant_id;
END;
$$;
Cumple el requisito devolviendo, fila por fila, cada persona de la organización junto a su cargo.
8.8
Enunciado: "El estudiante deberá implementar una función que clasifique el nivel de cumplimiento de una organización como bajo, medio o alto según el porcentaje calculado."

CREATE OR REPLACE FUNCTION fn_compliance_level(p_tenant_id INT)
RETURNS VARCHAR LANGUAGE plpgsql AS $$
DECLARE v_pct NUMERIC;
BEGIN
    v_pct := fn_compliance_percentage(p_tenant_id);
    RETURN CASE
        WHEN v_pct >= 80 THEN 'alto'
        WHEN v_pct >= 50 THEN 'medio'
        ELSE 'bajo'
    END;
END;
$$;
Esta función llama a otra función (fn_compliance_percentage, punto 8.2) en vez de recalcular el porcentaje — evita duplicar lógica.
CASE dentro de RETURN: clasifica el número en una de las tres categorías textuales.
Cumple el requisito retornando exactamente 'bajo', 'medio' o 'alto' según el porcentaje.
9. Triggers
9.1 y 9.2
Enunciados: "...trigger que actualice automáticamente el campo updated_at cada vez que se modifique un registro de la tabla tenants" / "...cuando se modifique información de una persona."

CREATE OR REPLACE FUNCTION trg_set_updated_at()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    NEW.actualizado_en := now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tenants_updated_at
BEFORE UPDATE ON tenants
FOR EACH ROW EXECUTE FUNCTION trg_set_updated_at();

CREATE TRIGGER trg_persons_updated_at
BEFORE UPDATE ON persons
FOR EACH ROW EXECUTE FUNCTION trg_set_updated_at();
RETURNS trigger: tipo especial de retorno obligatorio para toda función usada como trigger.
BEFORE UPDATE ... FOR EACH ROW: se ejecuta antes de que la fila se guarde (así se puede modificar NEW) y una vez por cada fila afectada por el UPDATE.
NEW.actualizado_en := now(): NEW representa la fila con los valores nuevos que está a punto de guardarse; se le sobreescribe la fecha con la hora actual.
Cumple el requisito de ambos enunciados con una sola función reutilizada en las dos tablas: la fecha se actualiza sola, sin que el usuario tenga que escribirla.
9.3
Enunciado: "El estudiante deberá implementar un trigger que impida registrar una persona en una organización que se encuentre inactiva."

CREATE OR REPLACE FUNCTION trg_check_tenant_active()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NOT (SELECT activo FROM tenants WHERE id = NEW.tenant_id) THEN
        RAISE EXCEPTION 'No se puede registrar una persona en una organización inactiva';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_persons_check_tenant
BEFORE INSERT ON persons
FOR EACH ROW EXECUTE FUNCTION trg_check_tenant_active();
BEFORE INSERT: se valida antes de que la fila entre a la tabla, para poder rechazarla a tiempo con RAISE EXCEPTION (que aborta toda la transacción).
Cumple el requisito impidiendo exactamente el caso descrito: probarlo con tenant_id = 3 (Textiles, inactiva) debe fallar.
9.4
Enunciado: "El estudiante deberá implementar un trigger que impida asignar un módulo a una organización cuando dicho módulo ya se encuentre previamente asignado."

CREATE OR REPLACE FUNCTION trg_check_module_duplicate()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM tenant_modules WHERE tenant_id = NEW.tenant_id AND module_id = NEW.module_id) THEN
        RAISE EXCEPTION 'El módulo % ya está asignado a la organización %', NEW.module_id, NEW.tenant_id;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tenant_modules_no_dup
BEFORE INSERT ON tenant_modules
FOR EACH ROW EXECUTE FUNCTION trg_check_module_duplicate();
Es una segunda capa de protección además de la PRIMARY KEY (tenant_id, module_id): la llave primaria rechazaría el duplicado con un error genérico de PostgreSQL; este trigger da un mensaje de negocio más claro antes de llegar a ese error.
Cumple el requisito bloqueando la asignación duplicada con un mensaje explicativo.
9.5
Enunciado: "El estudiante deberá implementar un trigger que impida asignar plantillas a organizaciones cuyo estado se encuentre inactivo."

CREATE OR REPLACE FUNCTION trg_check_tenant_active_template()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NOT (SELECT activo FROM tenants WHERE id = NEW.tenant_id) THEN
        RAISE EXCEPTION 'No se pueden asignar plantillas a una organización inactiva';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tenanttemplates_check_tenant
BEFORE INSERT ON tenanttemplates
FOR EACH ROW EXECUTE FUNCTION trg_check_tenant_active_template();
Mismo patrón que 9.3, pero sobre tenanttemplates en vez de persons.
Cumple el requisito rechazando el INSERT cuando la organización destino está inactiva.
9.6
Enunciado: "El estudiante deberá implementar un trigger que valide que una persona únicamente pueda ser asociada a un cargo perteneciente a la misma organización."

CREATE OR REPLACE FUNCTION trg_check_position_tenant()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.position_id IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM positions WHERE id = NEW.position_id AND tenant_id = NEW.tenant_id
    ) THEN
        RAISE EXCEPTION 'El cargo no pertenece a la organización de la persona';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_persons_check_position
BEFORE INSERT OR UPDATE ON persons
FOR EACH ROW EXECUTE FUNCTION trg_check_position_tenant();
BEFORE INSERT OR UPDATE: se valida en ambos eventos, porque el cargo de una persona puede asignarse al crearla o cambiarse después (procedimiento 7.7).
NEW.position_id IS NOT NULL AND ...: se permite dejar el cargo vacío (NULL, como en un traslado, procedimiento 7.8); la validación solo aplica cuando sí se está asignando un cargo.
Cumple el requisito comparando tenant_id de la persona contra el tenant_id del cargo que se le quiere asignar.
9.7
Enunciado: "El estudiante deberá implementar un trigger que registre automáticamente la fecha de actualización cuando se produzca una modificación en una plantilla asignada a una organización."

CREATE TRIGGER trg_tenanttemplates_updated_at
BEFORE UPDATE ON tenanttemplates
FOR EACH ROW EXECUTE FUNCTION trg_set_updated_at();
Reutiliza la función del punto 9.1-9.2: la misma lógica genérica (NEW.actualizado_en := now()) sirve para cualquier tabla que tenga esa columna, sin reescribirla.
Cumple el requisito con una sola línea adicional, gracias a la reutilización del trigger genérico.
9.8
Enunciado: "El estudiante deberá implementar un trigger que impida eliminar una organización cuando todavía existan personas asociadas a ella."

CREATE OR REPLACE FUNCTION trg_prevent_tenant_delete()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM persons WHERE tenant_id = OLD.id) THEN
        RAISE EXCEPTION 'No se puede eliminar la organización: tiene personas asociadas';
    END IF;
    RETURN OLD;
END;
$$;

CREATE TRIGGER trg_tenants_before_delete
BEFORE DELETE ON tenants
FOR EACH ROW EXECUTE FUNCTION trg_prevent_tenant_delete();
OLD en vez de NEW: en un DELETE no hay fila "nueva", solo la fila que está a punto de desaparecer (OLD).
RETURN OLD: en triggers BEFORE DELETE, se debe retornar OLD para permitir que el borrado continúe (si no se lanzó excepción antes).
Cumple el requisito bloqueando el DELETE mientras existan personas dependientes.
9.9
Enunciado: "El estudiante deberá implementar un trigger que impida eliminar un sistema SST cuando existan organizaciones que lo estén utilizando."

CREATE OR REPLACE FUNCTION trg_prevent_system_delete()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM tenantsystems WHERE system_id = OLD.id) THEN
        RAISE EXCEPTION 'No se puede eliminar el sistema: está en uso por organizaciones';
    END IF;
    RETURN OLD;
END;
$$;

CREATE TRIGGER trg_type_system_before_delete
BEFORE DELETE ON type_system_sst
FOR EACH ROW EXECUTE FUNCTION trg_prevent_system_delete();
Mismo patrón que 9.8, verificando dependientes en tenantsystems en vez de persons.
Cumple el requisito protegiendo la integridad del catálogo de sistemas SST.
9.10
Enunciado: "El estudiante deberá implementar un trigger que impida eliminar un módulo cuando dicho módulo esté asignado a una o más organizaciones."

CREATE OR REPLACE FUNCTION trg_prevent_module_delete()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM tenant_modules WHERE module_id = OLD.id) THEN
        RAISE EXCEPTION 'No se puede eliminar el módulo: está asignado a organizaciones';
    END IF;
    RETURN OLD;
END;
$$;

CREATE TRIGGER trg_modules_before_delete
BEFORE DELETE ON modules
FOR EACH ROW EXECUTE FUNCTION trg_prevent_module_delete();
Cumple el requisito con el mismo patrón de protección, ahora sobre modules.
9.11
Enunciado: "El estudiante deberá implementar un trigger que valide que el porcentaje de cumplimiento calculado para una organización permanezca dentro del rango comprendido entre 0 y 100."

ALTER TABLE tenants ADD COLUMN porcentaje_cumplimiento NUMERIC;

CREATE OR REPLACE FUNCTION trg_validate_compliance_range()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.porcentaje_cumplimiento < 0 OR NEW.porcentaje_cumplimiento > 100 THEN
        RAISE EXCEPTION 'El porcentaje de cumplimiento debe estar entre 0 y 100';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tenants_check_compliance
BEFORE INSERT OR UPDATE ON tenants
FOR EACH ROW EXECUTE FUNCTION trg_validate_compliance_range();
Se agrega la columna primero porque el modelo original no la tenía (el porcentaje se calculaba con vistas, no se guardaba); aquí el enunciado pide validar un valor guardado, así que hace falta la columna.
BEFORE INSERT OR UPDATE: valida tanto al crear como al modificar ese valor.
Cumple el requisito rechazando cualquier valor fuera de 0-100 (alternativa equivalente sería un CHECK, pero aquí se pide explícitamente el mecanismo de trigger).
9.12 y 9.13
Enunciados: "...trigger que registre en una tabla de auditoría cualquier modificación realizada sobre los datos principales de una organización" / "...trigger de auditoría que almacene el valor anterior y el nuevo valor cuando se modifique el estado de una organización."

CREATE OR REPLACE FUNCTION trg_audit_tenant()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF OLD.activo IS DISTINCT FROM NEW.activo THEN
        INSERT INTO tenant_audit (tenant_id, campo, valor_anterior, valor_nuevo, modificado_por)
        VALUES (NEW.id, 'activo', OLD.activo::TEXT, NEW.activo::TEXT, current_user);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tenants_audit
AFTER UPDATE ON tenants
FOR EACH ROW EXECUTE FUNCTION trg_audit_tenant();
AFTER UPDATE (no BEFORE): aquí solo se registra el cambio ya ocurrido, no se necesita modificar la fila antes de guardarla.
IS DISTINCT FROM: compara OLD contra NEW de forma segura incluso si alguno fuera NULL (a diferencia de <>, que con NULL no da ni verdadero ni falso, sino "desconocido").
OLD.activo::TEXT: convierte el booleano a texto para poder guardarlo en la columna valor_anterior (que es TEXT porque debe servir para auditar cualquier tipo de campo, no solo booleanos).
Cumple ambos requisitos a la vez: registra la modificación en tenant_audit (9.12) guardando explícitamente el valor anterior y el nuevo (9.13).
9.14
Enunciado: "El estudiante deberá implementar un trigger que registre la fecha y el usuario responsable cuando una plantilla sea modificada."

CREATE OR REPLACE FUNCTION trg_template_audit()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    NEW.actualizado_en := now();
    NEW.actualizado_por := current_user;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tenanttemplates_audit
BEFORE UPDATE ON tenanttemplates
FOR EACH ROW EXECUTE FUNCTION trg_template_audit();
current_user: variable de sistema de PostgreSQL con el nombre del rol/usuario que está ejecutando la sentencia — es la forma nativa de saber "quién" hizo el cambio sin que la aplicación tenga que enviarlo aparte.
Cumple el requisito guardando fecha (actualizado_en) y usuario (actualizado_por) automáticamente en cada modificación.
9.15
Enunciado: "El estudiante deberá implementar un trigger que elimine o marque como inactivos los bloqueos de edición vencidos almacenados en editing_locks."

CREATE OR REPLACE FUNCTION trg_clean_expired_locks()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM editing_locks WHERE expira_en < now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_editing_locks_cleanup
BEFORE INSERT ON editing_locks
FOR EACH ROW EXECUTE FUNCTION trg_clean_expired_locks();
Un trigger reacciona a un evento sobre una fila concreta, no puede "vigilar el reloj" solo; por eso la limpieza se dispara aprovechando cada INSERT nuevo (cuando alguien va a bloquear un recurso, de paso se purgan los bloqueos ya vencidos de cualquier fila).
Cumple el requisito eliminando (DELETE) los bloqueos cuya expira_en ya pasó.
Uso relacionado con concurrencia (objetivo 16 del examen):

BEGIN;
SELECT * FROM editing_locks WHERE tipo_recurso='plantilla' AND recurso_id=1 FOR UPDATE;
-- ... se hace la edición ...
COMMIT;


BEGIN; / COMMIT;: aquí sí es una transacción manual de terminal (distinta del BEGIN de PL/pgSQL) — agrupa varias sentencias para que se confirmen juntas.
FOR UPDATE: bloquea esa fila específica hasta que la transacción actual termine, evitando que otra sesión edite el mismo recurso al mismo tiempo.
Cómo seguir desde aquí
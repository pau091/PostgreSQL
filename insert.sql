2.5 Datos de prueba (INSERT)

-- 1. Geografía
INSERT INTO countries (nombre) VALUES ('Colombia');

INSERT INTO departments (nombre, pais_id) VALUES
('Santander', 1),
('Antioquia', 1);

INSERT INTO cities (nombre, departamento_id) VALUES
('Bucaramanga', 1),
('Piedecuesta', 1),
('Medellín', 2);

-- 2. Tamaños de empresa
INSERT INTO tenant_sizes (nombre) VALUES
('Pequeña'), ('Mediana'), ('Grande');

-- 3. Organizaciones (tenants)
INSERT INTO tenants (nombre, nit, correo_contacto, telefono, tamano_id, ciudad_id, activo) VALUES
('Constructora Andina S.A.S', '900111222-1', 'contacto@andina.com', '3001112233', 3, 2, true),
('Transportes del Oriente Ltda', '900333444-5', 'contacto@transoriente.com', '3004445566', 2, 1, true),
('Textiles Bucaramanga S.A.S', '900555666-9', 'contacto@textilesbga.com', '3007778899', 1, 1, false);

-- 4. Cargos (por organización)
INSERT INTO positions (tenant_id, descripcion) VALUES
(1, 'Gerente SST'),
(1, 'Auxiliar SST'),
(1, 'Operario de obra'),
(2, 'Coordinador PESV'),
(2, 'Conductor'),
(3, 'Jefe de planta');

-- 5. Personas
INSERT INTO persons (tenant_id, position_id, nombres, apellidos, correo, activo) VALUES
(1, 1, 'Laura', 'Ramírez', 'laura.ramirez@andina.com', true),
(1, 2, 'Carlos', 'Gómez', 'carlos.gomez@andina.com', true),
(1, 3, 'Andrés', 'Pérez', 'andres.perez@andina.com', true),
(2, 4, 'Diana', 'Suárez', 'diana.suarez@transoriente.com', true),
(2, 5, 'Jorge', 'Martínez', 'jorge.martinez@transoriente.com', false),
(3, 6, 'Sandra', 'León', 'sandra.leon@textilesbga.com', true);

-- 6. Sistemas SST/PESV y su habilitación por tenant
INSERT INTO type_system_sst (nombre) VALUES ('SST'), ('PESV');

INSERT INTO tenantsystems (tenant_id, system_id) VALUES
(1, 1),          -- Andina: SST
(2, 1), (2, 2),  -- Transportes: SST y PESV
(3, 1);          -- Textiles: SST

-- 7. Módulos y su asignación
INSERT INTO modules (system_id, titulo, descripcion, orden) VALUES
(1, 'Peligros y Riesgos', 'Identificación y valoración de riesgos', 1),
(1, 'Capacitaciones', 'Gestión de capacitaciones en SST', 2),
(2, 'Vehículos', 'Control de la flota vehicular', 1),
(2, 'Conductores', 'Gestión documental de conductores', 2);

INSERT INTO tenant_modules (tenant_id, module_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 3), (2, 4),
(3, 1);

-- 8. Formatos
INSERT INTO formats_sst (module_id, nombre) VALUES
(1, 'Matriz de peligros'),
(2, 'Plan anual de capacitaciones'),
(3, 'Ficha técnica de vehículo'),
(4, 'Hoja de vida del conductor');

-- 9. Etapas PHVA
INSERT INTO phva_stages (nombre) VALUES
('Planear'), ('Hacer'), ('Verificar'), ('Actuar');

-- 10. Plantillas
INSERT INTO templates (system_id, stage_id, format_id, nombre) VALUES
(1, 1, 1, 'Plantilla matriz de peligros'),
(1, 2, 2, 'Plantilla plan de capacitación'),
(2, 1, 3, 'Plantilla ficha de vehículo'),
(2, 3, 4, 'Plantilla verificación de conductor');

-- 11. Plantillas asignadas a organizaciones
INSERT INTO tenanttemplates (tenant_id, template_id, actualizado_por) VALUES
(1, 1, 'admin'),
(1, 2, 'admin'),
(2, 3, 'admin'),
(2, 4, 'admin');

-- 12. Evaluaciones
INSERT INTO evaluations (template_id, nombre) VALUES
(1, 'Evaluación matriz de peligros Q1'),
(3, 'Evaluación ficha de vehículo Q1');

-- 13. Documentos (base del indicador de cumplimiento)
INSERT INTO documents (tenant_id, template_id, estado) VALUES
(1, 1, 'finalizado'),
(1, 2, 'pendiente'),
(2, 3, 'finalizado'),
(2, 4, 'borrador'),
(3, 1, 'no_iniciado');

-- 14. Bloqueo de edición de ejemplo
INSERT INTO editing_locks (tipo_recurso, recurso_id, bloqueado_por, expira_en) VALUES
('plantilla', 1, 'laura.ramirez', now() + interval '30 minutes');
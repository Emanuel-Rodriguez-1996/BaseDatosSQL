USE CLINICA_NEWAGE;
SET DATEFORMAT DMY;
GO

----------------------------------------------------
-- PACIENTES (10)
----------------------------------------------------
INSERT INTO Paciente (Nombre, FechaNacimiento, Genero, ObraSocial, Email, Telefono) VALUES
('Juan Pérez', '15/03/1985', 'M', 'Salud Total', 'juan.perez@gmail.com', '099123456'),
('María Gómez', '22/07/1990', 'F', 'Mediplus', 'maria.gomez@yahoo.com', '098765432'),
('Carlos Fernández', '10/01/1975', 'M', 'Salud Total', 'carlosf@hotmail.com', '091234567'),
('Lucía Rodríguez', '05/09/2000', 'F', 'PlanVida', 'lucia.rod@gmail.com', '092223344'),
('Andrés Morales', '18/12/1982', 'M', 'Mediplus', 'andres.morales@outlook.com', '097334455'),
('Sofía Martínez', '30/06/1995', 'F', 'PlanVida', 'sofia.mtz@gmail.com', '099445566'),
('Diego Torres', '02/11/1988', 'M', 'Salud Total', 'diego.torres@gmail.com', '098556677'),
('Ana López', '14/04/1979', 'F', 'Mediplus', 'ana.lopez@yahoo.com', '093667788'),
('Pedro Sánchez', '25/08/1992', 'M', 'PlanVida', 'pedro.sanchez@gmail.com', '094778899'),
('Valentina Cabrera', '19/10/1998', 'F', 'Salud Total', 'valen.cabrera@hotmail.com', '097889900'),
('Vinicius Junior', '17/06/2000', 'F', 'Salud Total', 'vini.jr@hotmail.com', '097777777');
GO

----------------------------------------------------
-- PROFESIONALES (5)
----------------------------------------------------
INSERT INTO Profesional (Nombre, Especialidad, Matricula, Honorarios, Activo) VALUES
('Dr. Ricardo Álvarez', 'Cardiología', 'CAR123', 2500.00, 1),
('Dra. Mariana Ruiz', 'Dermatología', 'DER456', 1800.00, 1),
('Dr. Esteban López', 'Pediatría', 'PED789', 2000.00, 1),
('Dra. Verónica Castro', 'Ginecología', 'GIN321', 2200.00, 1),
('Dr. Álvaro Fernández', 'Traumatología', 'TRA654', 2300.00, 1),
('Dr. Luis Herrera', 'Cardiología', 'CAR555', 2100.00, 1),
('Dra. Patricia Soto', 'Pediatría', 'PED666', 1900.00, 1);
GO

----------------------------------------------------
-- TURNOS (25, con repetición en 2024) // Se agregan los honorarios correspondiente al cambio solicitado en aulas
----------------------------------------------------
INSERT INTO Turno (FechaHora, PacienteID, ProfesionalID, Estado, Honorarios) VALUES
-- 2023
('15/02/2023 09:00', 1, 1, 'Realizado', 2500),
('20/03/2023 10:00', 2, 2, 'Cancelado', 1800),

-- 2024 (profesionales repetidos)
('10/01/2024 09:00', 6, 1, 'Realizado', 2500),
('25/01/2024 11:00', 7, 1, 'Agendado', 2500),
('12/02/2024 09:30', 8, 2, 'Realizado', 1800),
('26/02/2024 14:00', 9, 2, 'Cancelado', 1800),
('05/03/2024 10:30', 10, 3, 'Realizado', 2000),
('18/03/2024 15:00', 1, 3, 'Agendado', 2000),
('02/04/2024 11:00', 2, 4, 'Realizado', 2200),
('16/04/2024 16:00', 3, 4, 'Cancelado', 2200),
('05/05/2024 09:30', 4, 6, 'Realizado', 2100),
('20/05/2024 12:30', 5, 5, 'Agendado', 2300),
('09/06/2024 10:00', 6, 1, 'Realizado', 2500),
('23/06/2024 15:00', 7, 6, 'Cancelado', 2100),
('07/07/2024 11:30', 8, 3, 'Realizado', 2000),
('21/07/2024 14:00', 9, 4, 'Agendado', 2200),
('04/08/2024 09:00', 10, 5, 'Realizado', 2300),
('18/08/2024 11:30', 1, 7, 'Cancelado', 1900),
('01/09/2024 15:00', 2, 2, 'Realizado', 1800),
('15/09/2024 09:30', 3, 7, 'Agendado', 1900),

-- 2025
('12/01/2025 09:00', 4, 4, 'Realizado', 2200),
('20/02/2025 10:00', 5, 5, 'Agendado', 2300),
('05/04/2025 11:30', 3, 7, 'Realizado', 1900),
('12/05/2025 14:00', 4, 4, 'Agendado', 2200),
('22/06/2025 15:00', 5, 5, 'Realizado', 2300),
('10/01/2025 09:00', 6, 1, 'Agendado', 2500),
('11/01/2025 09:00', 11, 1, 'Realizado', 2500),

-- 2026
('18/02/2026 11:00', 7, 2, 'Realizado', 1800),
('25/03/2026 15:00', 8, 3, 'Cancelado', 2000);
GO

----------------------------------------------------
-- TURNOS DISPONIBLES (20) // Se agregan los honorarios correspondiente al cambio solicitado en aulas
----------------------------------------------------
INSERT INTO Turno (FechaHora, PacienteID, ProfesionalID, Estado, Honorarios) VALUES
('10/01/2025 08:00', NULL, 1, 'Disponible', 2500),
('10/01/2025 09:00', NULL, 1, 'Disponible', 2500),
('15/01/2025 14:00', NULL, 2, 'Disponible', 1800),
('18/01/2025 16:30', NULL, 3, 'Disponible', 2000),
('20/01/2025 11:00', NULL, 4, 'Disponible', 2200),

('05/02/2025 09:00', NULL, 5, 'Disponible', 2300),
('06/02/2025 10:30', NULL, 6, 'Disponible', 2100),
('10/02/2025 15:00', NULL, 7, 'Disponible', 1900),
('12/02/2025 08:30', NULL, 2, 'Disponible', 1800),
('18/02/2025 10:00', NULL, 3, 'Disponible', 2000),

('01/03/2025 09:00', NULL, 4, 'Disponible', 2200),
('03/03/2025 14:30', NULL, 5, 'Disponible', 2300),
('08/03/2025 16:00', NULL, 6, 'Disponible', 2100),
('12/03/2025 11:00', NULL, 7, 'Disponible', 1900),
('15/03/2025 17:00', NULL, 1, 'Disponible', 2500),

('10/01/2026 08:00', NULL, 1, 'Disponible', 2500),
('10/01/2026 09:00', NULL, 1, 'Disponible', 2500),
('15/01/2026 14:00', NULL, 2, 'Disponible', 1800),
('18/01/2026 16:30', NULL, 3, 'Disponible', 2000),
('20/01/2026 11:00', NULL, 4, 'Disponible', 2200),

('05/02/2026 09:00', NULL, 5, 'Disponible', 2300),
('06/02/2026 10:30', NULL, 6, 'Disponible', 2100),
('10/02/2026 15:00', NULL, 7, 'Disponible', 1900),
('12/02/2026 08:30', NULL, 2, 'Disponible', 1800),
('18/02/2026 10:00', NULL, 3, 'Disponible', 2000),

('01/03/2026 09:00', NULL, 4, 'Disponible', 2200),
('03/03/2026 14:30', NULL, 5, 'Disponible', 2300),
('08/03/2026 16:00', NULL, 6, 'Disponible', 2100),
('12/03/2026 11:00', NULL, 7, 'Disponible', 1900),
('15/03/2026 17:00', NULL, 1, 'Disponible', 2500),

('05/04/2026 09:00', NULL, 2, 'Disponible', 1800),
('10/04/2026 10:00', NULL, 3, 'Disponible', 2000),
('20/04/2026 15:00', NULL, 4, 'Disponible', 2200),
('25/04/2026 16:30', NULL, 5, 'Disponible', 2300),
('30/04/2026 08:00', NULL, 6, 'Disponible', 2100);
GO

----------------------------------------------------
-- CONSULTAS (8, solo de turnos Realizados)
----------------------------------------------------
INSERT INTO Consulta (TurnoID, Diagnostico, Recomendaciones, Receta, Fecha) VALUES
(1,  'Hipertensión arterial', 'Reducir sal y ejercicio regular', 'Losartán 50mg', '15/02/2023'),
(6,  'Arritmia leve', 'Control cardiológico mensual', 'Bisoprolol 5mg', '10/01/2024'),
(8,  'Dermatitis atópica', 'Crema emoliente y control', 'Hidrocortisona tópica', '12/02/2024'),
(11, 'Bronquitis aguda', 'Reposo, líquidos y antibiótico', 'Amoxicilina 500mg', '05/03/2024'),
(13, 'Cefalea tensional por stress', 'Relajación, descanso adecuado', 'Ibuprofeno 400mg', '09/06/2024'),
(15, 'Dolor lumbar', 'Kinesiología y analgesia', 'Paracetamol 500mg', '05/05/2024'),
(19, 'Trastorno de ansiedad generalizada', 'Terapia cognitivo-conductual, técnicas de relajación', 'Sertralina 50mg', '01/09/2024'),
(20, 'Migraña crónica', 'Control neurológico', 'Sumatriptán 50mg', '12/01/2025'),
(22, 'Estrés laboral crónico', 'Ejercicio físico, reducción de carga laboral, meditación', 'Escitalopram 10mg', '22/06/2025'),
(25, 'Crisis de angustia', 'Apoyo psicológico inmediato, respiración guiada', 'Alprazolam 0.5mg', '18/02/2026'),
(27, 'Calvicie', 'Tratamiento inmediato con crema', 'Crema para el pelo', '19/02/2025');
GO

----------------------------------------------------
-- PRODUCTOS (10)
----------------------------------------------------
INSERT INTO Producto (Nombre, Tipo, Stock, Precio, Activo) VALUES
('Paracetamol 500mg', 'Farmacéutico', 200, 150.00, 1),
('Ibuprofeno 400mg', 'Farmacéutico', 150, 180.00, 1),
('Omeprazol 20mg', 'Farmacéutico', 120, 220.00, 1),
('Jarabe de Miel', 'Natural', 50, 300.00, 1),
('Té Verde', 'Natural', 80, 250.00, 1),
('Vitamina C 1g', 'Natural', 100, 400.00, 1),
('Proteína Whey 1kg', 'Suplemento', 60, 1800.00, 1),--7
('Ginseng Extracto', 'Natural', 40, 600.00, 1),
('Amoxicilina 500mg', 'Farmacéutico', 90, 350.00, 1),
('Colágeno Hidrolizado', 'Suplemento', 70, 950.00, 1),
('Crema para el pelo', 'Farmacéutico', 70, 950.00, 1);
GO

----------------------------------------------------
-- VENTAS (15)
----------------------------------------------------
INSERT INTO Venta (FechaVenta, PacienteID, Total) VALUES
('05/09/2023', 1, 530.00),
('06/09/2023', 2, 2200.00),
('07/09/2023', 3, 950.00),
('10/09/2023', 4, 320.10),
('15/10/2023', 5, 920.15),
('17/11/2023', 6, 120.25),
('20/12/2023', 7, 520.05), 
('05/01/2024', 8, 820.30),
('08/02/2024', 9, 920.50),
('20/03/2024', 10, 2200.90),
('30/04/2024', 1, 750.03),
('18/05/2024', 2, 350.25),
('10/06/2024', 3, 420.60),
('25/07/2024', 4, 950.00),
('05/08/2024', 5, 1300.00),
('19/02/2025', 11, 2500.00),
('10/01/2025', 3, 850.00),
('15/02/2025', 5, 1950.00),
('05/03/2025', 1, 1320.00),
('22/03/2025', 8, 700.00),
('10/04/2025', 2, 1650.00),
('25/05/2025', 6, 900.00),
('14/06/2025', 4, 2300.00),
('28/07/2025', 10, 1550.00),
('12/09/2025', 7, 1100.00),
('30/10/2025', 9, 2400.00);
GO

----------------------------------------------------
-- DETALLE DE VENTA (25)
----------------------------------------------------
INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, PrecioUnitario) VALUES
(1, 1, 2, 150.00),
(1, 2, 1, 180.00),
(2, 7, 3, 1800.00),
(2, 6, 2, 600.00),
(3, 10, 3, 2850.00),
(4, 9, 1, 350.00),
(5, 5, 2, 250.00),
(6, 4, 1, 300.00),
(7, 6, 1, 400.00),
(8, 1, 3, 150.00),
(9, 2, 2, 180.00),
(10, 7, 1, 1800.00),
(11, 3, 2, 220.00),
(12, 6, 3, 400.00),
(13, 8, 1, 600.00),
(14, 5, 2, 250.00),
(15, 10, 1, 950.00),
(3, 1, 1, 150.00),
(7, 2, 2, 180.00),
(9, 9, 1, 350.00),
(12, 4, 1, 300.00),
(13, 6, 2, 400.00),
(14, 7, 1, 1800.00),
(15, 8, 1, 600.00),
(15, 10, 1, 950.00),
(16, 11, 1, 2500.00),
(17, 1, 1, 150.00),
(17, 2, 1, 180.00),
(17, 5, 1, 250.00),
(18, 7, 1, 1800.00),
(18, 6, 1, 400.00),
(19, 3, 1, 220.00),
(19, 4, 1, 300.00),
(19, 10, 1, 950.00),
(20, 5, 1, 250.00),
(20, 8, 1, 600.00),
(21, 9, 1, 350.00),
(21, 2, 1, 180.00),
(21, 6, 1, 400.00),
(22, 1, 1, 150.00),
(22, 4, 1, 300.00),
(23, 7, 1, 1800.00),
(23, 5, 1, 250.00),
(24, 10, 1, 950.00),
(24, 6, 1, 400.00),
(25, 8, 1, 600.00),
(25, 1, 1, 150.00),
(25, 2, 1, 180.00),
(26, 7, 1, 1800.00),
(26, 9, 1, 350.00),
(26, 11, 1, 250.00),
(26, 6, 2, 1000);
GO

----------------------------------------------------
-- TERAPIAS ALTERNATIVAS (5)
----------------------------------------------------
INSERT INTO TerapiasAlternativas (TipoTerapia, Nombre, Descripcion, Costo) VALUES
('Masajes', 'Masaje Descontracturante', 'Aliviar tensiones musculares', 1200.00),
('Acupuntura', 'Acupuntura Energética', 'Aplicación de agujas para mejorar flujo energético', 1500.00),
('Reiki', 'Reiki Tradicional', 'Canalización de energía vital', 1000.00),
('Yoga', 'Yoga Terapéutico', 'Ejercicios de respiración y estiramiento', 800.00),
('Meditación', 'Mindfulness', 'Técnicas de atención plena', 900.00);
GO

----------------------------------------------------
-- TERAPIAS ALTERNAS APLICADAS (5)
----------------------------------------------------
INSERT INTO TerapiasAlternasAplicadas (TerapiaID, PacienteID, ProfesionalID, FechaInicio, Frecuencia, DescripcionTratamientoEspecifico, Costo) VALUES
(1, 1, 1, '20/08/2023', 'Semanal', 'Masaje de espalda y cuello', 1200.00),
(2, 2, 2, '22/08/2023', 'Quincenal', 'Acupuntura puntos energéticos', 1500.00),
(3, 3, 3, '25/08/2023', 'Mensual', 'Sesión completa de Reiki', 1000.00),
(4, 4, 4, '10/09/2023', 'Semanal', 'Yoga para columna', 800.00),
(5, 5, 5, '15/09/2023', 'Mensual', 'Meditación guiada', 900.00);
GO

----------------------------------------------------
-- AUDITORÍA TURNOS CANCELADOS (5)
----------------------------------------------------
INSERT INTO AuditoriaTurnosCancelados (TurnoID, PacienteID, ProfesionalID, Motivo) VALUES
(2, 2, 2, 'Paciente no pudo asistir'),
(9, 8, 2, 'Profesional con licencia'),
(16, 3, 4, 'Reprogramación por estudios'),
(18, 1, 1, 'Paciente olvidó turno'),
(23, 8, 3, 'Motivos climáticos');
GO

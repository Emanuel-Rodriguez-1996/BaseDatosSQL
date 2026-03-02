USE CLINICA_NEWAGE;
--A: Crear los índices necesarios que correspondan al modelo relacional especificado. (1p) 

----------------------Pacientes----------------------
CREATE NONCLUSTERED INDEX IDX_Paciente_Email ON Paciente(Email);

----------------------Profesional----------------------
CREATE NONCLUSTERED INDEX IDX_Profesional_Especialidad ON Profesional(Especialidad);
CREATE NONCLUSTERED INDEX IDX_Profesional_Matricula ON Profesional(Matricula);
CREATE NONCLUSTERED INDEX IDX_Profesional_Esp_Honorarios ON Profesional(Especialidad, Honorarios);

----------------------Turno----------------------
CREATE NONCLUSTERED INDEX IDX_Turno_Profesional ON Turno(ProfesionalId);
CREATE NONCLUSTERED INDEX IDX_Turno_Paciente ON Turno(PacienteId);
CREATE NONCLUSTERED INDEX IDX_Turno_FechaHora ON Turno(FechaHora);

----------------------Consulta----------------------
CREATE NONCLUSTERED INDEX IDX_Consulta_Fecha ON Consulta(Fecha);
CREATE NONCLUSTERED INDEX IDX_Producto_Turno ON  Consulta(TurnoId);

----------------------Producto----------------------
CREATE NONCLUSTERED INDEX IDX_Producto_Tipo ON Producto(Tipo);

----------------------Venta----------------------
CREATE NONCLUSTERED INDEX IDX_Venta_FechaVenta ON Venta(FechaVenta);
CREATE NONCLUSTERED INDEX IDX_Venta_PacienteID ON Venta(PacienteID);
CREATE NONCLUSTERED INDEX IDX_Venta_PacienteID_FechaVenta ON Venta(PacienteID, FechaVenta);

----------------------DetalleVenta----------------------
CREATE NONCLUSTERED INDEX IDX_DetVenta_Venta ON DetalleVenta(VentaId);
CREATE NONCLUSTERED INDEX IDX_DetVenta_Producto ON DetalleVenta(ProductoId);

----------------------TerapiasAlternativas----------------------
CREATE NONCLUSTERED INDEX IDX_TerapiasAlternativas_TipoTerapia ON TerapiasAlternativas(TipoTerapia);

----------------------TerapiasAlternasAplicadas----------------------
CREATE NONCLUSTERED INDEX IDX_TerapiasAlternasAplicadas_TerapiaID ON TerapiasAlternasAplicadas(TerapiaID);
CREATE NONCLUSTERED INDEX IDX_TerapiasAlternasAplicadas_PacienteID ON TerapiasAlternasAplicadas(PacienteID);
CREATE NONCLUSTERED INDEX IDX_TerapiasAlternasAplicadas_ProfesionalID ON TerapiasAlternasAplicadas(ProfesionalID);
CREATE NONCLUSTERED INDEX IDX_TerapiasAlternasAplicadas_FechaInicio ON TerapiasAlternasAplicadas(FechaInicio);

----------------------AuditoriaTurnosCancelados----------------------
CREATE NONCLUSTERED INDEX IDX_AuditoriaTurnosCancelados_PacienteID ON AuditoriaTurnosCancelados(PacienteID);
CREATE NONCLUSTERED INDEX IDX_AuditoriaTurnosCancelados_ProfesionalID ON AuditoriaTurnosCancelados(ProfesionalID);
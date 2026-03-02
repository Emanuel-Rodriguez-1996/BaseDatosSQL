/*
2. Crear un Disparador (Trigger): “trg_PreventDeleteTurnoAtendido” que impida la eliminación
	de turnos con consulta asociada y registre todos los intentos fallidos de eliminación en una
	Tabla de Auditoria: “AuditoriaTurnosCancelados” cuya estructura se describe a continuación.
	Este trigger refuerza la lógica de negocio sin alterar el modelo. Es ideal cuando:
	- No se quieren borrar datos sensibles (auditoría médica).
	- Se quiere mantener coherencia entre "turno agendado" y "consulta registrada".
*/

USE [CLINICA_NEWAGE]
GO
CREATE TRIGGER trg_PreventDeleteTurnoAtendido
ON Turno
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
		SET NOCOUNT ON;

		--Insertar en auditoria los intentos de eliminar turnos con consulta
		INSERT INTO AuditoriaTurnosCancelados (TurnoID, PacienteID, ProfesionalID, Motivo)
		SELECT 
			d.TurnoID,
			d.PacienteID,
			d.ProfesionalID,
			'No se pudo eliminar el turno, tiene una consulta asociada'
		FROM deleted d
		INNER JOIN Consulta c ON c.TurnoID = d.TurnoID;

		--  Eliminar solo los turnos que NO tienen consulta asociada
		DELETE t
		FROM Turno t
		LEFT JOIN Consulta c ON c.TurnoID = t.TurnoID
		INNER JOIN deleted d ON t.TurnoID = d.TurnoID
		WHERE c.ConsultaID IS NULL;
	END TRY

    BEGIN CATCH
        PRINT 'ERROR EN TRIGGER trg_PreventDeleteTurnoAtendido:';
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
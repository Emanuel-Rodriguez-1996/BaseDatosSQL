/*
1. Crear una función Tabular, que permita devolver para un paciente dado, los Próximos turnos
	que tiene agendados dicho paciente.
*/

/*Probar con los pacientes 7 o 8*/
CREATE FUNCTION Fn_Turnos_Pacientes
(
    @PacienteID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        T.TurnoID,
        T.FechaHora,
        T.Estado,
        P.Nombre AS Profesional,
        P.Especialidad,
        Pa.Nombre AS Paciente
    FROM Turno AS T
    INNER JOIN Profesional AS P ON T.ProfesionalID = P.ProfesionalID
    INNER JOIN Paciente AS Pa ON T.PacienteID = Pa.PacienteID
    WHERE 
        T.PacienteID = @PacienteID
        AND T.FechaHora > GETDATE()
);
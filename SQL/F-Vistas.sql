/*
1- Crear una vista “vw_DisponibilidadProfesionales” que muestre la Disponibilidad de
	profesionales, con los siguientes datos: 
	ID del Profesional, 
	Nombre del Profesional,
	Especialidad, 
	cantidad de Turnos Activos, 
	Cantidad de Turnos Disponibles en el año en curso
	y cuantos turnos ocupó en año anterior.
*/

/*
	Se entiende que los turnos activos son definidos por el estado "Agendado", ademas se entiende que los turnos activos son durante el año en curso.
	Los turnos disponibles se deducen por el estado "Disponible"
	Los turnos ocupados se deducen por el estado "Realizado"
*/

CREATE VIEW VW_DisponibilidadProfesionales AS
SELECT 
	p.ProfesionalID,
	p.Nombre,
	p.Especialidad,
	(
		SELECT COUNT(t.TurnoID)
		FROM Turno t
		WHERE t.ProfesionalID = p.ProfesionalID
			AND t.Estado = 'Agendado'
			AND YEAR(t.FechaHora) = YEAR(GETDATE())
	) AS 'CantidadDeTurnosActivosAñoActual',
	(
		SELECT COUNT(t.TurnoID)
		FROM Turno t
		WHERE t.ProfesionalID = p.ProfesionalID
			AND t.Estado = 'Disponible'
			AND YEAR(t.FechaHora) = YEAR(GETDATE())
	) AS 'CantidadDeTurnosDisponiblesAñoActual',
	(
		SELECT COUNT(t.TurnoID)
		FROM Turno t
		WHERE t.ProfesionalID = p.ProfesionalID
			AND t.Estado = 'Realizado'
			AND YEAR(t.FechaHora) = (YEAR(GETDATE()) - 1)
	) AS 'TurnosOcupadosAñoAnterior'
FROM Profesional p
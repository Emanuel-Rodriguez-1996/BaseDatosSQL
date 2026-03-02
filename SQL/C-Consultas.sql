--1. Mostrar los datos de los Pacientes que realizaron consultas y luego compraron productos
--naturales.

SELECT
	P.PacienteID,
    P.Nombre,
	P.Email,
	t.Estado AS 'EstadoTurno',
	Pr.Tipo AS 'TipoProducto',
	SUM(D.Cantidad) AS 'CantidadProductos'
FROM Paciente P
INNER JOIN Turno T ON T.PacienteID = P.PacienteID
INNER JOIN Venta V ON V.PacienteID = P.PacienteID
INNER JOIN DetalleVenta D ON V.VentaID = D.VentaID
INNER JOIN Producto Pr ON D.ProductoID = Pr.ProductoID
WHERE T.Estado = 'Realizado' AND Pr.Tipo = 'Natural' AND T.FechaHora < V.FechaVenta
GROUP BY P.PacienteID, P.Nombre, P.Email, t.Estado, Pr.Tipo;

--2. Mostrar para cada tipo de producto, los productos más vendidos (considerar los $), se debe mostrar: 
--Tipo de Producto, 
--Nombre del Producto, 
--el MontoTotal Vendido, 
--la cantidad de unidades vendidas
--se deben tomar en cuenta productos solo si el “Monto Total Vendido” supera $5000, 
--Ordenar por tipo Ascendente y por el “Monto Total Vendido” descendente.

SELECT 
    P.Tipo AS TipoProducto, 
	P.Nombre AS NombreProducto, 
    SUM(D.PrecioUnitario * D.Cantidad) AS MontoTotal,
    SUM(D.Cantidad) AS CantidadDeUnidadesVendidas
FROM Producto P
INNER JOIN DetalleVenta D ON D.ProductoID = P.ProductoID
GROUP BY P.Tipo, P.Nombre
HAVING SUM(D.Cantidad * D.PrecioUnitario) > 5000
ORDER BY P.Tipo ASC, MontoTotal DESC

--3. Mostrar los datos de los Pacientes y de las Especialidades con mayor número de pacientes únicos.
--	 Se toman las 3 especialidades mas usadas y mostramos los datos de los clientes que se atendieron.

SELECT
	pro.Especialidad,
	pac.PacienteID,
	pac.Nombre,
	pac.Email
	--COUNT(tur.TurnoID) AS 'CantidadConsultas'
FROM Paciente pac
INNER JOIN Turno tur ON tur.PacienteID = pac.PacienteID
INNER JOIN Profesional pro ON pro.ProfesionalID = tur.ProfesionalID
WHERE pro.Especialidad IN (
	--3 Especialidades mas usadas de turnos en estado Agendado o Realizado.
	SELECT TOP 3
		p.Especialidad
	FROM Profesional p
	INNER JOIN Turno t ON t.ProfesionalID = p.ProfesionalID
	WHERE t.Estado NOT IN ('Disponible', 'Cancelado')
	GROUP BY p.Especialidad
	ORDER BY COUNT(t.PacienteID) DESC	
)
AND tur.PacienteID NOT IN (
	--Este NOT IN determina si los pacientes solo se atendieron en una sola especialidad, es decir, son únicos.
	--La consulta devuelve los PacienteId de los turnos de especialidades diferentes a la que estamos evaluando y con estado Agendado o Realizado.
	SELECT
		DISTINCT t2.PacienteID
	FROM Turno t2
	INNER JOIN Profesional p2 ON p2.ProfesionalID = t2.ProfesionalID
	WHERE p2.Especialidad <> pro.Especialidad
	AND t2.Estado NOT IN ('Disponible', 'Cancelado')
)
GROUP BY pro.Especialidad, pac.PacienteID, pac.Nombre, pac.Email
ORDER BY pro.Especialidad, COUNT(tur.TurnoID) DESC

--4. Mostrar los datos de los Pacientes que han comprado más productos que el promedio
--general de productos vendidos del año anterior.

SELECT *
FROM 
(
    SELECT 
        p.PacienteID, 
        p.Nombre, 
        p.Email, 
        SUM(dv.Cantidad) AS ProductosCompradosPorPacienteaAñoActual,
        (
            SELECT
                SUM(dv2.Cantidad) / COUNT(DISTINCT v2.VentaID)
            FROM Venta v2
            INNER JOIN DetalleVenta dv2 ON v2.VentaID = dv2.VentaID
            INNER JOIN Producto p2 ON dv2.ProductoID = p2.ProductoID
            WHERE YEAR(v2.FechaVenta) = (YEAR(GETDATE()) - 1)
        ) AS PromedioProductosVendidosAñoAnterior
    FROM Venta v
    INNER JOIN Paciente p ON v.PacienteID = p.PacienteID
    INNER JOIN DetalleVenta dv ON v.VentaID = dv.VentaID
	WHERE YEAR(V.FechaVenta) = YEAR(GETDATE())
    GROUP BY p.PacienteID, p.Nombre, p.Email
) AS R
WHERE R.ProductosCompradosPorPacienteaAñoActual > R.PromedioProductosVendidosAñoAnterior;

--5. Mostrar los datos de los Profesionales con honorarios mayores al promedio de su
--especialidad en el año anterior.

/***************Promedio año anterior****************/
--Cardiología => 2366,66
--Dermatologia => 1800
--Pediatria => 2000
--Gineecologia => 2200
--Traumatologia => 2300

/***************Honorarios profesionales****************/
--1 => Cardiología => 2500
--2 => Dermatología => 1800.00
--3 => Pediatría => 2000.00
--4 => Ginecología => 2200.00
--5 => Traumatología => 2300.00
--6 => Cardiología => 2100.00
--7 => Pediatría => 1900.00

/***************ProfesionalId a mostrar en la consulta con datos actuales****************/
--1 - Dr. Ricardo Álvarez

--Se toman los honorarios a partir del turno por cambio solicitado en aulas, 
--la forma original de este metodo era tomando los honorarios directamente desde el profesional

SELECT * 
FROM Profesional prof
WHERE prof.Honorarios > (
	--PROMEDIO DE TURNOS DEL AÑO PASADO SEGUN LA ESPECIALIDAD
	SELECT (SUM(t.Honorarios) / COUNT(P.ProfesionalID))
	FROM Turno t
	INNER JOIN Profesional p ON t.ProfesionalID = p.ProfesionalID
	WHERE YEAR(t.FechaHora) = (YEAR(GETDATE()) - 1) AND p.Especialidad = prof.Especialidad AND t.Estado = 'Realizado'
	GROUP BY p.Especialidad
)

--6. Mostrar los datos de los Turnos de pacientes cuya última consulta contiene las palabra
--"estrés" o “stress”, “ansiedad” , o “angustia”.

select 
	t.TurnoID,
	t.FechaHora,
	t.ProfesionalID,
	t.Estado,
	c.Diagnostico
from Consulta c
inner join Turno t on c.TurnoID = t.TurnoID
where t.Estado = 'Realizado' 
	AND (c.Diagnostico LIKE '%estrés%'
		OR c.Diagnostico LIKE '%stress%'
		OR c.Diagnostico LIKE '%ansiedad%'
		OR c.Diagnostico LIKE '%angustia%')
	AND t.TurnoID = (
			--El turno de la consulta que estoy analizando, tiene que corresponder al ultimo turno con consulta realizado por el paciente
			select top 1 tur.TurnoID
			from Turno tur
			inner join Consulta con on tur.TurnoID = con.TurnoID
			where t.PacienteID = tur.PacienteID
			order by FechaHora desc
		);
--D. Procedimientos Almacenados (3p):
--1. Construir un Procedimiento almacenado:
--“SP_Registro_Ventas_Devoluciones” que reciba como parámetros:
--ID_producto, 
--Cantidad de Unidades, 
--el tipo de operación (Venta o Devolución)
--realice la actualización del Stock y devuelva como parámetro el Stock final resultante,
--también devuelva un mensaje indicando si la operación se realizó correctamente o hubo algún inconveniente. 
--Considere las restricciones de No poder dejar Stock en Negativo y si el Stock quedase en CERO, notificarlo en el mensaje.

--Para la creacion del SP se definen los siguientes codigos de salida:
--0 Parametros invalidos;
--1 Error obteniendo el elemento;
--2 Respuesta de error del SP
CREATE PROCEDURE SP_Registro_Ventas_Devoluciones
	@IdProducto INT,
	@Unidades INT,
	@TipoOperacion VARCHAR(10),
	@StockFinal INT OUTPUT
AS
BEGIN
	--Seteo a mayusculas el tipo de opreación
	SET @TipoOperacion = UPPER(LTRIM(RTRIM(@TipoOperacion)));

	--Valido los parametros
	IF(@IdProducto IS NULL OR @IdProducto <= 0) 
	BEGIN
		PRINT 'El id del producto es requerido o invalido'
		RETURN 0;
	END

	IF(@Unidades IS NULL OR @Unidades <= 0)
	BEGIN
		PRINT 'La cantidad de unidades es requerida o invalida'
		RETURN 0;
	END

	IF(@TipoOperacion IS NULL OR RTRIM(LTRIM(@TipoOperacion)) = '')
	BEGIN
		PRINT 'El tipo de operación es requerido'
		RETURN 0;
	END

	IF(@TipoOperacion IS NOT NULL AND @TipoOperacion NOT IN ('VENTA', 'DEVOLUCION'))
	BEGIN
		PRINT 'El tipo de operación es invalido'
		RETURN 0;
	END

	--Valido si el producto existe
	IF(NOT EXISTS(SELECT 1 FROM Producto p WHERE p.ProductoID = @IdProducto))
	BEGIN
		PRINT 'El producto con el id seleccionado no existe'
		RETURN 1;
	END 

	--Me traigo el Stock del proucto y lo almaceno en una variable
	DECLARE @stockActual INT;
	DECLARE @stockResultante INT;

	SELECT @stockActual = p.Stock
	FROM Producto p
	WHERE p.ProductoID = @IdProducto

	--Valido que mi stock sea mayor a cero
	--Valido que las unidades a restar no sean mayor a mi stock => de esta manera mi stock no quedara negativo
	IF(@TipoOperacion = 'VENTA' AND (@stockActual = 0 OR @Unidades > @stockActual))
	BEGIN
		PRINT 'No hay stock para el producto seleccionado o se solicitan mas unidades de las disponibles'
		RETURN 2
	END
	ELSE
	BEGIN
		--Calculo el stock resultante restandole las unidades
		IF(@TipoOperacion = 'VENTA')
		BEGIN
			SET @stockResultante = @stockActual - @Unidades;
		END
		ELSE
		BEGIN
			SET @stockResultante = @stockActual + @Unidades;
		END

		--Doy error si mi stock es menor a cero
		IF(@stockResultante < 0)
		BEGIN
			PRINT 'El stock resultante no puede ser negativo.'
			RETURN 2
		END
		ELSE
		BEGIN
			BEGIN TRY
				--Seteo el nuevo stock al producto
				UPDATE Producto SET Stock = @stockResultante WHERE ProductoID = @IdProducto
			END TRY
			BEGIN CATCH
				PRINT 'Error al intentar actualizar el stock.';
				RETURN 2;
			END CATCH;

			--Si stock quedo en cero notifico que ya no hay stock
			--Devuelvo el stock final
			SET @StockFinal = @stockResultante

			IF(@StockFinal = 0)
			BEGIN
				PRINT 'Ya no cuenta con stock para este producto';
			END
			ELSE
			BEGIN
				PRINT 'Operación realizada correctamente.';
			END
		END
	END
END;
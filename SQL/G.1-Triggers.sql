/*
1. Crear un Disparador (Trigger): “trg_MantenimientoStock : que permita mantener actualizado
	el Stock de los productos vendidos, cada vez que se ingrese una Venta, se elimine una Venta o
	se actualicen las Cantidades de una venta existente, se debe actualizar el Stock de los
	productos implicados, además se debe controlar y emitir una mensaje de alerta cuando el
	Stock resultante en un producto quede por debajo de 5 unidades.
*/

USE [CLINICA_NEWAGE]
GO
CREATE TRIGGER trg_MantenimientoStock
ON DetalleVenta
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    BEGIN TRY
        -- INSERT
        IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
        BEGIN
            UPDATE p
            SET p.Stock = p.Stock - i.Cantidad
            FROM Producto p
            INNER JOIN inserted i ON p.ProductoID = i.ProductoID;

            -- Evitar stock negativo
            IF EXISTS (
                SELECT 1 FROM Producto WHERE Stock < 0
                AND ProductoID IN (SELECT ProductoID FROM inserted)
            )
            BEGIN
                RAISERROR('No se puede dejar el stock en negativo.', 16, 1);
            END
        END

        -- DELETE
        IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
        BEGIN
            UPDATE p
            SET p.Stock = p.Stock + d.Cantidad
            FROM Producto p
            INNER JOIN deleted d ON p.ProductoID = d.ProductoID;
        END

        -- UPDATE
        IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        BEGIN
            UPDATE p
            SET p.Stock = p.Stock + d.Cantidad - i.Cantidad
            FROM Producto p
            INNER JOIN deleted d ON p.ProductoID = d.ProductoID
            INNER JOIN inserted i ON p.ProductoID = i.ProductoID;

            -- Evitar stock negativo
            IF EXISTS (
                SELECT 1 FROM Producto WHERE Stock < 0
                AND ProductoID IN (SELECT ProductoID FROM inserted)
            )
            BEGIN
                RAISERROR('No se puede dejar el stock en negativo.', 16, 1);
            END
        END

        -- ALERTA
        SELECT  
            p.Nombre,
            'ALERTA: El stock del producto ' + p.Nombre +
            ' está en ' + CAST(p.Stock AS NVARCHAR(10)) AS Mensaje
        FROM Producto p
        WHERE p.Stock < 5
          AND p.ProductoID IN (
                SELECT ProductoID FROM inserted
                UNION
                SELECT ProductoID FROM deleted
          );

    END TRY

    BEGIN CATCH
        PRINT 'ERROR EN TRIGGER trg_MantenimientoStock:';
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
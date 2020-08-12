USE [prograFinal]
GO
IF OBJECT_ID('[dbo].[SP_ProcesaPagoFactura]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SP_ProcesaPagoFactura]  
END 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ProcesaPagoFactura] @numeros PagoFacturasTipo READONLY
AS 
	BEGIN
		BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON  
			UPDATE [dbo].[FacturaLlamada]
			SET Estado = 1
			FROM [dbo].[FacturaLlamada] FL
			INNER JOIN @numeros N ON N.numero = FL.
		END TRY
		BEGIN CATCH
			THROW 55501,'Error al modificar usuario, por favor verifique los datos',1;
		END CATCH
	END

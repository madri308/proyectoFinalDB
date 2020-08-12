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
CREATE PROC [dbo].[SP_ProcesaPagoFactura] @inNumeros PagoFacturasTipo READONLY
AS 
	BEGIN
		BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON  
		DECLARE @idMenor INT, @idMayor INT, @idFacturaVieja INT
		SELECT @idMenor = min([id]), @idMayor=max([id]) FROM @inNumeros--SACA ID MAYOR Y MENOR PARA ITERAR LA TABLA
		BEGIN TRAN
			WHILE @idMenor<=@idMayor
			BEGIN
				SET @idFacturaVieja = (SELECT TOP 1 FL.id 
										FROM [dbo].[Factura] FL
										INNER JOIN [dbo].[Contrato] C ON C.id = FL.idContrato
										INNER JOIN @inNumeros N ON N.numero = C.Numero
										WHERE N.id = @idMenor
										ORDER BY FL.Fecha ASC)
				UPDATE [dbo].[Factura]
				SET Estado = 1
				,FechaPago = GETDATE()
				WHERE id = @idFacturaVieja 

				SET @idMenor += 1
			END
		COMMIT
		END TRY
		BEGIN CATCH
			THROW 55501,'Error, no se han podido procesar las facturas.',1;
		END CATCH
	END

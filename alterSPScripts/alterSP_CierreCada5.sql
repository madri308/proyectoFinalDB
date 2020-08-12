USE [prograFinal]
GO
IF OBJECT_ID('[dbo].[SP_CierreCada5]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SP_CierreCada5]  
END 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CierreCada5]
AS 
	BEGIN
		BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON  
		
		DECLARE @idMenor INT, @idMayor INT
		DEClARE @TelefonosNoPersonales Table (id int, idCliente int, Numero int)
		-- Primero selecionar los telefonos no personales


		insert into @TelefonosNoPersonales (id, idCliente, Numero)
		select [id],[idCliente],[Numero] 
		from Contrato inner join TipoTarifa on Contrato.TipoTarifa = TipoTarifa.id
		where TipoTarifa.id in (7,8,9,10,11,12)

		SELECT @idMenor = min([id]), @idMayor=max([id]) FROM @TelefonosNoPersonales--SACA ID MAYOR Y MENOR PARA ITERAR LA TABLA

		END TRY
		BEGIN CATCH
			THROW 55501,'Error, no se han podido realizar el cierre.',1;
		END CATCH
	END

USE [prograFinal]
GO
IF OBJECT_ID('[dbo].[SP_ProcesaDatosMegas]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SP_ProcesaDatosMegas]  
END 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ProcesaDatosMegas] @inLlamadas DatosTipo READONLY, @InFechaOperacion DATE
AS 
	BEGIN
		BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON  
			DECLARE @idMenor INT
					,@idMayor INT
					,@NumeroA VARCHAR(30)
					,@NumeroDe VARCHAR(30)
					,@Inicio TIME
					,@Fin TIME
			SELECT @idMenor = min([id]), @idMayor=max([id]) FROM @inLlamadas--SACA ID MAYOR Y MENOR PARA ITERAR LA TABLA
			BEGIN TRAN
				WHILE @idMenor<=@idMayor
				BEGIN
					
					SET @idMenor += 1
				END
			COMMIT
		END TRY
		BEGIN CATCH
			THROW 55501,'Error, no se han podido procesar las llamadas.',1;
		END CATCH
	END

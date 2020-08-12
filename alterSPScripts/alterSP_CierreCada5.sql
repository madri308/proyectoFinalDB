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
CREATE PROC [dbo].[SP_CierreCada5] @inDate date
AS 
	BEGIN
		BEGIN TRY
			SET NOCOUNT ON 
			SET XACT_ABORT ON  
		
			DECLARE @idMenor INT, @idMayor INT, @idCierre INT
		
			SELECT @idMenor = min([id]), @idMayor=max([id]) FROM [ContratoExterno] -- ID MAYOR Y MENOR PARA ITERAR LA TABLA
		
			Begin Tran
				insert into [Cierre] (FechaCierre) -- Se crea un nuevo elemento de cierre
				values (@inDate)

				set @idCierre = SCOPE_IDENTITY();

				WHILE @idMenor<=@idMayor -- Se itera cada contrato externo
					BEGIN
						insert into [ContratosPorCierre] (idCierreExterno, idContratoExterno, CantidadMinutos)
						select top 1 @idCierre, [SaldoMin800],[idContrato] from [FacturaExterna] where [FacturaExterna].[idContrato] = @idMenor ORDER BY [id] DESC
					END
			Commit
		END TRY
		BEGIN CATCH
			THROW 55501,'Error, no se han podido realizar el cierre.',1;
		END CATCH
	END

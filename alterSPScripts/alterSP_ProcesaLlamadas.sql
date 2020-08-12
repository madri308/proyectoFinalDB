USE [prograFinal]
GO
IF OBJECT_ID('[dbo].[SP_ProcesaLlamadas]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SP_ProcesaLlamadas]  
END 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ProcesaLlamadas] @inLlamadas LlamadasTipo READONLY, @InFechaOperacion DATE
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
					SET @NumeroA = (SELECT numeroA FROM @inLlamadas WHERE id = @idMenor)
					SET @NumeroDe = (SELECT numeroDe FROM @inLlamadas WHERE id = @idMenor)
					SET @Inicio = (SELECT inicio FROM @inLlamadas WHERE id = @idMenor)
					SET @Fin = (SELECT fin FROM @inLlamadas WHERE id = @idMenor)

					IF LEFT(@NumeroA,1) = 7 OR LEFT(@NumeroA,1) = 6--EMPRESA X O Y(NO-LOCALES)
					BEGIN
						INSERT INTO [dbo].[ContratoExterno](fechaContrato,idEmpresa)
						SELECT @InFechaOperacion, EE.id
						FROM [dbo].[EmpresaExterna] EE
						INNER JOIN [dbo].[Cliente] C ON C.id = EE.id
						WHERE (C.Identificacion = 'X' AND LEFT(@NumeroA,1) = 7) 
						OR (C.Identificacion = 'Y' AND LEFT(@NumeroA,1) = 6)
					END
					ELSE IF LEFT(@NumeroA,1) = 7 --EMPRESA Z LA NUESTRA
					BEGIN
						SELECT * FROM [Cliente]
					END
						
					SET @idMenor += 1
				END
			COMMIT
		END TRY
		BEGIN CATCH
			THROW 55501,'Error, no se han podido procesar las llamadas.',1;
		END CATCH
	END

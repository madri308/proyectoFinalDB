USE [prograFinal]
DECLARE @XMLData XML, @MinDate DATE, @MaxDate DATE
DECLARE @hdoc INT
SET NOCOUNT ON

--GUARDAR EL XML CON OPENXML
SELECT @XMLData = C
FROM OPENROWSET (BULK 'C:\Users\emema\Documents\TEC\2020\SEM_I\BasesI\PrograFinal\proyectoFinalDB\archivosXML\Operaciones.xml', SINGLE_BLOB) AS ReturnData(C)
EXEC sp_xml_preparedocument @hdoc OUTPUT, @XMLData

--CREA TABLA TEMPORAL DE FECHAS
CREATE TABLE #TEMP_DATES_TABLE
(
	id INT IDENTITY(1,1),
    [date] DATE
); 

--INSERTA TODAS LAS FECHA EN LA TABLA TEMPORAL
INSERT INTO #TEMP_DATES_TABLE([date])
	SELECT
		CONVERT(DATE,F.value('@fecha', 'VARCHAR(100)'),126)
	FROM 
		@XmlData.nodes('//OperacionDia') AS ReturnData(F)

--SACA LOS MAXIMOS Y MINIMOS
SELECT 
	@MinDate = min([date]), @MaxDate=max([date])
FROM
	#TEMP_DATES_TABLE

DROP TABLE #TEMP_DATES_TABLE --DEJA LA TABLA

--INSERTAR DATOS
WHILE @MinDate<=@MaxDate
BEGIN		
		--INSERTAR CLIENTES
		INSERT INTO [dbo].[Cliente] (Identificacion,Nombre)
		SELECT [identificacion],[nombre]
		FROM OPENXML (@hdoc, 'Operaciones_por_Dia/OperacionDia/ClienteNuevo',1)  
			WITH (	[identificacion]	VARCHAR(30)	'@Identificacion',  
					[nombre]			VARCHAR(30)	'@Nombre',  
					[fechaDeIngreso]	VARCHAR(30)	'../@fecha')
			WHERE fechaDeIngreso = @MinDate
		
		--INSERTAR COTRATOS
		INSERT INTO [dbo].[Contrato](idCliente,Numero,TipoTarifa,Fecha)
		SELECT C.id,[Numero],[TipoTarifa],CONVERT(DATE,[fechaDeIngreso1],121)[fechaDeIngreso1]
		FROM OPENXML (@hdoc, 'Operaciones_por_Dia/OperacionDia/NuevoContrato',1)
			WITH(	[Identificacion1]	VARCHAR(100)	'@Identificacion',
					[Numero]			VARCHAR(100)	'@Numero',
					[TipoTarifa]		VARCHAR(100)	'@TipoTarifa',
					[fechaDeIngreso1]	VARCHAR(100)	'../@fecha')
			INNER JOIN Cliente C ON C.Identificacion = [Identificacion1]
			WHERE [fechaDeIngreso1] = @MinDate

		--INSERTAR RELACIONES FAMILIARES
		INSERT INTO [dbo].[FamiliarDeCliente](idCliente,idFamiliar,TipoRelacion)
		SELECT CDe.id,CA.id,[TipoRelacion]
		FROM OPENXML(@hdoc, 'Operaciones_por_Dia/OperacionDia/RelacionFamiliar',1)
			WITH(	[IdentificacionDe]	VARCHAR(30)		'@IdentificacionDe',
					[IdentificacionA]	VARCHAR(30)		'@IdentificacionA',
					[TipoRelacion]		INT				'@TipoRelacion',
					[fechaDeIngreso2]	VARCHAR(100)	'../@fecha')
			INNER JOIN Cliente CDe ON CDe.Identificacion = [IdentificacionDe]
			INNER JOIN Cliente CA ON CA.Identificacion = [IdentificacionA]
			WHERE fechaDeIngreso2 = @MinDate

		--PROCESA LLAMADAS
		DECLARE @Llamadas LlamadasTipo
		INSERT INTO @Llamadas(numeroDe,numeroA,inicio,fin)
		SELECT [NumeroDe],[NumeroA],[Inicio],[Fin]
		FROM OPENXML (@hdoc, 'Operaciones_por_Dia/OperacionDia/LlamadaTelefonica',1) 
			WITH(	[NumeroDe]	VARCHAR(30)	'@NumeroDe',  
					[NumeroA]	VARCHAR(30)	'@NumeroA',  
					[Inicio]	TIME		'@Inicio',  
					[Fin]		TIME		'@Fin',
					[fechaDeIngreso3]	VARCHAR(100)	'../@fecha')
			WHERE fechaDeIngreso3 = @MinDate 
		EXEC [dbo].[SP_ProcesaLlamadas] @Llamadas,@MinDate
		DELETE @Llamadas
		
		--PROCESA DATOS
		DECLARE @Datos DatosTipo
		INSERT INTO @Datos(numero,CantMegas)
		SELECT [Numero],[CantidadMegas]
		FROM OPENXML(@hdoc, 'Operaciones_por_Dia/OperacionDia/UsoDatos',1)
			WITH(	[Numero]			VARCHAR(30)		'@Numero',
					[CantidadMegas]		FLOAT			'@CantMegas',
					[fechaDeIngreso4]	VARCHAR(100)	'../@fecha')
			WHERE fechaDeIngreso4 = @MinDate
		EXEC [dbo].[SP_ProcesaDatosMegas] @Datos,@MinDate
		DELETE @Datos

	SET @MinDate = dateadd(d,1,@MinDate) --INCREMENTA LA FECHA
	
END
EXEC sp_xml_removedocument @hdoc  
/*
USE [prograFinal]
DELETE [FamiliarDeCliente]
DELETE [Contrato]
DELETE [Cliente]
*/

USE [prograFinal]
DECLARE @XMLData XML
DECLARE @hdoc INT
SELECT @XMLData = C
FROM OPENROWSET (BULK 'C:\Users\emema\Documents\TEC\2020\SEM_I\BasesI\PrograFinal\proyectoFinalDB\archivosXML\configuracionTarifas.xml', SINGLE_BLOB) AS ReturnData(C)
EXEC sp_xml_preparedocument @hdoc OUTPUT, @XMLData


--INSERTA TIPO RELACION FAMILIAR.
INSERT INTO [dbo].[TipoRelacionFamiliar] ([id], [nombre])
	SELECT [ID],[Nombre]
	FROM OPENXML (@hdoc,'configTarifas/TipoRelacionFamiliar', 1)
		WITH(
			[ID] INT '@ID',
			[Nombre] VARCHAR(100) '@Nombre'
			)

--INSERTA TARIFAS
INSERT INTO [dbo].[TipoTarifa] ([id], [nombre])
	SELECT [ID],[Nombre]
	FROM OPENXML (@hdoc,'configTarifas/TipoTarifa', 1)
		WITH(
			[ID] INT '@ID',
			[Nombre] VARCHAR(100) '@Nombre'
			) 

--INSERTA ELEMENTOS DE TARIFA.(MEGAS Y MINS)
INSERT INTO [dbo].[TipoElemento] ([id], [nombre],[tipoValor])
	SELECT [ID],[Nombre],[tipoValor]
	FROM OPENXML (@hdoc,'configTarifas/TipoElemento', 1)
		WITH(
			[ID] INT '@ID',
			[Nombre] VARCHAR(100) '@Nombre',
			[tipoValor] VARCHAR(50) '@TipoValor'
			) 

--INSERTA RELACION ENTRE TARIFAS Y ELEMENTOS.
INSERT INTO [dbo].[ElementoDeTipoTarifa] ([idTipoTarifa], [idTipoElemento],[Valor])
	SELECT [idTarifa],[idElemento],[valor]
	FROM OPENXML (@hdoc,'configTarifas/ElementoDeTipoTarifa', 1)
		WITH(
			[idTarifa] INT '@IDTipoTarifa',
			[idElemento] VARCHAR(100) '@IDTipoElemento',
			[valor] VARCHAR(50) '@Valor'
			) 
EXEC sp_xml_removedocument @hdoc  
/*
DELETE ElementoDeTipoTarifa
DELETE TipoElemento
DELETE TipoTarifa
DELETE TipoRelacionFamiliar
*/
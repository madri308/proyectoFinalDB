USE [prograFinal]
CREATE TYPE DatosTipo AS TABLE (id INT IDENTITY(1,1),numero VARCHAR(30),CantMegas FLOAT) 
CREATE TYPE PagoFacturasTipo AS TABLE (id INT IDENTITY(1,1),numero VARCHAR(30)) 
CREATE TYPE LlamadasTipo AS TABLE (id INT IDENTITY(1,1),numeroDe VARCHAR(30), numeroA VARCHAR(30), inicio time,fin time) 
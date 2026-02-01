--Crear base de datos.
DROP DATABASE IF EXISTS Herboristeria
GO
CREATE DATABASE Herboristeria
GO
Use Herboristeria
GO

--Crear tablas, relaciones y claves

CREATE TABLE CLIENTE 
    (
     DNI_Cliente CHAR (9) NOT NULL , 
     Nombre_Cliente VARCHAR (50) NOT NULL , 
     Apellidos_Cliente VARCHAR (100) NOT NULL , 
     Teléfono_Cliente CHAR (9) NOT NULL , 
     Email_Cliente VARCHAR (100) , 
     Direccion_Cliente VARCHAR (250) 
    )
GO

ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_PK PRIMARY KEY CLUSTERED (DNI_Cliente)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Comisiones 
    (
     ID_Comision INTEGER IDENTITY(1,1) NOT NULL , 
     Total_Comision MONEY NOT NULL , 
     TRABAJADOR_DNI_Trabajador CHAR (9) NOT NULL , 
     VENTA_ID_Venta INTEGER NOT NULL 
    )
GO

ALTER TABLE Comisiones ADD CONSTRAINT Comisiones_PK PRIMARY KEY CLUSTERED (ID_Comision)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DETALLE_PEDIDO 
    (
     PRODUCTO_ID_Producto INTEGER NOT NULL , 
     PEDIDO_ID_Pedido INTEGER NOT NULL , 
     Cantidad_Pedido NUMERIC (28) NOT NULL , 
     Total_Pedido MONEY NOT NULL 
    )
GO

ALTER TABLE DETALLE_PEDIDO ADD CONSTRAINT Relation_4_PK PRIMARY KEY CLUSTERED (PRODUCTO_ID_Producto, PEDIDO_ID_Pedido)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DETALLE_VENTA 
    (
     PRODUCTO_ID_Producto INTEGER NOT NULL , 
     VENTA_ID_Venta INTEGER NOT NULL , 
     Cantidad_Producto NUMERIC (28) NOT NULL , 
     Total_Venta MONEY 
    )
GO

ALTER TABLE DETALLE_VENTA ADD CONSTRAINT Relation_6_PK PRIMARY KEY CLUSTERED (PRODUCTO_ID_Producto, VENTA_ID_Venta)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE HISTORICO 
    (
     ID_Movimiento INTEGER IDENTITY(1,1) NOT NULL , 
     Fecha_movimiento DATETIME2 NOT NULL , 
     Tipo_movimiento VARCHAR (8) NOT NULL , 
     Cantidad NUMERIC (28) NOT NULL , 
     PRODUCTO_ID_Producto INTEGER , 
     VENTA_ID_Venta INTEGER , 
     PEDIDO_ID_Pedido INTEGER 
    )
GO

ALTER TABLE HISTORICO ADD CONSTRAINT HISTORICO_PK PRIMARY KEY CLUSTERED (ID_Movimiento)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE PEDIDO 
    (
     ID_Pedido INTEGER IDENTITY(1,1) NOT NULL , 
     Fecha_Pedido DATETIME NOT NULL , 
     Tipo_Pedido VARCHAR (30) NOT NULL , 
     PROVEEDOR_CIF NVARCHAR (9) NOT NULL 
    )
GO

ALTER TABLE PEDIDO ADD CONSTRAINT PEDIDO_PK PRIMARY KEY CLUSTERED (ID_Pedido)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE PRODUCTO 
    (
     ID_Producto INTEGER IDENTITY(1,1) NOT NULL , 
     Nombre VARCHAR (30) NOT NULL , 
     Descripción VARCHAR (250) , 
     Tipo VARCHAR (255) NOT NULL , 
     PrecioVenta MONEY NOT NULL , 
     Propiedades VARCHAR (250) NOT NULL , 
     STOCK_ID_Stock INTEGER NOT NULL 
    )
GO 

CREATE UNIQUE NONCLUSTERED INDEX 
    PRODUCTO__IDX ON PRODUCTO 
    ( 
     STOCK_ID_Stock 
    ) 
GO

ALTER TABLE PRODUCTO ADD CONSTRAINT PRODUCTO_PK PRIMARY KEY CLUSTERED (ID_Producto)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Producto_Proveedor 
    (
     PROVEEDOR_CIF_1 NVARCHAR (9) NOT NULL , 
     PRODUCTO_ID_Producto INTEGER NOT NULL , 
     Precio_coste MONEY NOT NULL 
    )
GO

ALTER TABLE Producto_Proveedor ADD CONSTRAINT Producto_Proveedor_PK PRIMARY KEY CLUSTERED (PROVEEDOR_CIF_1, PRODUCTO_ID_Producto)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE PROVEEDOR 
    (
     CIF NVARCHAR (9) NOT NULL , 
     Nombre VARCHAR (50) NOT NULL , 
     Teléfono CHAR (9) NOT NULL , 
     Dirección VARCHAR (100) NOT NULL , 
     Web_Proveedor VARCHAR (50) 
    )
GO

ALTER TABLE PROVEEDOR ADD CONSTRAINT PROVEEDOR_PK PRIMARY KEY CLUSTERED (CIF)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE STOCK 
    (
     PRODUCTO_ID_Producto INTEGER NOT NULL , 
     Cantidad_Stock NUMERIC (28) NOT NULL 
    )
GO 

CREATE UNIQUE NONCLUSTERED INDEX 
    STOCK__IDX ON STOCK 
    ( 
     PRODUCTO_ID_Producto 
    ) 
GO

ALTER TABLE STOCK ADD CONSTRAINT STOCK_PK PRIMARY KEY CLUSTERED (PRODUCTO_ID_Producto)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE TRABAJADOR 
    (
     DNI_Trabajador CHAR (9) NOT NULL , 
     Nombre_trabajador VARCHAR (50) NOT NULL , 
     Apellidos_Trabajador VARCHAR (100) NOT NULL , 
     Telefono_trabajador CHAR (9) NOT NULL , 
     Direccion_Trabajador VARCHAR (250) NOT NULL , 
     Fecha_Alta DATE NOT NULL , 
     Tipo_Contrato VARCHAR (12) , 
     Horas_Semanales TINYINT NOT NULL , 
     Salario_Trabajador MONEY NOT NULL , 
     Incentivos_Trabajador MONEY 
    )
GO

ALTER TABLE TRABAJADOR ADD CONSTRAINT TRABAJADOR_PK PRIMARY KEY CLUSTERED (DNI_Trabajador)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE VENTA 
    (
     ID_Venta INTEGER IDENTITY(1,1) NOT NULL , 
     Fecha_Venta DATETIME2 NOT NULL , 
     TRABAJADOR_DNI_Trabajador CHAR (9) NOT NULL , 
     CLIENTE_DNI_Cliente CHAR (9) NOT NULL 
    )
GO

ALTER TABLE VENTA ADD CONSTRAINT VENTA_PK PRIMARY KEY CLUSTERED (ID_Venta)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Comisiones 
    ADD CONSTRAINT Comisiones_TRABAJADOR_FK FOREIGN KEY 
    ( 
     TRABAJADOR_DNI_Trabajador
    ) 
    REFERENCES TRABAJADOR 
    ( 
     DNI_Trabajador 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Comisiones 
    ADD CONSTRAINT Comisiones_VENTA_FK FOREIGN KEY 
    ( 
     VENTA_ID_Venta
    ) 
    REFERENCES VENTA 
    ( 
     ID_Venta 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE HISTORICO 
    ADD CONSTRAINT HISTORICO_PEDIDO_FK FOREIGN KEY 
    ( 
     PEDIDO_ID_Pedido
    ) 
    REFERENCES PEDIDO 
    ( 
     ID_Pedido 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE HISTORICO 
    ADD CONSTRAINT HISTORICO_PRODUCTO_FK FOREIGN KEY 
    ( 
     PRODUCTO_ID_Producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     ID_Producto 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE HISTORICO 
    ADD CONSTRAINT HISTORICO_VENTA_FK FOREIGN KEY 
    ( 
     VENTA_ID_Venta
    ) 
    REFERENCES VENTA 
    ( 
     ID_Venta 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE PEDIDO 
    ADD CONSTRAINT PEDIDO_PROVEEDOR_FK FOREIGN KEY 
    ( 
     PROVEEDOR_CIF
    ) 
    REFERENCES PROVEEDOR 
    ( 
     CIF 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Producto_Proveedor 
    ADD CONSTRAINT Producto_Proveedor_PRODUCTO_FK FOREIGN KEY 
    ( 
     PRODUCTO_ID_Producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     ID_Producto 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Producto_Proveedor 
    ADD CONSTRAINT Producto_Proveedor_PROVEEDOR_FK FOREIGN KEY 
    ( 
     PROVEEDOR_CIF_1
    ) 
    REFERENCES PROVEEDOR 
    ( 
     CIF 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DETALLE_PEDIDO 
    ADD CONSTRAINT Relation_4_PEDIDO_FK FOREIGN KEY 
    ( 
     PEDIDO_ID_Pedido
    ) 
    REFERENCES PEDIDO 
    ( 
     ID_Pedido 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DETALLE_PEDIDO 
    ADD CONSTRAINT Relation_4_PRODUCTO_FK FOREIGN KEY 
    ( 
     PRODUCTO_ID_Producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     ID_Producto 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT Relation_6_PRODUCTO_FK FOREIGN KEY 
    ( 
     PRODUCTO_ID_Producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     ID_Producto 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT Relation_6_VENTA_FK FOREIGN KEY 
    ( 
     VENTA_ID_Venta
    ) 
    REFERENCES VENTA 
    ( 
     ID_Venta 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE STOCK 
    ADD CONSTRAINT STOCK_PRODUCTO_FK FOREIGN KEY 
    ( 
     PRODUCTO_ID_Producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     ID_Producto 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_DNI_Cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     DNI_Cliente 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_TRABAJADOR_FK FOREIGN KEY 
    ( 
     TRABAJADOR_DNI_Trabajador
    ) 
    REFERENCES TRABAJADOR 
    ( 
     DNI_Trabajador 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

------- Insertamos datos
--cliente
INSERT INTO CLIENTE VALUES ('12345678A','Laura','Serrano Pérez','611223344','laura.serrano@gmail.com','C/ Magnolia 21, Madrid');
INSERT INTO CLIENTE VALUES ('87654321B','Javier','Moreno Díaz','622334455','javier.moreno@yahoo.es','Av. Robles 45, Sevilla');
INSERT INTO CLIENTE VALUES ('55555555C','Lucía','Gómez Torres','633445566','lucia.gomez@hotmail.com','C/ Sauce 14, Valencia');
GO
--Trabajador
INSERT INTO TRABAJADOR VALUES ('11111111D','Carmen','Ruiz López','644556677','C/ Verde 8, Madrid','2023-01-10','Fijo',40,1450,100);
INSERT INTO TRABAJADOR VALUES ('22222222E','Pablo','Hernández Vega','655667788','Av. Sierra 17, Córdoba','2024-02-05','Temporal',30,1200,NULL);
GO

--Proveedor
INSERT INTO PROVEEDOR VALUES ('H12345678','HerbaVida Natural S.L.','911223344','C/ Romero 12, Granada','www.herbavida.es');
INSERT INTO PROVEEDOR VALUES ('B23456789','EcoSierra Distribuciones','922334455','Polígono Las Flores, Málaga','www.ecosierra.com');
INSERT INTO PROVEEDOR VALUES ('C34567890','BioOrigen','933445566','C/ Laurel 5, Barcelona','www.bioon.es');
GO

--Pedido 
INSERT INTO PEDIDO (Fecha_Pedido,Tipo_Pedido,PROVEEDOR_CIF)
VALUES ('2024-09-01','Reposición','H12345678'),
       ('2024-09-10','Urgente','B23456789'),
       ('2024-10-02','Reposición','C34567890');
GO

-- Producto
INSERT INTO PRODUCTO (Nombre,Descripción,Tipo,PrecioVenta,Propiedades,STOCK_ID_Stock)
VALUES ('Té Verde Ecológico','Hojas de té verde premium','Infusión',6.50,'Antioxidante, Energizante',1),
       ('Aceite de Árnica','Aceite natural para masajes musculares','Aceite esencial',12.00,'Antiinflamatorio, Calmante',2),
       ('Miel de Romero','Miel pura de origen nacional','Alimento',8.90,'Energizante, Suaviza garganta',3);
GO

-- Stock
INSERT INTO STOCK VALUES (1,150);
INSERT INTO STOCK VALUES (2,80);
INSERT INTO STOCK VALUES (3,60);
GO

--Producto_Proveedor
INSERT INTO Producto_Proveedor VALUES ('H12345678',1,4.00);
INSERT INTO Producto_Proveedor VALUES ('B23456789',2,7.00);
INSERT INTO Producto_Proveedor VALUES ('C34567890',3,5.50);
Go

--Venta 
INSERT INTO VENTA (Fecha_Venta,TRABAJADOR_DNI_Trabajador,CLIENTE_DNI_Cliente)
VALUES ('2024-10-05','11111111D','12345678A'),
       ('2024-10-07','22222222E','87654321B'),
       ('2024-10-08','11111111D','55555555C');
GO

--DETALLE_PEDIDO
INSERT INTO DETALLE_PEDIDO VALUES (1,1,50,200.00);
INSERT INTO DETALLE_PEDIDO VALUES (2,2,20,140.00);
INSERT INTO DETALLE_PEDIDO VALUES (3,3,30,165.00);
GO

--DETALLE_VENTA
INSERT INTO DETALLE_VENTA VALUES (1,1,2,13.00);
INSERT INTO DETALLE_VENTA VALUES (2,2,1,12.00);
INSERT INTO DETALLE_VENTA VALUES (3,3,3,26.70);
GO

--COMISIONES
INSERT INTO Comisiones (Total_Comision,TRABAJADOR_DNI_Trabajador,VENTA_ID_Venta)
VALUES (3.00,'11111111D',1),
       (2.50,'22222222E',2),
       (4.00,'11111111D',3);
GO

--Historico
    -- Entradas por pedidos
INSERT INTO HISTORICO (Fecha_movimiento,Tipo_movimiento,Cantidad,PRODUCTO_ID_Producto,PEDIDO_ID_Pedido)
VALUES ('2024-09-01','ENTRADA',50,1,1),
       ('2024-09-10','ENTRADA',20,2,2),
       ('2024-10-02','ENTRADA',30,3,3);
GO
    -- Salidas por ventas
INSERT INTO HISTORICO (Fecha_movimiento,Tipo_movimiento,Cantidad,PRODUCTO_ID_Producto,VENTA_ID_Venta)
VALUES ('2024-10-05','VENTA',2,1,1),
       ('2024-10-07','VENTA',1,2,2),
       ('2024-10-08','VENTA',3,3,3);
GO

-- Trigger -- 
CREATE OR ALTER TRIGGER tr_DETALLE_PEDIDO_InsertarHistorico
ON dbo.DETALLE_PEDIDO
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.HISTORICO (
        Fecha_movimiento,
        Tipo_movimiento,
        Cantidad,
        PRODUCTO_ID_Producto,
        PEDIDO_ID_Pedido,
        VENTA_ID_Venta
    )
    SELECT
        dbo.PEDIDO.Fecha_Pedido,       -- 1. La fecha (de la tabla PEDIDO)
        'PEDIDO',                      -- 2. El tipo de movimiento (fijo)
        inserted.Cantidad_Pedido,      -- 3. La cantidad (de la fila insertada)
        inserted.PRODUCTO_ID_Producto, -- 4. El ID del producto (de la fila insertada)
        inserted.PEDIDO_ID_Pedido,     -- 5. El ID del pedido (de la fila insertada)
        NULL                           -- 6. VENTA_ID_Venta es nulo
    FROM
        inserted
    -- Unimos con la tabla PEDIDO para obtener la Fecha_Pedido
    JOIN
        dbo.PEDIDO ON inserted.PEDIDO_ID_Pedido = dbo.PEDIDO.ID_Pedido;
END;
GO

CREATE OR ALTER TRIGGER tr_DETALLE_VENTA_InsertarHistorico
ON dbo.DETALLE_VENTA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.HISTORICO (
        Fecha_movimiento,
        Tipo_movimiento,
        Cantidad,
        PRODUCTO_ID_Producto,
        PEDIDO_ID_Pedido,
        VENTA_ID_Venta
    )
    SELECT
        dbo.VENTA.Fecha_Venta,         -- 1. La fecha (de la tabla VENTA)
        'VENTA',                       -- 2. El tipo de movimiento (fijo)
        inserted.Cantidad_Producto,    -- 3. La cantidad (de la fila insertada)
        inserted.PRODUCTO_ID_Producto, -- 4. El ID del producto (de la fila insertada)
        NULL,                          -- 5. PEDIDO_ID_Pedido es nulo
        inserted.VENTA_ID_Venta        -- 6. El ID de la venta (de la fila insertada)
    FROM
        inserted
    -- Unimos con la tabla VENTA para obtener la Fecha_Venta
    JOIN
        dbo.VENTA ON inserted.VENTA_ID_Venta = dbo.VENTA.ID_Venta;
END;
GO

--- Vista
CREATE OR ALTER VIEW Vista_Ventas_Herboristeria AS
SELECT 
    V.ID_Venta,
    V.Fecha_Venta,
    C.Nombre_Cliente + ' ' + C.Apellidos_Cliente AS Cliente,
    T.Nombre_Trabajador + ' ' + T.Apellidos_Trabajador AS Trabajador,
    P.Nombre AS Producto,
    DV.Cantidad_Producto AS 'Cantidad Comprada',
    DV.Total_Venta
FROM VENTA V
JOIN CLIENTE C ON V.CLIENTE_DNI_Cliente = C.DNI_Cliente
JOIN TRABAJADOR T ON V.TRABAJADOR_DNI_Trabajador = T.DNI_Trabajador
JOIN DETALLE_VENTA DV ON V.ID_Venta = DV.VENTA_ID_Venta
JOIN PRODUCTO P ON DV.PRODUCTO_ID_Producto = P.ID_Producto;
GO
select * from Vista_Ventas_Herboristeria
GO

-- Procedimiento almacenado
CREATE OR ALTER PROC CAMBIAR_PRECIO
@nombre varchar(100),
@nuevoprecio money
AS
Begin 
update PRODUCTO
set PrecioVenta = @nuevoprecio
where Nombre = @nombre
end
GO
SELECT * FROM PRODUCTO
GO

EXEC CAMBIAR_PRECIO
@NOMBRE = 'Miel de Romero',
@nuevoprecio = 8.90;
GO

-- transaccion explicita
BEGIN TRANSACTION;  -- Iniciamos la transacción
BEGIN TRY
    --  Insertar la nueva venta
    INSERT INTO VENTA (Fecha_Venta, TRABAJADOR_DNI_Trabajador, CLIENTE_DNI_Cliente)
    VALUES (GETDATE(), '11111111D', '55555555C');

    -- Guardar el ID de la venta recién creada
    DECLARE @NuevaVentaID INT = SCOPE_IDENTITY();

    -- Insertar detalle de la venta (1 unidad de Té Verde)
    INSERT INTO DETALLE_VENTA (PRODUCTO_ID_Producto, VENTA_ID_Venta, Cantidad_Producto, Total_Venta)
    VALUES (1, @NuevaVentaID, 1, 6.50);

    -- Actualizar el stock del producto vendido
    UPDATE STOCK
    SET Cantidad_Stock = Cantidad_Stock - 1
    WHERE PRODUCTO_ID_Producto = 1;

    -- 4?? Registrar el movimiento en el histórico
    INSERT INTO HISTORICO (Fecha_movimiento, Tipo_movimiento, Cantidad, PRODUCTO_ID_Producto, VENTA_ID_Venta)
    VALUES (GETDATE(), 'VENTA', 1, 1, @NuevaVentaID);

    -- Si todo sale bien, confirmamos
    COMMIT TRANSACTION;
    PRINT '? Transacción completada correctamente.';
END TRY
BEGIN CATCH
    -- Si hay error, revertimos todo
    ROLLBACK TRANSACTION;

    PRINT '? Error en la transacción.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO
------ IMAGENES-----
CREATE TABLE IMAGENES (
nombre varchar(50),
nombre_archivo varchar(250),
imagen varbinary (max)
)
GO

exec sp_configure 'show advanced options',1;
GO
reconfigure;
GO
exec sp_configure 'Ole Automation Procedures', 1;
GO
Reconfigure;
GO
-- añadir usuario al rol bulkadmin
alter server role bulkadmin add member [DESKTOP-0LPE2C0\Usuario]
go
-- Crear carpeta
xp_cmdshell "mkdir C:\PruebaImportar"
GO
--

CREATE OR ALTER PROCEDURE importar_imagen(
    @imagen NVARCHAR (100),
    @ImageFolderPath NVARCHAR (1000),
    @Filename NVARCHAR (1000)
   )
AS
BEGIN
   DECLARE @Path2OutFile NVARCHAR (2000);
   DECLARE @tsql NVARCHAR (2000);
   SET NOCOUNT ON;
   SET @Path2OutFile = CONCAT (@ImageFolderPath,'\', @Filename);
   SET @tsql = 'insert into imagenes (nombre, nombre_archivo, imagen) ' +
               ' SELECT ' + '''' + @imagen + '''' + ',' + '''' + @Filename + '''' + ', * ' + 
               ' FROM Openrowset( Bulk ' + '''' + @Path2OutFile + '''' + ', Single_Blob) as img'
   EXEC (@tsql)
END
GO

execute importar_imagen 'te', 'C:\PruebaImportar', 'te.jpg';
execute importar_imagen 'Aceite', 'C:\PruebaImportar', 'aceite.png';
select * from IMAGENES
GO

xp_cmdshell "mkdir C:\PruebaExportar"
GO

CREATE OR ALTER PROCEDURE Exportar_imagen (
   @nombre NVARCHAR (100)
   ,@ImageFolderPath NVARCHAR(1000)
   ,@Filename NVARCHAR(1000)
   )
AS
BEGIN
   DECLARE @ImageData VARBINARY (max);
   DECLARE @Path2OutFile NVARCHAR (2000);
   DECLARE @Obj INT
   SET NOCOUNT ON;
   SELECT @ImageData = (
         SELECT convert (VARBINARY (max), imagen, 1)
         FROM IMAGENES
         WHERE nombre = @nombre
         );
   SET @Path2OutFile = CONCAT (
         @ImageFolderPath
         ,'\'
         , @Filename
         );
    BEGIN TRY
     EXEC sp_OACreate 'ADODB.Stream' ,@Obj OUTPUT;
     EXEC sp_OASetProperty @Obj ,'Type',1;
     EXEC sp_OAMethod @Obj,'Open';
     EXEC sp_OAMethod @Obj,'Write', NULL, @ImageData;
     EXEC sp_OAMethod @Obj,'SaveToFile', NULL, @Path2OutFile, 2;
     EXEC sp_OAMethod @Obj,'Close';
     EXEC sp_OADestroy @Obj;
    END TRY
 BEGIN CATCH
  EXEC sp_OADestroy @Obj;
 END CATCH
   SET NOCOUNT OFF;
END
GO

execute Exportar_imagen 'te', 'C:\PruebaExportar', 'te.jpg';
GO


-----------BBDD Contenida----------------

EXEC SP_CONFIGURE 'show advanced options', 1 
RECONFIGURE
EXEC SP_CONFIGURE 'contained database authentication', 1
RECONFIGURE
GO

DROP DATABASE IF EXISTS Herboristeria_contenida
GO
CREATE DATABASE Herboristeria_contenida
CONTAINMENT=PARTIAL
GO

USE Herboristeria_contenida
go
DROP USER IF EXISTS Ainhoa
CREATE USER Ainhoa 
	WITH PASSWORD='Abcd1234.'
GO
ALTER ROLE db_owner
ADD MEMBER Ainhoa
GO
GRANT CONNECT TO Ainhoa
GO



--------BLOB----------
-- Añadimos una columna "imagen" a la tabla Producto
ALTER TABLE PRODUCTO
ADD imagen VARBINARY(MAX)
GO
-- Ahora insertaremos las imágenes.
UPDATE PRODUCTO
SET imagen = (SELECT BULKCOLUMN
FROM OPENROWSET(BULK N'C:\ImagenesProductos\te_verde.jpg', SINGLE_BLOB) AS imagen)
WHERE Producto.ID_Producto = 1;
GO

UPDATE PRODUCTO
SET imagen = (SELECT BULKCOLUMN
FROM OPENROWSET(BULK N'C:\ImagenesProductos\aceite.jpg', SINGLE_BLOB) AS imagen)
WHERE Producto.ID_Producto = 2;
GO

UPDATE PRODUCTO
SET imagen = (SELECT BULKCOLUMN
FROM OPENROWSET(BULK N'C:\ImagenesProductos\miel_romero.jpg', SINGLE_BLOB) AS imagen)
WHERE Producto.ID_Producto = 3;
GO

UPDATE PRODUCTO
SET imagen = (SELECT BULKCOLUMN
FROM OPENROWSET(BULK N'C:\ImagenesProductos\lavanda.jpg', SINGLE_BLOB) AS imagen)
WHERE Producto.ID_Producto = 1004;
GO

UPDATE PRODUCTO
SET imagen = (SELECT BULKCOLUMN
FROM OPENROWSET(BULK N'C:\ImagenesProductos\curcuma.jpg', SINGLE_BLOB) AS imagen)
WHERE Producto.ID_Producto = 1005;
GO

select * from Producto
GO
------FILESTREAM---------
USE Herboristeria_contenida
-- Creamos el filegroup
ALTER DATABASE Herboristeria_contenida
ADD FILEGROUP imagenes CONTAINS FILESTREAM;
GO
-- añadimos el fichero donde vamos a almacenar el filegroup (las imagenes)
ALTER DATABASE [Herboristeria_contenida]
ADD FILE (NAME='imagenes',
FILENAME = 'C:\Imagenesfilename')
TO FILEGROUP imagenes
GO
select * from sys.filegroups
GO

--Creamos la tabla.
CREATE TABLE [dbo].[PRODUCTO](
	[ID_Producto] [int] IDENTITY(1,1) NOT NULL,
    [ID2] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE, 
    [Imagen] VARBINARY(MAX) FILESTREAM,
    [Nombre] [varchar](30) NOT NULL,
	[Descripción] [varchar](250) NULL,
	[Tipo] [varchar](255) NOT NULL,
	[PrecioVenta] [money] NOT NULL,
	[Propiedades] [varchar](250) NOT NULL,
	[STOCK_ID_Stock] [int] NOT NULL)
GO

insert into PRODUCTO (ID2,Imagen,Nombre,Descripción,Tipo,PrecioVenta,Propiedades,STOCK_ID_Stock)
SELECT NEWID(),BULKCOLUMN,'Té Verde','Hojas de té verde', 'Infusión', '5.50','relajante', 2
	FROM OPENROWSET(BULK 'C:\ImagenesProductos\te_verde.jpg', SINGLE_BLOB) AS FOTO
GO

select * from PRODUCTO
GO

---------------------------------------
-----FILETABLE--------------
use master
GO
ALTER DATABASE [HerboristeriaDBA]
SET FILESTREAM (DIRECTORY_NAME = 'imagenes')
WITH ROLLBACK IMMEDIATE
GO

ALTER DATABASE [HerboristeriaDBA]
SET FILESTREAM(NON_TRANSACTED_ACCESS = FULL,
DIRECTORY_NAME = 'imagenes')
WITH ROLLBACK IMMEDIATE
GO

ALTER DATABASE [HerboristeriaDBA]
ADD FILEGROUP [FG_FileStream] CONTAINS FILESTREAM;
GO

ALTER DATABASE [HerboristeriaDBA]
ADD FILE (
    NAME = 'HerboristeriaDBA_imagenes',
    FILENAME = 'C:\HerboristeriaDBA' -- Esta carpeta NO debe existir, SQL la crea
)
TO FILEGROUP [FG_FileStream];
GO



--Creamos la tabla
CREATE TABLE Imagenes AS FileTable
WITH
(
    FileTable_Directory = 'imagenes',
    FileTable_Collate_Filename = database_default,
    FILETABLE_STREAMID_UNIQUE_CONSTRAINT_NAME = UQ_stream_id
);
GO

select * from imagenes
GO


/*
-----------------------------------
-----------------------------------
--------- Particiones -------------
-----------------------------------
-----------------------------------
*/
-- 1. Crear directorio desde cmdshell.

EXECUTE sp_configure 'xp_cmdshell', 1;
GO
RECONFIGURE;
GO
xp_cmdshell 'mkdir C:\Particiones\'
GO

-- 2. Crear la base de datos.
CREATE DATABASE Herboristeria_particiones 
	ON PRIMARY ( NAME = 'Herboristeria_particiones', 
		FILENAME = 'C:\Particiones\Herboristeria_particiones.mdf' , 
		SIZE = 15360KB , MAXSIZE = UNLIMITED, FILEGROWTH = 0) 
	LOG ON ( NAME = 'Herboristeria_particiones_log', 
		FILENAME = 'C:\Particiones\Herboristeria_particiones_log.ldf' , 
		SIZE = 10176KB , MAXSIZE = 2048GB , FILEGROWTH = 10%) 
GO

-- 3. Crear filegroups.

ALTER DATABASE [Herboristeria_particiones] ADD FILEGROUP [FG_Antiguos] 
GO 
ALTER DATABASE [Herboristeria_particiones] ADD FILEGROUP [FG_2022] 
GO 
ALTER DATABASE [Herboristeria_particiones] ADD FILEGROUP [FG_2023]  
GO 
ALTER DATABASE [Herboristeria_particiones] ADD FILEGROUP [FG_2024] 
GO 
ALTER DATABASE [Herboristeria_particiones] ADD FILEGROUP [FG_2025] 
GO 

-- 3. Crear nuevos archivos en la base de datos.
ALTER DATABASE [Herboristeria_particiones] ADD FILE ( NAME = 'FG_Antiguos', FILENAME = 'c:\Particiones\FG_Antiguos.ndf', SIZE = 5MB, MAXSIZE = 100MB, FILEGROWTH = 2MB ) TO FILEGROUP [FG_Antiguos] 
GO
ALTER DATABASE [Herboristeria_particiones] ADD FILE ( NAME = 'FG_2022', FILENAME = 'c:\Particiones\FG_2022.ndf', SIZE = 5MB, MAXSIZE = 100MB, FILEGROWTH = 2MB ) TO FILEGROUP [FG_2022] 
GO
ALTER DATABASE [Herboristeria_particiones] ADD FILE ( NAME = 'FG_2023', FILENAME = 'c:\Particiones\FG_2023.ndf', SIZE = 5MB, MAXSIZE = 100MB, FILEGROWTH = 2MB ) TO FILEGROUP [FG_2023] 
GO
ALTER DATABASE [Herboristeria_particiones] ADD FILE ( NAME = 'FG_2024', FILENAME = 'c:\Particiones\FG_2024.ndf', SIZE = 5MB, MAXSIZE = 100MB, FILEGROWTH = 2MB ) TO FILEGROUP [FG_2024] 
GO
ALTER DATABASE [Herboristeria_particiones] ADD FILE ( NAME = 'FG_2025', FILENAME = 'c:\Particiones\FG_2025.ndf', SIZE = 5MB, MAXSIZE = 100MB, FILEGROWTH = 2MB ) TO FILEGROUP [FG_2025] 
GO

-- Comprobar
SELECT file_id, name, physical_name 
from sys.database_files
go

-- 4. Crear funcion de particion 
CREATE PARTITION FUNCTION Fecha_ventas (datetime) 
AS RANGE RIGHT 
	FOR VALUES ('2022-01-01','2023-01-01') --SOLO 2 CORTES
GO

-- 5. Crear Esquema de particion
CREATE PARTITION SCHEME Fecha_ventas 
AS PARTITION Fecha_ventas                    
TO (FG_Antiguos, FG_2022, FG_2023, FG_2024, FG_2025)
GO

-- 6. Crear tabla
CREATE TABLE VENTA 
    (
     ID_Venta INTEGER IDENTITY(1,1) NOT NULL ,
     Fecha_Venta DATETIME NOT NULL,
          TRABAJADOR_DNI_Trabajador CHAR (9) NOT NULL , 
     CLIENTE_DNI_Cliente CHAR (9) NOT NULL
     )
        on Fecha_ventas -- Nombre Función
            (Fecha_Venta) -- Nombre Columna sobre la que divido
GO

-- Insertar datos para muestra. Generados por IA
INSERT INTO VENTA (Fecha_Venta, TRABAJADOR_DNI_Trabajador, CLIENTE_DNI_Cliente)
VALUES 
    ('2021-12-31 23:59:00', '11111111A', 'CLIENTE01'),
    ('2022-01-01 00:00:00', '22222222B', 'CLIENTE02'), 
    ('2022-06-15 14:30:00', '33333333C', 'CLIENTE03'), 
    ('2023-01-01 00:00:00', '44444444D', 'CLIENTE04'), 
    ('2024-05-20 09:00:00', '55555555E', 'CLIENTE05'); 
GO

SELECT *,$Partition.Fecha_ventas(Fecha_Venta) AS Partition
FROM VENTA
GO

select p.partition_number, p.rows from sys.partitions p 
inner join sys.tables t 
on p.object_id=t.object_id and t.name = 'Venta' 
GO

----- SPLIT -----
ALTER PARTITION FUNCTION Fecha_ventas() 
SPLIT RANGE ('2024-01-01'); 
GO

SELECT *,$Partition.Fecha_ventas(Fecha_Venta) AS Partition
FROM VENTA
GO

select p.partition_number, p.rows from sys.partitions p 
inner join sys.tables t 
on p.object_id=t.object_id and t.name = 'Venta' 
GO

---- MERGE ----
ALTER PARTITION FUNCTION Fecha_ventas()
MERGE RANGE ('2022-01-01');
GO

SELECT *,$Partition.Fecha_ventas(Fecha_Venta) AS Partition
FROM VENTA
GO

select p.partition_number, p.rows from sys.partitions p 
inner join sys.tables t 
on p.object_id=t.object_id and t.name = 'Venta' 
GO

---- SWTICH -----
DROP TABLE IF EXISTS Archivo_Ventas 
GO
CREATE TABLE Archivo_Ventas 
( 
    ID_Venta INTEGER IDENTITY(1,1) NOT NULL,
    Fecha_Venta DATETIME NOT NULL,
    TRABAJADOR_DNI_Trabajador CHAR (9) NOT NULL, 
    CLIENTE_DNI_Cliente CHAR (9) NOT NULL
) 
ON [FG_Antiguos]
GO

ALTER TABLE VENTA 
SWITCH PARTITION 1 TO Archivo_Ventas
GO

select * from Archivo_Ventas
Select * from VENTA
GO

---------- Truncate -------------

SELECT *,$Partition.Fecha_ventas(Fecha_Venta) AS Partition
FROM VENTA
GO

TRUNCATE TABLE VENTA 
	WITH (PARTITIONS (3));
GO

SELECT *,$Partition.Fecha_ventas(Fecha_Venta) AS Partition
FROM VENTA
GO

USE [master]
GO
--Validaci�n si la DB existe
IF(db_id('DBVENTAS')IS NOT NULL)
--si existe la elimina
 DROP DATABASE DBVENTAS
--Creaci�n de DB
CREATE DATABASE [DBVENTAS]
GO
USE [DBVENTAS]
GO

/*===============================CREACION DE TABLAS==========================================*/
--Tabla categor�a
CREATE TABLE [dbo].[Categoria](
	ID_CATEGORIA integer PRIMARY KEY IDENTITY,
	CODIGO AS ('CT' + RIGHT('0000' + CONVERT(VARCHAR, ID_CATEGORIA),(4))),
	DESCRIPCION varchar(50) NOT NULL UNIQUE,	
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL
);
GO

--Tabla marca
CREATE TABLE [dbo].[Marca](
	ID_MARCA int PRIMARY KEY IDENTITY,
	CODIGO AS ('MC' + RIGHT('0000' + CONVERT(VARCHAR, ID_MARCA),(4))),
	DESCRIPCION varchar(50) NOT NULL UNIQUE,
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL
);
GO
--Tabla art�culo
CREATE TABLE [dbo].[Producto](
	ID_PRODUCTO integer PRIMARY KEY IDENTITY,
	CODIGO AS ('PD' + RIGHT('0000' + CONVERT(VARCHAR, ID_PRODUCTO),(4))),
	FK_ID_CATEGORIA integer NOT NULL,
	FK_ID_MARCA integer NOT NULL,	
	DESCRIPCION varchar(100) NOT NULL unique,
	PRECIO_UNIT decimal(11,2) NOT NULL,
	STOCK integer NOT NULL,
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL,
	FOREIGN KEY (FK_ID_CATEGORIA) REFERENCES Categoria(ID_CATEGORIA),
	FOREIGN KEY (FK_ID_MARCA) REFERENCES Marca (ID_MARCA)
);
GO

--Tabla cliente
CREATE TABLE [dbo].[Cliente](
	ID_CLIENTE integer PRIMARY KEY IDENTITY(1,1),
	CODIGO AS ('CL' + RIGHT('0000' + CONVERT(VARCHAR, ID_CLIENTE),(4))),
    NOMBRE varchar(100) NOT NULL,	
    APE_PATERNO varchar(100) NOT NULL,
	APE_MATERNO varchar(100) NOT NULL,
	DNI varchar(8) NOT NULL,
	GENERO char(1) check(GENERO IN('M','F')) NOT NULL,--M: Masculino	F:Femenina
	TELEFONO varchar(20) NOT NULL,	
    DIRECCION varchar(70) NOT NULL,
	EMAIL varchar(50) NOT NULL,      
	ESTADO char(1) check(Estado IN('E','H')) NOT NULL,--E: Eventual		H:Habitual
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL
);
GO

--Tabla rol
CREATE TABLE [dbo].[Rol](
	ID_ROL integer PRIMARY KEY IDENTITY,
	CODIGO AS ('RL' + RIGHT('0000' + CONVERT(VARCHAR, ID_ROL),(4))),
    DESCRIPCION varchar(30) NOT NULL,
    ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL
);
GO

INSERT INTO Rol (DESCRIPCION,FECHA_INS) VALUES('Administrador',GETDATE())
INSERT INTO Rol (DESCRIPCION,FECHA_INS) VALUES('Operario',GETDATE())
INSERT INTO Rol (DESCRIPCION,FECHA_INS) VALUES('Vendedor',GETDATE())
--select * from Rol

GO
----Tabla persona
--CREATE TABLE [dbo].[Persona](
--	ID_PERSONA integer PRIMARY KEY IDENTITY(1,1),
--   NOMBRE varchar(100) NOT NULL,
--   APE_PATERNO varchar(100) NOT NULL,
--	APE_MATERNO varchar(100) NOT NULL,
--	DNI integer NOT NULL,
--	FECHA_NAC date NOT NULL,
--	GENERO bit NOT NULL,
--	EMAIL varchar(50) NOT NULL,
--   DIRECCION varchar(70) NOT NULL,
--	DEPARTAMENTO varchar(50) NOT NULL,
--	PROVINCIA varchar(70) NOT NULL,
--	DISTRITO varchar(70) NOT NULL,
--   TELEFONO varchar(20) NOT NULL,    
--	ELIM_LOGICO bit default(1),
--	FECHA_INS datetime NULL,
--	FECHA_UPD datetime NULL,
--	FECHA_DEL datetime NULL
--);
--GO

--CREATE TABLE [dbo].[Usuario](
--	[ID_USUARIO] [int] IDENTITY(1,1) NOT NULL,
--	[ID_PERSONA] [int] NOT NULL,
--	[Username] [nvarchar](20) NOT NULL,
--	[Password] [nvarchar](20) NOT NULL,
----	[Email] [nvarchar](30) NOT NULL,
--	[CreatedDate] [datetime] NOT NULL,
--	[LastLoginDate] [datetime] NULL,
-- CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
--(
--	[ID_USUARIO] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO
go

CREATE TABLE Proveedor(
	ID_PROVEEDOR integer PRIMARY KEY IDENTITY(1,1),
	CODIGO AS ('CL' + RIGHT('0000' + CONVERT(VARCHAR, ID_PROVEEDOR),(4))),
    DATOS varchar(100) NOT NULL,
	RUC varchar(11) NOT NULL,
	REPRESENTANTE varchar(100) NOT NULL,
	TELEFONO varchar(20) NOT NULL,	
    DIRECCION varchar(70) NOT NULL,
	EMAIL varchar(50) NOT NULL,      
	ESTADO char(1) check(Estado IN('A','I')) NOT NULL,--E: Activo		H:Inactivo
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL
)
go
Create Table Pedido_Compra
(	ID_PEDIDOCOMPRA int identity(1,1) Primary Key,
	ID_PROVEEDOR int foreign key references Proveedor ,	
	FECHAPEDIDOCOMPRA datetime not null,
	ESTADO char(1) check(Estado in('E','A','P')) not null,--E: Entregado A:Anulada P:Pendiente
	ID_USUARIO int references Usuario,
	MONTOTOTAL money Check(MONTOTOTAL>=0) not null,
	MONTOFLETE money Check(MONTOFLETE>=0) null,
)
go
 
 Create Table Detalle_Pedido
(	ID_DETALLEPEDIDO int identity(1,1) primary key,
	ID_PEDIDOCOMPRA int  foreign key references Pedido_Compra,
	ID_PRODUCTO INT  references Producto ,
	PRECIOCOMPRA smallmoney  not null,--Precio de Pedido
	CANTIDAD int check(Cantidad>=0) not null
)
GO

--CREATE PROCEDURE [dbo].[Insert_User]
--	@ID_PERSONA int,
--	@Username NVARCHAR(20),
--	@Password NVARCHAR(20)
----	@Email NVARCHAR(30)
--AS
--BEGIN
--	SET NOCOUNT ON;
--	IF EXISTS(SELECT ID_USUARIO FROM Usuario WHERE Username = @Username)
--	BEGIN
--		SELECT -1 -- Username exists.
--	END
--	ELSE IF EXISTS(SELECT ID_USUARIO FROM Usuario WHERE ID_PERSONA = @ID_PERSONA)
--	BEGIN
--		SELECT -2 -- Person exists.
--	END
--	ELSE
--	BEGIN
--		INSERT INTO [Usuario]
--			   ([ID_PERSONA]
--			   ,[Username]
--			   ,[Password]
--			--   ,[Email]
--			   ,[CreatedDate])
--		VALUES
--			   (@ID_PERSONA
--			   ,@Username
--			   ,@Password
--			--   ,@Email
--			   ,GETDATE())
		
--		SELECT SCOPE_IDENTITY() -- UserId			   
--     END
--END

--GO

--CREATE TABLE [dbo].[UserActivation](
--	[ID_USUARIO] [int] NOT NULL,
--	[ActivationCode] [uniqueidentifier] NOT NULL,
-- CONSTRAINT [PK_UserActivation] PRIMARY KEY CLUSTERED 
--(
--	[ID_USUARIO] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO
--CREATE  PROCEDURE [dbo].[Validate_User]
--	@Username NVARCHAR(20),
--	@Password NVARCHAR(20)
--AS
--BEGIN
--	SET NOCOUNT ON;
--	DECLARE @UserId INT, @LastLoginDate DATETIME
	
--	SELECT @UserId = ID_USUARIO, @LastLoginDate = LastLoginDate 
--	FROM Usuario WHERE Username = @Username AND [Password] = @Password
	
--	IF @UserId IS NOT NULL
--	BEGIN
--		IF NOT EXISTS(SELECT ID_USUARIO FROM UserActivation WHERE ID_USUARIO = @UserId)
--		BEGIN
--			UPDATE Usuario
--			SET LastLoginDate =  GETDATE()
--			WHERE ID_USUARIO = @UserId
--			SELECT @UserId [UserId] -- User Valid
--		END
--		ELSE
--		BEGIN
--			SELECT -2 -- User not activated.
--		END
--	END
--	ELSE
--	BEGIN
--		SELECT -1 -- User invalid.
--	END
--END
--GO

--INSERT INTO Persona
--SELECT 'admin','aaaaa','aaaaaa','16769687','21/04/1963','1','admin@ferrotumi.com','av. panamerica 475','LAMBAYEQUE','LAMBAYEQUE','ILLIMO','950047269','0', GETDATE(),NULL,NULL
--UNION ALL
--SELECT 'admin2','asadd','aaaaaasd','17653687','18/06/1968','1','user@ferrotumi.com','av. belaunde 3475','LAMBAYEQUE','CHICLAYO','CHICLAYO','926958569','0', GETDATE(),NULL,NULL
--go 

--INSERT INTO Usuario
--SELECT '1','admin', 'admin', GETDATE(), NULL
--UNION ALL
--SELECT '2','user', '12345', GETDATE(), NULL
--GO

--Tabla usuario
CREATE TABLE [dbo].[Usuario](
	ID_USUARIO integer PRIMARY KEY IDENTITY,
	CODIGO AS ('US' + RIGHT('0000' + CONVERT(VARCHAR, ID_USUARIO),(4))),
    FK_ID_ROL integer NOT NULL,
    USUARIO varchar(100) NOT NULL,
	--CONTRASENIA varbinary NOT NULL,	
	CONTRASENIA varchar(100) NOT NULL,	
    NOMBRE varchar(100) NOT NULL,
    APE_PATERNO varchar(100) NOT NULL,
	APE_MATERNO varchar(100) NOT NULL,
	DNI char(8) NOT NULL UNIQUE,
	FECHA_NAC date NOT NULL,
	GENERO char(1) check(GENERO IN('M','F')) NOT NULL,--M: Masculino	F:Femenina
	EMAIL varchar(50) NOT NULL,
    DIRECCION varchar(70) NOT NULL,
	DEPARTAMENTO varchar(50) NOT NULL,
	PROVINCIA varchar(70) NOT NULL,
	DISTRITO varchar(70) NOT NULL,
    TELEFONO varchar(20) NOT NULL,
    FOTO varbinary(max) NULL,
	ESTADO char(1) check(Estado IN('A','I')) NOT NULL,--A: Activo		I:Inactivo
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL,
	FOREIGN KEY (FK_ID_ROL) REFERENCES Rol (ID_ROL)
);
GO

INSERT INTO Usuario(NOMBRE,APE_PATERNO,APE_MATERNO,FK_ID_ROL,DNI,FECHA_NAC,GENERO,EMAIL,DIRECCION,DEPARTAMENTO,PROVINCIA,DISTRITO,TELEFONO,USUARIO,CONTRASENIA,FOTO,ESTADO,FECHA_INS) 
VALUES('Admin','.','.',1,'00000000','2012-06-18 10:34:09.000','M','support@gmail.com','.','.','.','.','.','admin','admin',null,'A',GETDATE())

--SELECT u.USUARIO,u.CONTRASENIA,r.DESCRIPCION AS ROL 
--FROM Usuario u INNER JOIN Rol r ON r.ID_ROL = u.FK_ID_ROL
--WHERE u.USUARIO = 'admin'

GO
--Tabla modulo
CREATE TABLE [dbo].[Modulo](
	ID_MODULO integer PRIMARY KEY IDENTITY,
	CODIGO AS ('MD' + RIGHT('0000' + CONVERT(VARCHAR, ID_MODULO),(4))),
    DESCRIPCION varchar(100) NOT NULL,
	ICONO varchar(100) NOT NULL,
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL
);
GO

INSERT INTO Modulo(DESCRIPCION,ICONO,FECHA_INS) VALUES('Reportes','fa fa-edit',GETDATE())
INSERT INTO Modulo(DESCRIPCION,ICONO,FECHA_INS) VALUES('Mantenimiento','fa fa-gears',GETDATE())
INSERT INTO Modulo(DESCRIPCION,ICONO,FECHA_INS) VALUES('Personas','fa fa-users',GETDATE())
INSERT INTO Modulo(DESCRIPCION,ICONO,FECHA_INS) VALUES('Transacciones','fa fa-bar-chart-o',GETDATE())
select * from Modulo

GO

--Tabla operacion
CREATE TABLE [dbo].[Sub_Modulo](
	ID_SUB_MODULO integer PRIMARY KEY IDENTITY,
	CODIGO AS ('OP' + RIGHT('0000' + CONVERT(VARCHAR, ID_SUB_MODULO),(4))),
    DESCRIPCION varchar(50) NOT NULL,
    RUTA varchar(100) NOT NULL,
	FK_ID_MODULO integer NOT NULL,
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL,
	FOREIGN KEY (FK_ID_MODULO) REFERENCES Modulo (ID_MODULO)
);
GO

INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Reporte de Ventas','~/Views/Forms/frmReporVentas.aspx',1,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Reporte de Compras','~/Views/Forms/frmReporCompras.aspx',1,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Reportes de Usuarios','~/Views/Forms/frmReporUser.aspx',1,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Reportes de Clientes','~/Views/Forms/frmReporCli.aspx',1,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Reportes de Productos','~/Views/Forms/frmReporProd.aspx',1,GETDATE())

INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('M�dulos','~/Views/Forms/frmModulo.aspx',2,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Sub M�dulos','~/Views/Forms/frmModulo.aspx',2,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Roles','~/Views/Forms/frmRol.aspx',2,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Marca','~/Views/Forms/frmMarca.aspx',2,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Categorias','~/Views/Forms/frmCategoria.aspx',2,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Productos','~/Views/Forms/frmProducto.aspx',2,GETDATE())

INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Personas','~/Views/Forms/frmPersona.aspx',3,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Usuarios','~/Views/Forms/frmUser.aspx',3,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Proveedores','~/Views/Forms/frmProveedor.aspx',3,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Clientes','~/Views/Forms/frmCliente.aspx',3,GETDATE())

INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Realizar venta','~/Views/Forms/frmVenta.aspx',4,GETDATE())
INSERT INTO Sub_Modulo(DESCRIPCION,RUTA,FK_ID_MODULO,FECHA_INS) VALUES('Realizar Ingreso','~/Views/Forms/frmIngreso.aspx',4,GETDATE())

--select sm.ID_SUB_MODULO,sm.CODIGO,sm.DESCRIPCION,sm.RUTA,m.DESCRIPCION AS MODULO,sm.ELIM_LOGICO,sm.FECHA_INS,sm.FECHA_UPD,sm.FECHA_DEL 
--from Sub_Modulo sm INNER JOIN Modulo m ON m.ID_MODULO = sm.FK_ID_MODULO
--WHERE sm.ELIM_LOGICO = 1

GO
--Tabla Rol_SubModulo
CREATE TABLE [dbo].[Rol_SubModulo](
	ID_ROL_SUBMODULO integer PRIMARY KEY IDENTITY,
	CODIGO AS ('RS' + RIGHT('0000' + CONVERT(VARCHAR, ID_ROL_SUBMODULO),(4))),
	FK_ID_ROL integer NOT NULL,
    FK_ID_SUB_MODULO integer NOT NULL,
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL,
	FOREIGN KEY (FK_ID_ROL) REFERENCES Rol (ID_ROL),
	FOREIGN KEY (FK_ID_SUB_MODULO) REFERENCES Sub_Modulo (ID_SUB_MODULO)
);
GO

INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,1,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,2,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,3,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,4,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,5,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,6,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,7,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,8,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,9,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,10,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,11,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,12,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,13,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,14,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,15,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,16,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(1,17,GETDATE())

INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,6,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,7,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,8,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,9,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,10,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,11,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,12,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,13,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,14,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(2,15,GETDATE())

INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(3,16,GETDATE())
INSERT INTO Rol_SubModulo(FK_ID_ROL,FK_ID_SUB_MODULO,FECHA_INS) VALUES(3,17,GETDATE())

--select rsm.ID_ROL_SUBMODULO,rsm.CODIGO,r.DESCRIPCION AS ROL,sm.DESCRIPCION AS [SUB MODULO],rsm.ELIM_LOGICO,rsm.FECHA_INS,rsm.FECHA_UPD,rsm.FECHA_DEL 
--from Rol_SubModulo rsm 
--INNER JOIN Rol r ON r.ID_ROL = rsm.FK_ID_ROL
--INNER JOIN Sub_Modulo sm ON sm.ID_SUB_MODULO = rsm.FK_ID_SUB_MODULO
--WHERE rsm.ELIM_LOGICO = 1

GO
--Tabla ingreso
--CREATE TABLE [dbo].[Ingreso](
--ID_INGRESO integer PRIMARY KEY IDENTITY,
--FK_ID_PROVEEDOR integer NOT NULL,
--FK_ID_USUARIO integer NOT NULL,
--TIPO_COMPROBANTE varchar(20) NOT NULL,
--SERIE_COMPROBANTE varchar(7) NULL,
--NUM_COMPROBANTE varchar (10) NOT NULL,
--IMPUESTO decimal (4,2) NOT NULL,
--TOTAL_INGRESO decimal (11,2) NOT NULL,
--ELIM_LOGICO bit default(1),
--FECHA_INS datetime NULL,
--FECHA_UPD datetime NULL,
--FECHA_DEL datetime NULL,
--FOREIGN KEY (FK_ID_PROVEEDOR) REFERENCES P (ID_PERSONA),
--FOREIGN KEY (FK_ID_USUARIO) REFERENCES Usuario (ID_USUARIO)
--);
--GO
--Tabla detalle_ingreso
--CREATE TABLE [dbo].[Detalle_Ingreso](
--	ID_DETALLE_INGRESO integer PRIMARY KEY IDENTITY,
--    FK_ID_INGRESO integer NOT NULL,
--    FK_ID_PRODUCTO integer NOT NULL,
--    CANTIDAD integer NOT NULL,
--    PRECIO decimal(11,2) NOT NULL,
--	ELIM_LOGICO bit default(1),
--	FECHA_INS datetime NULL,
--	FECHA_UPD datetime NULL,
--	FECHA_DEL datetime NULL,
--    FOREIGN KEY (FK_ID_INGRESO) REFERENCES Ingreso (ID_INGRESO) ON DELETE CASCADE,
--    FOREIGN KEY (FK_ID_PRODUCTO) REFERENCES Producto (ID_PRODUCTO)
--);
--GO

--Tabla venta
CREATE TABLE [dbo].[Venta](
	ID_VENTA integer PRIMARY KEY IDENTITY,
    FK_ID_CLIENTE integer NOT NULL,
    FK_ID_USUARIO integer NOT NULL,
    TIPO_COMPROBANTE varchar(20) NOT NULL,
    SERIE_COMPROBANTE varchar(7) NULL,
    NUM_COMPROBANTE varchar (10) NOT NULL,
    IMPUESTO decimal (4,2) NOT NULL,
    TOTAL decimal (11,2)NOT NULL,
    ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL,
    FOREIGN KEY (FK_ID_CLIENTE) REFERENCES Cliente (ID_CLIENTE),
    FOREIGN KEY (FK_ID_USUARIO) REFERENCES Usuario (ID_USUARIO)
);
GO
--Tabla detalle_venta
CREATE TABLE [dbo].[Detalle_Venta](
	ID_DETALLE_VENTA integer PRIMARY KEY IDENTITY,
    FK_ID_VENTA integer NOT NULL,
    FK_ID_PRODUCTO integer NOT NULL,
    CANTIDAD integer NOT NULL,
    PRECIO decimal(11,2) NOT NULL,
    DESCUENTO decimal(11,2) NOT NULL,
	ELIM_LOGICO bit default(1),
	FECHA_INS datetime NULL,
	FECHA_UPD datetime NULL,
	FECHA_DEL datetime NULL,
    FOREIGN KEY (FK_ID_VENTA) REFERENCES Venta (ID_VENTA) ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_PRODUCTO) REFERENCES Producto (ID_PRODUCTO)
);
GO

/*===============================PROCEDIMIENTOS ALMACENADOS==========================================*/
/*ROL==========================================*/
--MOSTRAR
--DROP PROC sp_RolMostrar
--GO
CREATE PROCEDURE [dbo].[sp_RolMostrar]
AS
    SELECT CODIGO, DESCRIPCION
	FROM Rol
	WHERE ELIM_LOGICO=1
GO

--INSERTAR
--DROP PROC sp_RolInsertar
--GO
CREATE PROCEDURE [dbo].[sp_RolInsertar]
	@DESCRIPCION varchar(30)    
AS
	INSERT INTO Rol (DESCRIPCION,FECHA_INS)
	VALUES (@DESCRIPCION,GETDATE())
GO

--EDITAR
--DROP PROC sp_RolEditar
--GO
CREATE PROCEDURE [dbo].[sp_RolEditar]
	@DESCRIPCION varchar(30),
	@ID_ROL integer
AS
	UPDATE Rol SET DESCRIPCION=@DESCRIPCION,FECHA_UPD=GETDATE()
	WHERE ID_ROL=@ID_ROL
GO

--ELIMINAR
--DROP PROC sp_RolEliminar
--GO
CREATE PROCEDURE [dbo].[sp_RolEliminar]
	@ID_ROL int
AS
	UPDATE Rol SET ELIM_LOGICO=0,FECHA_DEL=GETDATE() 
	WHERE ID_ROL=@ID_ROL
GO

/*CLIENTE==========================================*/
--MOSTRAR
--DROP PROC sp_ClienteMostrar
--GO
CREATE PROCEDURE [dbo].[sp_ClienteMostrar]
AS
    SELECT CODIGO, CONCAT(NOMBRE,' ',APE_PATERNO,' ',APE_MATERNO) AS CLIENTE,DNI,GENERO,TELEFONO,DIRECCION,EMAIL,ESTADO
	FROM Cliente
	WHERE ELIM_LOGICO=1
GO

--INSERTAR
--DROP PROC sp_ClienteInsertar
--GO
CREATE PROCEDURE [dbo].[sp_ClienteInsertar]
	@NOMBRE varchar(100),	
    @APE_PATERNO varchar(100),
	@APE_MATERNO varchar(100),
	@DNI varchar(8),
	@GENERO char(1),
	@TELEFONO varchar(20),	
    @DIRECCION varchar(70),
	@EMAIL varchar(50),
	@ESTADO char(1)
AS
	INSERT INTO Cliente (NOMBRE,APE_PATERNO,APE_MATERNO,DNI,GENERO,TELEFONO,DIRECCION,EMAIL,ESTADO,FECHA_INS)
	VALUES (@NOMBRE,@APE_PATERNO,@APE_MATERNO,@DNI,@GENERO,@TELEFONO,@DIRECCION,@EMAIL,@ESTADO,GETDATE())
GO

--EDITAR
--DROP PROC sp_ClienteEditar
--GO
CREATE PROCEDURE [dbo].[sp_ClienteEditar]
	@NOMBRE varchar(100),	
    @APE_PATERNO varchar(100),
	@APE_MATERNO varchar(100),
	@DNI varchar(8),
	@GENERO char(1),
	@TELEFONO varchar(20),	
    @DIRECCION varchar(70),
	@EMAIL varchar(50),
	@ESTADO char(1),
	@ID_CLIENTE integer
AS
	UPDATE Cliente SET NOMBRE=@NOMBRE, APE_PATERNO=@APE_PATERNO, APE_MATERNO=@APE_MATERNO, DNI=@DNI,GENERO=@GENERO,TELEFONO=@TELEFONO,DIRECCION=@DIRECCION,EMAIL=@EMAIL,ESTADO=@ESTADO,FECHA_UPD=GETDATE()
	WHERE ID_CLIENTE=@ID_CLIENTE
GO

--ELIMINAR
--DROP PROC sp_ClienteEliminar
--GO

CREATE PROCEDURE [dbo].[sp_ClienteEliminar]
	@ID_CLIENTE int
AS
	UPDATE Cliente SET ELIM_LOGICO=0,FECHA_DEL=GETDATE() 
	WHERE ID_CLIENTE=@ID_CLIENTE
GO

/*CATEGORIA==========================================*/
--MOSTRAR
--DROP PROC sp_CategoriaMostrar
--GO

CREATE PROCEDURE [dbo].[sp_CategoriaMostrar]
AS
	SELECT CODIGO, DESCRIPCION, FECHA_INS
	FROM Marca
	WHERE ELIM_LOGICO=1
GO


--INSERTAR 
--DROP PROC sp_CategoriaInsertar
--GO

CREATE PROCEDURE [dbo].[sp_CategoriaInsertar]
	@DESCRIPCION varchar(50)
AS
	INSERT INTO Marca (DESCRIPCION,FECHA_INS) 
	VALUES (@DESCRIPCION, GETDATE())
GO

--EDITAR
--DROP PROC sp_CategoriaEditar
--GO

CREATE PROCEDURE [dbo].[sp_CategoriaEditar]
	@DESCRIPCION varchar(50),
	@ID_CATEGORIA int
AS
	UPDATE Categoria SET DESCRIPCION = @DESCRIPCION, FECHA_UPD = GETDATE()
	WHERE ID_CATEGORIA=@ID_CATEGORIA
GO

--ELIMINAR
--DROP PROC sp_CategoriaElimina
--GO

CREATE PROCEDURE [dbo].[rsp_CategoriaElimina]
	@ID_CATEGORIA int
AS
	UPDATE Categoria SET ELIM_LOGICO = 0, FECHA_DEL = GETDATE()
	WHERE ID_CATEGORIA=@ID_CATEGORIA
GO

/*MARCA==========================================*/
--MOSTRAR
--DROP PROC sp_MarcaMostrar
--GO

CREATE PROCEDURE [dbo].[sp_MarcaMostrar]
AS
	SELECT CODIGO, DESCRIPCION, FECHA_INS
	FROM Marca
	WHERE ELIM_LOGICO=1
GO

--INSERTAR 
--DROP PROC sp_MarcaInsertar
--GO

CREATE PROCEDURE [dbo].[sp_MarcaInsertar]
	@DESCRIPCION varchar(50)
AS
	INSERT INTO Marca (DESCRIPCION,FECHA_INS) 
	VALUES (@DESCRIPCION, GETDATE())
GO

--EDITAR
--DROP PROC sp_MarcaEditar
--GO

CREATE PROCEDURE [dbo].[sp_MarcaEditar]
	@DESCRIPCION varchar(50),
	@ID_MARCA int
AS
	UPDATE Marca SET DESCRIPCION = @DESCRIPCION, FECHA_UPD = GETDATE()
	WHERE ID_MARCA=@ID_MARCA
GO

--ELIMINAR
--DROP PROC sp_MarcaEliminar
--GO

CREATE PROCEDURE [dbo].[sp_MarcaEliminar]
	@ID_MARCA int
AS
	UPDATE Marca SET ELIM_LOGICO = 0, FECHA_DEL = GETDATE()
	WHERE ID_MARCA=@ID_MARCA
GO

/*PRODUCTO==========================================*/
--MOSTRAR
--DROP PROC sp_ProductoMostrar
--GO

--CREATE PROCEDURE [dbo].[sp_ProductoMostrar]
--AS
--	SELECT ID_PRODUCTO AS ID, FK_ID_CATEGORIA AS CATEGOR�A, FK_ID_MARCA AS MARCA, DESCRIPCION, PRECIO_UNIT AS PRECIO, STOCK
--	FROM Producto
--GO

----INSERTAR
----DROP PROC sp_ProductoInsertar
----GO
--CREATE PROCEDURE [dbo].[sp_ProductoInsertar]
--	@FK_ID_CATEGORIA integer,
--	@FK_ID_MARCA integer,
--	@DESCRIPCION varchar(100),
--	@PRECIO_UNIT decimal(11,2),
--	@STOCK integer
--AS 
--	INSERT INTO Producto (FK_ID_CATEGORIA, FK_ID_MARCA,DESCRIPCION, PRECIO_UNIT, STOCK,FECHA_INS)
--	Values (@FK_ID_CATEGORIA,@FK_ID_MARCA,@DESCRIPCION,@PRECIO_UNIT,@STOCK,GETDATE())
--GO

----EDITAR
----DROP PROC sp_ProductoInsertar
----GO
--CREATE PROCEDURE [dbo].[sp_ProductoEditar]
--	@FK_ID_CATEGORIA integer,
--	@FK_ID_MARCA integer,
--	@DESCRIPCION varchar(100),
--	@PRECIO_UNIT decimal(11,2),
--	@STOCK integer,
--	@ID_PRODUCTO integer
--AS
--	UPDATE Producto SET FK_ID_CATEGORIA=@FK_ID_CATEGORIA,FK_ID_MARCA=@FK_ID_MARCA, DESCRIPCION=@DESCRIPCION, PRECIO_UNIT =@PRECIO_UNIT, STOCK=@STOCK,FECHA_UPD=GETDATE()
--	WHERE ID_PRODUCTO=@ID_PRODUCTO
--GO

----ELIMINAR
----DROP PROC sp_ProductoInsertar
----GO
--CREATE PROCEDURE [dbo].[sp_ProductoEliminar]
--	@ID_PRODUCTO int
--As
--	UPDATE Producto SET ELIM_LOGICO=0,FECHA_DEL=GETDATE()
--	WHERE ID_PRODUCTO=@ID_PRODUCTO
--GO

--/*USUARIO==========================================*/
----VALIDAR
--DROP PROC sp_UsuarioValidar 
--GO
CREATE PROCEDURE [dbo].[sp_UsuarioValidar]
	@USUARIO varchar(50),
	@CONTRASENIA varchar(100)
AS
	SELECT ID_USUARIO, USUARIO, CONTRASENIA
	FROM Usuario
	WHERE USUARIO=@USUARIO AND CONTRASENIA=@CONTRASENIA
GO

--MOSTRAR
--DROP PROC sp_UsuarioMostrar 
--GO
CREATE PROCEDURE [dbo].[sp_UsuarioMostrar]
	@USUARIO varchar(50),
	@CONTRASENIA varchar(100)
AS
	SELECT u.ID_USUARIO,u.CODIGO, r.DESCRIPCION AS ROL, USUARIO, CONTRASENIA,NOMBRE,APE_PATERNO,APE_MATERNO,DNI,FECHA_NAC,GENERO,EMAIL,DIRECCION,DEPARTAMENTO,PROVINCIA,DISTRITO,TELEFONO,FOTO,u.ESTADO,u.FECHA_INS,u.FECHA_UPD,u.FECHA_DEL
	FROM Usuario u INNER JOIN Rol r ON r.ID_ROL = u.FK_ID_ROL
	WHERE USUARIO=@USUARIO AND CONTRASENIA=@CONTRASENIA
GO

--CREATE PROCEDURE [dbo].[sp_UsuarioMostrar]
--AS
--	SELECT CODIGO, DESCRIPCION, USUARIO, CONTRASENIA,NOMBRE,APE_PATERNO,APE_MATERNO,DNI,FECHA_NAC,GENERO,EMAIL,DIRECCION,DEPARTAMENTO,PROVINCIA,DISTRITO,TELEFONO,FOTO,u.ESTADO,u.FECHA_INS,u.FECHA_UPD,u.FECHA_DEL
--	FROM Usuario
--	WHERE ELIM_LOGICO=1
--GO

--INSERTAR
--DROP PROC sp_UsuarioInsertar 
--GO
CREATE PROCEDURE [dbo].[sp_UsuarioInsertar]
	@FK_ID_ROL integer,
    @USUARIO varchar(50),	
	@CONTRASENIA varchar(100),	
    @NOMBRE varchar(100),
    @APE_PATERNO varchar(100),
	@APE_MATERNO varchar(100),
	@DNI char(8),
	@FECHA_NAC date,
	@GENERO char(1),
	@EMAIL varchar(50),
    @DIRECCION varchar(70),
	@DEPARTAMENTO varchar(50),
	@PROVINCIA varchar(70),
	@DISTRITO varchar(70),
    @TELEFONO varchar(20),
    @FOTO varbinary(max),
	@ESTADO char(1)
AS
	INSERT INTO Usuario (FK_ID_ROL,USUARIO,CONTRASENIA,NOMBRE,APE_PATERNO,APE_MATERNO,DNI,FECHA_NAC,GENERO,EMAIL,DIRECCION,DEPARTAMENTO,PROVINCIA,DISTRITO,TELEFONO,FOTO,ESTADO,FECHA_INS)
	VALUES (@FK_ID_ROL,@USUARIO,@CONTRASENIA,@NOMBRE,@APE_PATERNO,@APE_MATERNO,@DNI,@FECHA_NAC,@GENERO,@EMAIL,@DIRECCION,@DEPARTAMENTO,@PROVINCIA,@DISTRITO,@TELEFONO,@FOTO,@ESTADO,GETDATE())
GO

--EDITAR
--DROP PROC sp_UsuarioEditar 
--GO
CREATE PROCEDURE [dbo].[sp_UsuarioEditar]
	@FK_ID_ROL integer,
    @USUARIO varchar(50),	
	@CONTRASENIA varchar(100),	
    @NOMBRE varchar(100),
    @APE_PATERNO varchar(100),
	@APE_MATERNO varchar(100),
	@DNI char(8),
	@FECHA_NAC date,
	@GENERO char(1),
	@EMAIL varchar(50),
    @DIRECCION varchar(70),
	@DEPARTAMENTO varchar(50),
	@PROVINCIA varchar(70),
	@DISTRITO varchar(70),
    @TELEFONO varchar(20),
    @FOTO varbinary(max),
	@ESTADO char(1),
	@ID_USUARIO int
AS
	UPDATE Usuario SET FK_ID_ROL=@FK_ID_ROL,USUARIO=@USUARIO,CONTRASENIA=@CONTRASENIA,NOMBRE=@NOMBRE,APE_PATERNO=@APE_PATERNO,
	APE_MATERNO=@APE_MATERNO,DNI=@DNI,FECHA_NAC=@FECHA_NAC,GENERO=@GENERO,EMAIL=@EMAIL,DIRECCION=@DIRECCION,DEPARTAMENTO=@DEPARTAMENTO,
	PROVINCIA=@PROVINCIA,DISTRITO=@DISTRITO,TELEFONO=@TELEFONO,FOTO=@FOTO,ESTADO=@ESTADO,FECHA_UPD=GETDATE()
	WHERE ID_USUARIO=@ID_USUARIO
GO

--ELIMINAR
--DROP PROC sp_UsuarioEliminar 
--GO
CREATE PROCEDURE [dbo].[sp_UsuarioEliminar]
	@ID_USUARIO int
AS
	UPDATE Usuario SET ELIM_LOGICO=0, FECHA_DEL=GETDATE()
	WHERE ID_USUARIO=@ID_USUARIO
GO
/*********************************sp proveedor***********************************/
INSERT INTO Proveedor(DATOS,RUC,REPRESENTANTE,TELEFONO,DIRECCION,EMAIL,ESTADO,FECHA_INS) 
VALUES('ROHAN','20601175119','JUNIOR','98877889','AV LOS INCAS 613','junior@gmial.com','A',GETDATE())
go
CREATE PROCEDURE ProveedorMostrar
AS
    SELECT CODIGO,DATOS,RUC,REPRESENTANTE,TELEFONO,DIRECCION,EMAIL,ESTADO
	FROM Proveedor
	WHERE ELIM_LOGICO=1
GO

--INSERTAR 
CREATE PROCEDURE ProveedorInsertar
	@DATOS varchar(100),
	@RUC varchar(11),
	@REPRESENTANTE varchar(100) ,
	@TELEFONO varchar(20) ,	
    @DIRECCION varchar(70),
	@EMAIL varchar(50)      
 --E: Activo		H:Inactivo
 AS
	INSERT INTO proveedor (DATOS,RUC,REPRESENTANTE,TELEFONO,DIRECCION,EMAIL,ESTADO,FECHA_INS)
	VALUES (@DATOS,@RUC,@REPRESENTANTE,@TELEFONO,@DIRECCION,@EMAIL,'A',GETDATE())
	
GO

--EDITAR
CREATE PROCEDURE ProveedorEditar
	@DATOS varchar(100),
	@RUC varchar(11),
	@REPRESENTANTE varchar(100) ,
	@TELEFONO varchar(20) ,	
    @DIRECCION varchar(70),
	@EMAIL varchar(50),      
	@ESTADO char(1),
	@ID_PROVEEDOR integer
AS
	UPDATE Proveedor SET DATOS=@DATOS,RUC=@RUC,REPRESENTANTE=@REPRESENTANTE,TELEFONO=@TELEFONO,DIRECCION=@DIRECCION,EMAIL=@EMAIL,ESTADO=@ESTADO,FECHA_UPD=GETDATE()
	WHERE ID_PROVEEDOR=@ID_PROVEEDOR
GO
--ELIMINAR
CREATE PROCEDURE ProveedorEliminar
	@ID_PROVEEDOR int
AS
	UPDATE Proveedor SET ELIM_LOGICO=0,FECHA_DEL=GETDATE() 
	WHERE ID_PROVEEDOR=@ID_PROVEEDOR
GO

/*********************************fin sp proveedor***********************************/
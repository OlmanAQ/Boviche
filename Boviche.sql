
Go
USE  P1G8;
GO

--*************************tabla de empresa****************************
go
IF OBJECT_ID('empresa', 'U') IS NOT NULL  
   DROP TABLE empresa;  
go
CREATE TABLE empresa 
(
	idEmpresa	TINYINT			NOT NULL,
	nombre		VARCHAR(20)		NOT NULL,
	ubicacion	VARCHAR	(40)	NOT NULL,

	constraint PK_empresa_idEmpresa 
		PRIMARY KEY (idEmpresa)
);
go
select * from RAZA;


--*************************tabla de usuario****************************
IF OBJECT_ID('usuario', 'U') IS NOT NULL  
   DROP TABLE usuario;  
go
CREATE TABLE usuario 
(
	nombreUsuario		VARCHAR(10)		NOT NULL,
	idEmpresa			TINYINT			NOT NULL,
	contraseña			VARCHAR(8)		NOT NULL

	constraint PK_usuario_nombreUsuario 
		PRIMARY KEY (nombreUsuario)

	constraint FK_usuario_idEmpresa
		foreign key (idEmpresa) references empresa
);
go

select * from usuario;

--*************************tabla de producción****************************
IF OBJECT_ID('produccion', 'U') IS NOT NULL  
   DROP TABLE produccion;  
go
CREATE TABLE produccion 
(
	fecha			DATE		NOT NULL,
	total			INT			NOT NULL,
	idBovino		INT			NOT NULL

	constraint PK_produccion_fecha 
		PRIMARY KEY (fecha)

	constraint FK_produccion_idBovino
		foreign key (idBovino) references Bovino
);
go

select * from usuario;

--*************************tabla de pesas****************************
IF OBJECT_ID('pesas', 'U') IS NOT NULL  
   DROP TABLE pesas;  
go
CREATE TABLE pesas 
(
	horario			TINYINT		NOT NULL,
	fecha			DATE		NOT NULL,
	kilos_Kl		int			NOT NULL	

	constraint PK_pesas_horario 
		PRIMARY KEY (horario)
		
	constraint FK_pesas_fecha
		foreign key (fecha) references produccion
);
go
select * from pesas;


--*************************tabla de horario****************************
IF OBJECT_ID('horario', 'U') IS NOT NULL  
   DROP TABLE horario;  
go
CREATE TABLE horario 
(
	horario				TINYINT	NOT NULL IDENTITY(1,1),
	especificacion		CHAR(1)	NOT NULL default ('M')

	constraint FK_horario_horario
		foreign key (horario) references pesas,
		
	constraint CHK_especificacion_horario
		check	(especificacion in ('M','T', 'N'))
);
go	
select * from horario;

ALTER TABLE horario Add DEFAULT ('M') for especificacion;


--************************Inserciones sobre Horario*********************
SET IDENTITY_INSERT horario ON;
insert into horario (horario, especificacion)
	values 
		(8,'M'),
		(1,'T'),
		(2,'N')

SET IDENTITY_INSERT horario OFF;
--values ('Mañana',0),('Tarde',1),('Noche',2);

--************************Inserciones sobre usuario*********************
insert into usuario (nombreUsuario, idEmpresa,contraseña)
	values ('Ratatopo', 112, 'ratarata'),
		   ('Tynox08', 112, 'tyty08'),
		   ('Alien', 112, 'Alienol'),
		   ('admin', 112, '1234');

	select * from Producto;

--************************Inserciones sobre pesas*********************

insert into pesas (horario, fecha,kilos_Kl)
	values (1, '15-02-2022', 150);

--************************Inserciones sobre produccion*********************

insert into produccion(fecha, total,idBovino)
	values (1, '15-02-2022', 150);


--create tabla Raza--

IF OBJECT_ID('Raza', 'U') IS NOT NULL  
   DROP TABLE Raza;  
go
CREATE TABLE Raza 
(	
	Raza			TINYINT		NOT NULL primary key, 
	NombreRaza		VARCHAR(20)	NOT NULL,
);
go

--create tabla Color--

IF OBJECT_ID('Color', 'U') IS NOT NULL  
   DROP TABLE Color;  
go
CREATE TABLE Color 
(
	Color			TINYINT		NOT NULL primary key, 
	NombreColor		CHAR(15)	NOT NULL,
);
go


--create tabla Bovino--

IF OBJECT_ID('Bovino', 'U') IS NOT NULL  
   DROP TABLE Bovino;  
go
CREATE TABLE Bovino 
(
	id_Bovino			INT			NOT NULL, 
	Edad				INT			NULL,
	idSexo				TINYINT 	NULL,
	FechaSalida			DATE		NULL,
	FechaIngreso		DATE		NULL,
	FechaNacimiento		DATE		NULL,
	Nombre				VARCHAR(20)	NULL,
	Raza				TINYINT		NULL,
	Color				TINYINT		NULL,
	idEmpresa			TINYINT		NOT NULL,

	CONSTRAINT PK_Bovino_ID 
		PRIMARY KEY(id_Bovino),
	CONSTRAINT FK_Bovino_Raza
		FOREIGN KEY (Raza) REFERENCES Raza,
	CONSTRAINT FK_Bovino_Color
		FOREIGN KEY (Color) REFERENCES Color, 
	
	
);

--create tabla Vacunacion --

IF OBJECT_ID('Vacunacion', 'U') IS NOT NULL  
   DROP TABLE Vacunacion;  
go
CREATE TABLE Vacunacion 
(
	idVacunacion		TINYINT		NOT NULL primary key, 
	idTipo				TINYINT		NOT NULL,
);
go


go
--create tabla Vacunacion_Bovino --

IF OBJECT_ID('Vacunacion_Bovino', 'U') IS NOT NULL  
   DROP TABLE Vacunacion_Bovino;  
go
CREATE TABLE Vacunacion_Bovino 
(
	idBovino		INT		NOT NULL,
	idVacunacion 	TINYINT	NOT NULL,

	CONSTRAINT FK_Vacunacion_Bovino_idBovino
		FOREIGN KEY (idBovino) REFERENCES Bovino,
	CONSTRAINT FK_Vacunacion_Bovino_idVacunacion
		FOREIGN KEY (idVacunacion) REFERENCES Vacunacion, 
);
go

--create tabla Tipo --

IF OBJECT_ID('Tipo', 'U') IS NOT NULL  
   DROP TABLE Tipo;  
go
CREATE TABLE Tipo 
(
	idTipo			TINYINT		NOT NULL primary key, 
	TipoVacunacion	char(1)		NOT NULL,

	CONSTRAINT FK_Tipo_idTipo
		FOREIGN KEY (idTipo) REFERENCES Vacunacion,
);
go





--create tabla Producto --

IF OBJECT_ID('Producto', 'U') IS NOT NULL  
   DROP TABLE Producto;  
go
CREATE TABLE Producto 
(
	Nombre		VARCHAR(20)		NOT NULL primary key, 
	Detalle		VARCHAR(40)		NULL,
);
go

--create tabla Producto_Vacunacion --

IF OBJECT_ID('Producto_Vacunacion', 'U') IS NOT NULL  
   DROP TABLE Producto_Vacunacion;  
go
CREATE TABLE Producto_Vacunacion 
(
	idVacunacion	TINYINT		NOT NULL primary key, 
	Nombre			VARCHAR(20)	NOT NULL,

	CONSTRAINT FK_Producto_Vacunacion_idVacunacion
		FOREIGN KEY (idVacunacion) REFERENCES Vacunacion,
	CONSTRAINT FK_Producto_Vacunacion_Nombre
		FOREIGN KEY (Nombre) REFERENCES Producto,
);
go

--create tabla Nombre_Sintomas --

IF OBJECT_ID('Nombre_Sintomas', 'U') IS NOT NULL  
   DROP TABLE Nombre_Sintomas;  
go
CREATE TABLE Nombre_Sintomas 
(
	Nombre_Sintoma		TINYINT		NOT NULL primary key, 
	Especializacion		CHAR(2)		NOT NULL,

	
	
);
go

--create tabla Sintomas --

IF OBJECT_ID('Sintomas', 'U') IS NOT NULL  
   DROP TABLE Sintomas;  
go
CREATE TABLE Sintomas 
(
	Fecha				DATE		NOT NULL primary key, 
	Nombre_Sintoma		TINYINT  	NOT NULL,

	CONSTRAINT FK_Sintomas_Nombre_Sintoma
		FOREIGN KEY (Nombre_Sintoma) REFERENCES Nombre_Sintomas,
	CONSTRAINT FK_Sintomas_Nombre_Fecha
		FOREIGN KEY (Fecha) REFERENCES Enfermedades,
	
);
go

--create tabla Enfermedades --

IF OBJECT_ID('Enfermedades', 'U') IS NOT NULL  
   DROP TABLE Enfermedades;  
go
CREATE TABLE Enfermedades 
(
	Fecha			DATE		NOT NULL primary key,
	Diagnostico		VARCHAR(30)	NULL,
	Comentario		VARCHAR(40) NULL,

	
);
go

--create tabla Enfermedades_Bovinos -- 

IF OBJECT_ID('Enfermedades_Bovinos', 'U') IS NOT NULL  
   DROP TABLE Enfermedades_Bovinos;  
go
CREATE TABLE Enfermedades_Bovinos 
(
	idBovino	INT		NOT NULL , 
	Fecha		DATE	NOT NULL,

	CONSTRAINT FK_Enfermedades_Bovino_idBovino
		FOREIGN KEY (idBovino) REFERENCES Bovino,
	CONSTRAINT FK_Enfermedades_Bovino_Fecha
		FOREIGN KEY (Fecha) REFERENCES Enfermedades,
);
go

--create tabla Enfermedades_Producto --

IF OBJECT_ID('Enfermedades_Producto', 'U') IS NOT NULL  
   DROP TABLE Enfermedades_Producto;  
go
CREATE TABLE Enfermedades_Producto 
(
	Fecha		DATE			NOT NULL primary key, 
	Nombre		VARCHAR(20)		NOT NULL,

	CONSTRAINT FK_Enfermedades_Producrto_Fecha
		FOREIGN KEY (Fecha) REFERENCES Enfermedades,
	CONSTRAINT  FK_Enfermedades_Producrto_Nombre
		FOREIGN KEY (Nombre) REFERENCES Producto,
);
go


--------------------------------------------------------------------------------------------------------------------------------------------------

 --Insertando en Enfermedades 
select * from Enfermedades -- comando para ver todos los valores que tiene la tabla Enfermedades

set dateformat DMY-- Se establece el formato de la fecha
--Se insertan todas las enfermedades en la tabla
INSERT INTO Enfermedades values ('08-09-2000','Gripe Bovina','Sin comentarios')
INSERT INTO Enfermedades values ('08-07-2000','Parasitos','Se encontraron parasitos')
INSERT INTO Enfermedades values ('15-05-2010','Gripe Bovina','Sin comentarios')
INSERT INTO Enfermedades values ('28-02-2000','Parasitos','Intestinales')
INSERT INTO Enfermedades values ('06-06-2021','Infeccion','En el ubre')
INSERT INTO Enfermedades values ('20-12-2011','Parasitos','Externos')
INSERT INTO Enfermedades values ('05-03-2021','Infeccion','En el ubre')

--Se eliminan datos de la tabla enfermedades
DELETE FROM Enfermedades WHERE Fecha = '2000-08-09'
DELETE FROM Enfermedades WHERE Fecha = '2000-08-07'


--Se actualizan datos de la tabla enfermedades

Update Enfermedades
	set Comentario = 'Tinene mocosidad'
	where Fecha = '2000-05-15'

UPDATE Enfermedades
	set Comentario = 'Presenta Fiebre'
	Where Fecha = '2000-02-08'

-- Mostrar los comentarios donde el diagnostico sea Gripe Bovina
select Comentario from Enfermedades where Diagnostico = 'Gripe Bovina'
--------------------------------------------------------------------------------------------------------------------------------------------------


--insert en Productos 
select  * from Producto -- comando para ver todos los valores que tiene la tabla Producto

--Se insertan todas los Productos en la tabla
INSERT INTO Producto values ('Dectomax','Para parasitos ext e int')
INSERT INTO Producto values ('Ivermetina','Para parasitos ext e int')
INSERT INTO Producto values ('Ivomec','Para parasitos externos')
INSERT INTO Producto values ('Napzin','Para gripes')
INSERT INTO Producto values ('Piroflox','Para gripes')
INSERT INTO Producto values ('Napz1n','Para gipe')
INSERT INTO Producto values ('Pirofl0x','usado para gripes ')

--Se eliminan datos de la tabla Producto
DELETE FROM Producto WHERE Nombre = 'Napz1n'
DELETE FROM Producto WHERE Nombre = 'Pirofl0x'

--Se actualizan datos de la tabla Producto
Update Producto
	set Detalle = 'Para parasitos ext'
	where Nombre = 'Ivomec'



--Mostrar Los productos para la gripe
select Nombre as [Nombre del Producto] from Producto where Detalle = 'Para gripes'
--------------------------------------------------------------------------------------------------------------------------------------------------

select * from Vacunacion -- comando para ver todos los valores que tiene la tabla Vacunacion


--Se insertan todas las vacunas en la tabla
INSERT INTO Vacunacion Values (29,0)
INSERT INTO Vacunacion Values (17,1)
INSERT INTO Vacunacion Values (67,2)
INSERT INTO Vacunacion Values (37,3)
INSERT INTO Vacunacion Values (30,4)
INSERT INTO Vacunacion Values (10,3)
INSERT INTO Vacunacion Values (8,2)


--eliminar datos de Vacucion
DELETE FROM Vacunacion WHERE  idVacunacion =8
DELETE FROM Vacunacion WHERE idVacunacion = 10


--modificar datos de Vacunacion
Update Vacunacion
	set idTipo = 3
	where idVacunacion = 29

--mostrar el todos los registros que tenga el idTipo = 3
select * from Vacunacion where idTipo = 3
--------------------------------------------------------------------------------------------------------------------------------------------------

select * from Tipo-- comando para ver todos los valores que tiene la tabla tipo


--se realizan las insercciones de los tipos a las vacunas
INSERT INTO Tipo Values (29,'D')
INSERT INTO Tipo Values (17,'E')
INSERT INTO Tipo Values (67,'A')
INSERT INTO Tipo Values (37,'D')
INSERT INTO Tipo Values (30,'E')


--Eliminar datos de la tabla Tipo

DELETE FROM Tipo WHERE  idTipo =37

--Mpdificar datos de la Tipo 

Update Tipo
	set TipoVacunacion = 'D'
	where idTipo = 67

Update Tipo
	set TipoVacunacion = 'D'
	where idTipo = 17

--Mostrar todas los IdTipo que su TipoVacunacion sea D
Select idTipo from Tipo where TipoVacunacion = 'D'
--------------------------------------------------------------------------------------------------------------------------------------------------


select * from Sintomas -- comando para ver todos los valores que tiene la tabla

--Insertar en la tabla sintomas
INSERT INTO Sintomas VALUES ('15-05-2010',1)
INSERT INTO Sintomas VALUES ('28-02-2000',2)
INSERT INTO Sintomas VALUES ('06-06-2021',1)
INSERT INTO Sintomas VALUES ('08-09-2000',3)
INSERT INTO Sintomas VALUES ('08-07-2000',3)

--Borrar en la tabla de Sintomas
DELETE FROM Sintomas WHERE  Nombre_Sintoma = 2

--modificar en la tabla Sintomas

Update Sintomas
	set Nombre_Sintoma = 2
	where Fecha = '08-07-2000 '

--Mostrar todo los registros del 2010 en adelante
select * from Sintomas WHERE Fecha > '01-01-2010'
--------------------------------------------------------------------------------------------------------------------------------------------------

SelECT * FROM Nombre_Sintomas-- comando para ver todos los valores que tiene la tabla

--insertar los datos dentro de Nombre_Sintomas

insert into Nombre_Sintomas values (1,'N')
insert into Nombre_Sintomas values (2,'I')
insert into Nombre_Sintomas values (3,'F')
insert into Nombre_Sintomas values (4,'F')
insert into Nombre_Sintomas values (5,'N')

--borrado de datos en Nombre Sintomas
DELETE FROM Nombre_Sintomas WHERE Nombre_Sintoma  = 4

--Modificacion de datos en Nombre Sintomas
Update Nombre_Sintomas
	set Especializacion = 'I'
	where Nombre_Sintoma = 5


--Mostrar todos los registros que no sean ni 'N' ni 'F'

select * from Nombre_Sintomas where Especializacion != 'N'and Especializacion != 'F'
--------------------------------------------------------------------------------------------------------------------------------------------------

Select * FROM Producto_Vacunacion -- comando para ver todos los valores que tiene la tabla

--insertar datos en la tabla Producto_Vacunancion 
INSERT INTO Producto_Vacunacion VALUES (17,'Napzin')
INSERT INTO Producto_Vacunacion VALUES (29,'Napzin')
INSERT INTO Producto_Vacunacion VALUES (67,'Ivermetina')
INSERT INTO Producto_Vacunacion VALUES (37,'Napzin')
INSERT INTO Producto_Vacunacion VALUES (30,'Piroflox')


--eliminar datos en la tabla Producto_Vacunancion 
DELETE FROM Producto_Vacunacion WHERE Nombre = 'Ivomec'

--Modificar datos en la tabla Producto_Vacunancion 
Update Producto_Vacunacion
	set Nombre = 'Ivomec'
	where idVacunacion = 29


--Mostrar el idVacunancion donde se utliizo Napzin
select idVacunacion from Producto_Vacunacion where Nombre = 'Napzin' 
--------------------------------------------------------------------------------------------------------------------------------------------------

select * from Enfermedades_Producto-- comando para ver todos los valores que tiene la tabla


--Insertar los datos de la conexion entre Enfermedades y Producto
Insert INTO Enfermedades_Producto VALUES ('08-09-2000','Dectomax')
Insert INTO Enfermedades_Producto VALUES ('15-05-2010','Napzin')
Insert INTO Enfermedades_Producto VALUES ('28-02-2000','Dectomax')
Insert INTO Enfermedades_Producto VALUES ('06-06-2021','Piroflox')
Insert INTO Enfermedades_Producto VALUES ('08-07-2000','Dectomax')


--Eliminar datos de Enfermedades y Producto
DELETE FROM Enfermedades_Producto WHERE Nombre = 'Piroflox'

--Modificar datos de Enfermedades y Producto
Update Enfermedades_Producto
	set Nombre = 'Ivomec'
	where Fecha = '2000-09-08'

--Mostrar el no,bre de los productos iguales al año  2000
select Nombre from Enfermedades_Producto where Fecha > '01-01-2000' and Fecha < '31-12-2000'
--------------------------------------------------------------------------------------------------------------------------------------------------

select * from Raza -- comando para ver todos los valores que tiene la tabla

INSERT INTO Raza values (0,'Holstein')
INSERT INTO Raza values (1,'Angus')
INSERT INTO Raza values (2,'Hereford')
INSERT INTO Raza values (3,'Brangus')
INSERT INTO Raza values (4,'Jersey')
INSERT INTO Raza values (5,'Galloway')
INSERT INTO Raza values (6,'Braman')

--Eliminar datos de Enfermedades y Producto
DELETE FROM Raza WHERE NombreRaza = 'Braman'

--Modificar datos de Enfermedades y Producto

Update Raza
	set NombreRaza = 'Brahman'
	where  Raza= 5

--Mostrar Solo la las razas Jersey y Angus
Select * from Raza where NombreRaza = 'Angus' or Raza = 4
--------------------------------------------------------------------------------------------------------------------------------------------------

select * from Color-- comando para ver todos los valores que tiene la tabla

--se insertan los colores de los animales 
INSERT INTO Color VALUES (0,'Negro')
INSERT INTO Color VALUES (1,'Blanco')
INSERT INTO Color VALUES (2,'Cafe claro')
INSERT INTO Color VALUES (3,'Cafe Oscuro')
INSERT INTO Color VALUES (4,'Beteado')
INSERT INTO Color VALUES (5,'Amarillo')
INSERT INTO Color VALUES (6,'Gris')
INSERT INTO Color VALUES (7,'Rojo')
INSERT INTO Color VALUES (8,'Gris')


--Eliminar datos de los Colores
DELETE FROM Color  WHERE NombreColor = 'Rojo' and Color = 7

--Modificar datos de Enfermedades y Producto
Update Color 
	set NombreColor = 'Gris Claro'
	where  Color= 6

Update Color
	set NombreColor = 'Gris Oscuro'
	where  Color= 8

--Mostrar Solo los primeros 5 colores
select * from Color where Color >= 0 and Color < 5
--------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM sexo  --comando para ver todos los valores que tiene la tabla

--Insertar los datos de sexo
INSERT INTO sexo VALUES (0,'H')
INSERT INTO sexo VALUES (1,'M')
INSERT INTO sexo VALUES (2,'I')

--Eliminar datos de Enfermedades y Producto
DELETE FROM sexo WHERE sexo_animal = 'I'

--Mostrar todos los sexos existentes
select sexo_animal FROM sexo 
--------------------------------------------------------------------------------------------------------------------------------------------------
select * from empresa --comando para ver todos los valores que tiene la tabla

-- Insertar los datos  empresas 
INSERT INTO empresa VALUES (112,'Boviche','Santa Clara')
INSERT INTO empresa VALUES (1,'Boviche','Santa Clara')
--Eliminar datos de Enfermedades y Producto
DELETE FROM empresa WHERE idEmpresa = 1

--Modificar datos de Enfermedades y Producto
Update empresa
	set ubicacion = 'Cope de Aguas Zarcas'
	where  idEmpresa= 112

--Mostrar el nombre y la ubicaion de la empresa 
select nombre,ubicacion from empresa

--------------------------------------------------------------------------------------------------------------------------------------------------
select * from Bovino -- comando para ver todos los valores que tiene la tabla

set dateformat DMY -- comando para establecer el formato de la fecha

--insertar los Bocinos a la base de datos
INSERT INTO Bovino VALUES (3,30,0,NULL,'05-03-1990','05-03-1990','Vaca1',1,0,112)
INSERT INTO Bovino VALUES (4,20,1,NULL,'12-03-1990','05-03-1990','Toro1',3,2,112)
INSERT INTO Bovino VALUES (5,22,0,NULL,'04-05-2020','05-03-1990','Vaca2',1,2,112)
INSERT INTO Bovino VALUES (6,27,1,NULL,'16-07-2010','05-03-1990','Vaca3',2,1,112)
INSERT INTO Bovino VALUES (7,18,0,NULL,'22-07-2000','05-03-1990','Vaca4',0,3,112)
INSERT INTO Bovino VALUES (8,31,1,NULL,'23-05-2000','05-03-1990','Toro2',2,5,112)
INSERT INTO Bovino VALUES (9,11,1,NULL,'02-01-1998','02-04-2000','Toro4',4,5,112)
INSERT INTO Bovino VALUES (10,23,1,'07-06-2022','22-05-2003','03-06-1997','Toro3',1,3,112)

--Eliminar Bovino
DELETE FROM Bovino WHERE  id_Bovino = 10

--Modificar un Bovino

Update Bovino
	set Nombre = 'Toro3', Edad = 24
	where id_Bovino = 9

Update Bovino
	set FechaNacimiento = '07-02-2012' 
	where id_Bovino = 5


--Mostrar el id,nombre, edad y su fecha de ingresa de los bovinos que su sexo sea = 1 y el color sea 5
select id_Bovino,Edad,FechaIngreso,Nombre from Bovino where idSexo = 1 and Color = 5
--------------------------------------------------------------------------------------------------------------------------------------------------

--Vacunacion_Bovinos

select * from Vacunacion_Bovino -- comando para ver todos los valores que tiene la tabla

--Insertar los datos de la conexion entre Vacunacion y Bovinos
INSERT INTO Vacunacion_Bovino VALUES (1,29)
INSERT INTO Vacunacion_Bovino VALUES (1,17)
INSERT INTO Vacunacion_Bovino VALUES (2,67)
INSERT INTO Vacunacion_Bovino VALUES (3,37)
INSERT INTO Vacunacion_Bovino VALUES (3,30)
INSERT INTO Vacunacion_Bovino VALUES (4,30)

--Eliminar alguna conexion entre Vacunacion y Bovinos
DELETE FROM Vacunacion_Bovino WHERE idBovino = 3 and idVacunacion = 37

--Modificar alguna conexion entre Vacunacion y Bovinos

Update Vacunacion_Bovino
	set idVacunacion = 37 
	where idBovino = 1 and idVacunacion = 17 

--Mostrar los bovinos que tengan el idVacunacion menos o igual  de 30
select * from Vacunacion_Bovino where idVacunacion <= 30
--------------------------------------------------------------------------------------------------------------------------------------------------

--Enfermedades_Bovinos

select * from Enfermedades_Bovinos -- comando para ver todos los valores que tiene la tabla

--Insertar los datos de la conexion entre Enfermedades y Bovinos
INSERT INTO Enfermedades_Bovinos VALUES (3,'08-09-2000')
INSERT INTO Enfermedades_Bovinos VALUES (2,'08-09-2000')
INSERT INTO Enfermedades_Bovinos VALUES (4,'08-09-2000')
INSERT INTO Enfermedades_Bovinos VALUES (8,'08-09-2000')
INSERT INTO Enfermedades_Bovinos VALUES (1,'06-06-2021')
INSERT INTO Enfermedades_Bovinos VALUES (3,'06-06-2021')


--Eliminar alguna conexion entre Enfermedades y Bovinos
DELETE FROM Enfermedades_Bovinos WHERE idBovino = 3 and Fecha = '06-06-2021'

--Modificar alguna conexion entre Enfermedades y Bovinos
Update Enfermedades_Bovinos
	set Fecha = '06-06-2021'
	where idBovino = 2

--Mostrar todas idBovino del 2000 al 2010
select * from Enfermedades_Bovinos where Fecha > '01-01-2000' and Fecha < '31-12-2010'



--Vistas 

--Selecciona toda la infromacion de las Enfermedades Bovinos que ha tenido cada bovino
go
Create view EnfermedadesBovinos as
	Select Bovi.id_Bovino,Bovi.Nombre, Enf.Fecha,Enf.Diagnostico,Enf.Comentario,Enf.Nombre_Sintoma from
	(select b.id_Bovino,b.Nombre,b.idSexo,b.Color,b.Edad,b.Raza,b.FechaNacimiento,c.NombreColor,r.NombreRaza,eb.Fecha from Bovino as b 
	inner join Color as c on (b.Color = c.Color)inner join Raza as r on (b.Raza = r.Raza) inner join 
	Enfermedades_Bovinos as eb on (b.id_Bovino = eb.idBovino)) as Bovi inner join 

	(Select e.Comentario,e.Diagnostico,e.Fecha,s.Nombre_Sintoma from Enfermedades as e inner join Sintomas as s on (e.Fecha = s.Fecha) inner join
	Nombre_Sintomas as ns on (ns.Nombre_Sintoma = s.Nombre_Sintoma)) as Enf on (Bovi.Fecha = Enf.Fecha) 

go


--Crear una vista donde se vea solo las vacas y que tuvieron una enfermedad con su debido  diagnosticos
go
Create view HembrasDiagnosticos as
Select Bovi.id_Bovino,Bovi.Nombre,Bovi.idSexo, Enf.Fecha,Enf.Diagnostico from
	(select b.id_Bovino,b.Nombre,b.idSexo,b.Color,b.Edad,b.Raza,b.FechaNacimiento,c.NombreColor,r.NombreRaza,eb.Fecha from Bovino as b 
	inner join Color as c on (b.Color = c.Color)inner join Raza as r on (b.Raza = r.Raza) inner join 
	Enfermedades_Bovinos as eb on (b.id_Bovino = eb.idBovino)) as Bovi inner join 

	(Select e.Comentario,e.Diagnostico,e.Fecha,s.Nombre_Sintoma from Enfermedades as e inner join Sintomas as s on (e.Fecha = s.Fecha) inner join
	Nombre_Sintomas as ns on (ns.Nombre_Sintoma = s.Nombre_Sintoma)) as Enf on (Bovi.Fecha = Enf.Fecha ) where idSexo = 0

go


--Comando que se utiliza para mostrar la vista creada
select * from HembrasDiagnosticos

select * from EnfermedadesBovinos

------------------------------------------------------------------------------------------------------------------------------------------
--Consultas 


--Seleccionar todo la informacion de todos los Bovinos que se inyectaron  'Para parasitos ext e int' o 'Para parasitos ext'
Select Bo.*  from 
	(select b.Color,b.Edad,b.FechaIngreso,b.FechaNacimiento,b.id_Bovino,b.idSexo,b.Nombre,b.Raza,c.NombreColor,r.NombreRaza,vb.idVacunacion
	from Bovino as b inner join Raza as r on (b.Raza = r.Raza) inner join Color as c on (b.Color = c.Color) inner join 
	Vacunacion_Bovino as vb ON (b.id_Bovino = vb.idBovino)) as Bo inner join 


	(select v.idTipo,v.idVacunacion,t.TipoVacunacion,pv.Nombre,p.Detalle from Vacunacion as v inner join Tipo as t on (v.idVacunacion = t.idTipo) inner join 
	Producto_Vacunacion as pv on(v.idVacunacion = pv.idVacunacion) inner join Producto as p on (pv.Nombre = p.Nombre)) as Vacu on (Bo.idVacunacion = Vacu.idVacunacion )
	where Vacu.Detalle = 'Para parasitos ext' or Vacu.Detalle = 'Para parasitos ext e int'

--Seleccionar El id,Nombre, raza ,Color,sexo   de todos los animales que se hayan vacunado con el producto Piroflox
Select Bo.id_Bovino,Bo.Nombre,Bo.NombreRaza,Bo.NombreColor,Bo.idSexo from 
	(select b.Color,b.Edad,b.FechaIngreso,b.FechaNacimiento,b.id_Bovino,b.idSexo,b.Nombre,b.Raza,c.NombreColor,r.NombreRaza,vb.idVacunacion
	from Bovino as b inner join Raza as r on (b.Raza = r.Raza) inner join Color as c on (b.Color = c.Color) inner join 
	Vacunacion_Bovino as vb ON (b.id_Bovino = vb.idBovino)) as Bo inner join 


	(select v.idTipo,v.idVacunacion,t.TipoVacunacion,pv.Nombre,p.Detalle from Vacunacion as v inner join Tipo as t on (v.idVacunacion = t.idTipo) inner join 
	Producto_Vacunacion as pv on(v.idVacunacion = pv.idVacunacion) inner join Producto as p on (pv.Nombre = p.Nombre)) as Vacu on (Bo.idVacunacion = Vacu.idVacunacion )
	where Vacu.Nombre = 'Piroflox'


--Triggers 
--Validar que la base de datos solo tenga registro de una unica empresa

go
 create or alter trigger ValidarCantidadEmpresas
  on  empresa 
  for insert, update 
  as
		declare
		@Cant_Empresas tinyint,
		@empresa tinyint;

		set @empresa = (select idEmpresa from inserted);
		set @Cant_Empresas= (select count(*) from empresa)

		if (@Cant_Empresas > 1)
		begin
			RAISERROR('Transaccion denegada debido a que ya existen la única empresa  posible',16,1)
		rollback;
		end
		else
		begin
			print('Registro completado')
		end
 go





--Validar que solo puedan existir 3 registros de usuarios en el sistema 
go
 create or alter trigger ValidarCantidadUsuarios
  on  usuario 
  for insert, update 
  as
		declare
		@Cant_Usuarios tinyint,
		@usuario varchar(10);

		set @usuario = (select nombreUsuario from inserted);
		set @Cant_Usuarios= (select count(*) from usuario)

		if (@Cant_Usuarios > 4)
		begin
			RAISERROR('Transaccion denegada debido a que ya existen los 4 posibles registros',16,1)
		rollback;
		end
		else
		begin
			print('Registro completado')
		end
 go



--Cursor 1

--indice 1



--Reglas especificas para las tablas

--Se crea una regla para que en el campo de sexo solo se puedan ingresar ''H','M'
go
create rule DatosSexo as @sexo in ('H','M')
go

--ahora se vinvula con una tabla en especifico

EXEC sp_bindrule 	'DatosSexo',	'Sexo.sexo_animal'

--Crear una regla para Colores 
go
create rule DatosColor as @Color between 0 and 8
go

EXEC sp_bindrule 	'DatosColor',	'Color.Color'


--Crear una regla para Raza
go
create rule DatosRaza as @Raza between 0 and 5
go
EXEC sp_bindrule 	'DatosRaza',	'Raza.Raza'


--Crear una regla para Tipo
go
create rule DatosTipo as @Tipo in ('D','E')
go
EXEC sp_bindrule 	'DatosTipo',	'Tipo.TipoVacunacion'

--Crear una regla para TipoPartos
go
create rule DatosTipoPartos as @TipoPartos in ('A','C','D','N')
go
EXEC sp_bindrule 	'DatosTipoPartos',	'tipo_parto.tipo_parto'



select * from pesas

select * from produccion

select * from horario

--Insertar valores en Produccion 
insert into produccion values ('2000-08-09',34,1)
insert into produccion values ('2000-09-09',32,1)
insert into produccion values ('2000-10-09',28,2)
insert into produccion values ('2000-11-09',37,2)
insert into produccion values ('2000-08-08',34,3)
insert into produccion values ('2000-09-08',32,3)
insert into produccion values ('2000-10-08',28,5)
insert into produccion values ('2000-11-08',37,7)


--Insertar valores en Pesas

insert into pesas values (12,'2000-08-09',10)
insert into pesas values (24,'2000-08-09',8)
insert into pesas values (13,'2000-10-08',10)
insert into pesas values (23,'2000-08-09',8)
insert into pesas values (15,'2000-11-08',10)
insert into pesas values (26,'2000-11-08',8)






--*************************tabla de medidas_corporales****************************
IF OBJECT_ID('medidas_corporales', 'U') IS NOT NULL  
   DROP TABLE medidas_corporales;  
go
CREATE TABLE medidas_corporales
(
	fecha	DATE NOT NULL,
	condicion	VARCHAR(10) NULL,
	peso	INT  NULL,
	CONSTRAINT PK_medidas_corporales_fecha
		PRIMARY KEY(fecha),
	
);
go

--*************************tabla de medidas_bovinos****************************
IF OBJECT_ID('medidas_bovinos', 'U') IS NOT NULL  
   DROP TABLE medidas_bovinos;  
go
CREATE TABLE medidas_bovinos
(
	fecha	DATE NOT NULL,
	id_bovino	INT NOT NULL,
	CONSTRAINT PK_medidas_bovinos_fecha_id_bovino
		PRIMARY KEY(fecha, id_bovino),
	CONSTRAINT FK_medidas_bovinos_id_bovino
		FOREIGN KEY (id_bovino) REFERENCES Bovino(id_Bovino),
	CONSTRAINT FK_medidas_bovinos_fecha
		FOREIGN KEY (fecha) REFERENCES medidas_corporales(fecha),
);
go
--*************************tabla de reproduccion****************************




IF OBJECT_ID('reproduccion', 'U') IS NOT NULL  
   DROP TABLE reproduccion;  
go
CREATE TABLE reproduccion
(
	id_reproduccion INT identity (1,1) NOT NULL ,
	fecha_registro	DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT PK_reproduccion_id_reproduccion
		PRIMARY KEY(id_reproduccion),
	CONSTRAINT UNK_reproduccion_fecha_registro
		UNIQUE (fecha_registro),
	
);
go
--*************************tabla de reproduccion_bovinos****************************
IF OBJECT_ID('reproduccion_bovinos', 'U') IS NOT NULL  
   DROP TABLE reproduccion_bovinos;  
go
CREATE TABLE reproduccion_bovinos
(
	id_reproduccion INT NOT NULL,
	id_Bovino	INT NOT NULL,
	CONSTRAINT PK_reproduccion_bovinos_id_reproduccion_id_bovino
		PRIMARY KEY(id_reproduccion,id_Bovino),
	CONSTRAINT FK_reproduccion_bovinos_id_reproduccion
		FOREIGN KEY (id_reproduccion) REFERENCES reproduccion(id_reproduccion),
	CONSTRAINT FK_reproduccion_bovinos_id_Bovino
		FOREIGN KEY (id_Bovino) REFERENCES Bovino(id_Bovino),
);
go
--*************************tabla de tipo_fecu****************************
IF OBJECT_ID('tipo_fecu', 'U') IS NOT NULL  
   DROP TABLE tipo_fecu;  
go
CREATE TABLE tipo_fecu
(
	tipo_fecu	TINYINT  NOT NULL,
	fecundacion VARCHAR(20) NOT NULL,
	CONSTRAINT PK_tipo_fecu_tipo
		PRIMARY KEY(tipo_fecu),
	CONSTRAINT UNK_tipo_fecu_fecundacion
		UNIQUE (fecundacion),	
);
go
--*************************tabla de preñez****************************
IF OBJECT_ID('preñez', 'U') IS NOT NULL  
   DROP TABLE preñez;  
go
CREATE TABLE preñez
(
	id_preñez INT NOT NULL,
	id_bovino	INT   NULL,
	dias_preñez	INT  NOT NULL,
	posible_fecha_parto DATE NULL,
	tipo_fecu	TINYINT  NULL,
	CONSTRAINT PK_preñez_id_preñez
		PRIMARY KEY(id_preñez),
	CONSTRAINT FK_preñez_id_preñez
		FOREIGN KEY (id_preñez) REFERENCES reproduccion(id_reproduccion),
	CONSTRAINT FK_preñez_id_bovino
		FOREIGN KEY (id_bovino) REFERENCES Bovino(id_Bovino),
	CONSTRAINT FK_preñez_tipo_fecu
		FOREIGN KEY (tipo_fecu) REFERENCES tipo_fecu(tipo_fecu),

	
);
go
--*************************tabla de servicios****************************
IF OBJECT_ID('servicios', 'U') IS NOT NULL  
   DROP TABLE servicios;  
go
CREATE TABLE servicios
(
	id_servicio INT NOT NULL,
	comentario	VARCHAR(40)  NULL,
	numero_servicio	INT  NULL,
	id_preñez INT NULL,
	CONSTRAINT PK_servicios_id_servicio
		PRIMARY KEY(id_servicio),
	CONSTRAINT FK_servicios_id_servicio
		FOREIGN KEY (id_servicio) REFERENCES reproduccion(id_reproduccion),
	CONSTRAINT FK_servicios_id_preñez
		FOREIGN KEY (id_preñez) REFERENCES preñez(id_preñez),

);
go
--*************************tabla de sexo****************************
IF OBJECT_ID('sexo', 'U') IS NOT NULL  
   DROP TABLE sexo;  
go
CREATE TABLE sexo
(
	id_sexo	TINYINT  NOT NULL,
	sexo_animal CHAR(1) NOT NULL,
	CONSTRAINT PK_sexo_id_sexo
		PRIMARY KEY(id_sexo),
	CONSTRAINT UNK_sexo_sexo_animal 
		UNIQUE (sexo_animal),	
);
go
--*************************tabla de tipo_parto****************************
IF OBJECT_ID('tipo_parto', 'U') IS NOT NULL  
   DROP TABLE tipo_parto;  
go
CREATE TABLE tipo_parto
(
	id_parto	TINYINT  NOT NULL,
	tipo_parto	CHAR(1) NOT NULL,
	CONSTRAINT PK_tipo_parto_id_parto
		PRIMARY KEY(id_parto),
	CONSTRAINT UNK_tipo_parto_id_parto
		UNIQUE (tipo_parto),	
);
go
--*************************tabla de estado_parto****************************
IF OBJECT_ID('estado_parto', 'U') IS NOT NULL  
   DROP TABLE estado_parto;  
go
CREATE TABLE estado_parto
(
	id_estado	TINYINT  NOT NULL,
	estado_parto	CHAR(1) NOT NULL,
	CONSTRAINT PK_estado_parto_id_estado
		PRIMARY KEY(id_estado),
	CONSTRAINT UNK_estado_parto_estado_parto
		UNIQUE (estado_parto),	
);
go
--*************************tabla de partos****************************
IF OBJECT_ID('partos', 'U') IS NOT NULL  
   DROP TABLE partos;  
go
CREATE TABLE partos
(
	id_partos	INT NOT NULL,
	id_sexo		TINYINT  NULL,
	comentario	VARCHAR(40)  NULL,
	id_parto	TINYINT NULL,
	id_estado	TINYINT NULL,
	CONSTRAINT PK_partos_id_partos
		PRIMARY KEY(id_partos),
	CONSTRAINT FK_partos_id_partos
		FOREIGN KEY (id_partos) REFERENCES reproduccion(id_reproduccion),
	CONSTRAINT FK_partos_id_sexo
		FOREIGN KEY (id_sexo) REFERENCES sexo(id_sexo),
	CONSTRAINT FK_partos_id_parto
		FOREIGN KEY (id_parto) REFERENCES tipo_parto(id_parto),
	CONSTRAINT FK_partos_id_estado
		FOREIGN KEY (id_estado) REFERENCES estado_parto(id_estado),

);
go
--*************************tabla de partos_bovinos****************************
IF OBJECT_ID('partos_bovinos', 'U') IS NOT NULL  
   DROP TABLE partos_bovinos;  
go
CREATE TABLE partos_bovinos
(
	id_partos	INT NOT NULL,
	id_Bovino		INT NOT NULL,
	CONSTRAINT PK_partos_bovinos_id_partos_id_bovino
		PRIMARY KEY(id_partos,id_Bovino),
	CONSTRAINT FK_partos_bovinos_id_partos
		FOREIGN KEY (id_partos) REFERENCES partos(id_partos),
	CONSTRAINT FK_partos_bovinos_id_Bovino
		FOREIGN KEY (id_Bovino) REFERENCES Bovino(id_Bovino),
);
go
--*************************tabla de celos****************************
IF OBJECT_ID('celos', 'U') IS NOT NULL  
   DROP TABLE celos;  
go
CREATE TABLE celos
(
	id_celos INT NOT NULL,
	detalle	VARCHAR(40)  NULL
	CONSTRAINT PK_celos_id_celos
		PRIMARY KEY(id_celos),
	CONSTRAINT FK_celos_id_celos
		FOREIGN KEY (id_celos) REFERENCES reproduccion(id_reproduccion),
	
);
go


/*Procedimientos de ins_empresa_usuario*/
use P1G8;

go
CREATE or ALTER PROCEDURE ins_empresa_usuario
	@idEmpresa TINYINT,
	@nombre varchar(20),
	@ubicacion varchar(40),
	@nombreUsuario varchar(10),
	@contraseña varchar(8)
AS

INSERT INTO empresa (idEmpresa,nombre,ubicacion)
     VALUES (@idEmpresa,@nombre,@ubicacion )


INSERT INTO usuario (nombreUsuario,idEmpresa,contraseña)
     VALUES(@nombreUsuario,@idEmpresa,@contraseña)

go

/*Procedimientos de ins_empresa*/
go
CREATE or ALTER PROCEDURE ins_empresa
	@idEmpresa TINYINT,
	@nombre varchar(20),
	@ubicacion varchar(40)
AS
INSERT INTO empresa (idEmpresa,nombre,ubicacion)
     VALUES (@idEmpresa,@nombre,@ubicacion )
go

/*Procedimiento de ins_usuario*/
go
CREATE or ALTER PROCEDURE ins_usuario
	@nombreUsuario varchar(10),
	@contraseña varchar(8),
	@idEmpresa TINYINT
AS

INSERT INTO usuario (nombreUsuario,contraseña,idEmpresa)
     VALUES(@nombreUsuario,@contraseña,@idEmpresa)
go

/*Procedimiento de upd_empresa*/
CREATE or ALTER PROCEDURE upd_empresa
	@idEmpresa TINYINT,
	@nombre varchar(20),
	@ubicacion varchar(40)
	
AS
	update empresa
	set		idEmpresa=@idEmpresa,
			nombre=@nombre,
			ubicacion=@ubicacion
	where idEmpresa=@idEmpresa
go

/*Procedimiento de upd_usuario*/
CREATE or ALTER PROCEDURE upd_usuario
	@nombreUsuario varchar(10),
	@contraseña varchar(8),
	@idEmpresa TINYINT
	
AS
	update usuario
	set		nombreUsuario=@nombreUsuario,
			contraseña=@contraseña,
			idEmpresa=@idEmpresa
	where nombreUsuario=@nombreUsuario
go

/*Procedimiento de sel_empresa */
go
CREATE or ALTER PROCEDURE sel_empresa 
	@idEmpresa TINYINT,
	@nombre varchar(20),
	@ubicacion varchar(40)
AS
	select * from empresa
	where 
		(@idEmpresa IS NULL or idEmpresa=@idEmpresa) and
		(@nombre IS NULL or nombre=@nombre) and
		(@ubicacion IS NULL or ubicacion=@ubicacion)
go


/*Procedimiento de del_empresa*/
CREATE or ALTER PROCEDURE del_empresa
	@idEmpresa TINYINT
AS
	delete empresa
	
	where idEmpresa=@idEmpresa
go



go

/*Procedimiento de sel_usuario*/
go
CREATE or ALTER PROCEDURE sel_usuario
	@nombreUsuario varchar(10),
	@contraseña varchar(8),
	@idEmpresa TINYINT
AS
	select * from usuario
	where
		(@nombreUsuario IS NULL or nombreUsuario=@nombreUsuario) and
		(@contraseña IS NULL or contraseña=@contraseña) and
		(@idEmpresa IS NULL or idEmpresa=@idEmpresa) 
go


/*Procedimiento de del_usuario*/
CREATE or ALTER PROCEDURE del_usuario
	@nombreUsuario varchar(10)
AS
	delete usuario
	
	where nombreUsuario=@nombreUsuario
go


/*Procedimiento de ins_bovino*/
CREATE or ALTER PROCEDURE ins_bovino
	@id_Bovino INT,
	@Nombre varchar(20),
	@idEmpresa TINYINT,
	@Color TINYINT,
	@idSexo TINYINT,
	@Raza TINYINT,
	@FechaNacimiento DATE
AS
INSERT INTO Bovino
           (id_Bovino,Nombre,Color,idSexo,Raza,FechaNacimiento,Edad,idEmpresa)
     VALUES
           (@id_Bovino,@Nombre,@Color,@idSexo,@Raza,@FechaNacimiento,DATEDIFF(YEAR,@FechaNacimiento,GETDATE()),@idEmpresa)
go


/*Procedimiento de ins_medidas_corporales*/
go
CREATE or ALTER PROCEDURE ins_medidas_corporales
	@fecha	DATE ,
	@condicion	VARCHAR(10) ,
	@peso	INT  
AS

INSERT INTO medidas_corporales(fecha,condicion,peso)
     VALUES(@fecha,@condicion,@peso)
go


/*Procedimiento de ins_medidas_bovinos*/
GO
CREATE or ALTER PROCEDURE ins_medidas_bovinos
	@fecha	DATE ,
	@id_Bovino	INT  
AS

INSERT INTO medidas_bovinos(fecha,id_bovino)
     VALUES(@fecha,@id_Bovino)
go


/*Procedimiento de ins_medidas_corporales_bovino*/
CREATE or ALTER PROCEDURE ins_medidas_corporales_bovino
	@fecha	DATE ,
	@condicion	VARCHAR(10) ,
	@peso	INT,
	@id_Bovino INT
AS

	declare
		@error bit;
	set @error='False';

	begin transaction
		INSERT INTO medidas_corporales(fecha,condicion,peso)
			 VALUES(@fecha,@condicion,@peso)
		if @@error>0
		begin
			print ('Error al momento insertar las medidas corporales')
			set @error='True';
		end
		INSERT INTO medidas_bovinos(fecha,id_bovino)
			 VALUES(@fecha,@id_Bovino)
		if @@error>0
		begin
			print ('Error al momento de insertarlo con el bovino')
			set @error='True';
		end

		if @error='True'
		begin
			print ('NO se registró las medidas corporales con el bovino')
			rollback transaction
		end
		else
		begin
			print ('Se registró las medidas corporales con el bovino')
			commit transaction
		end;
go

go
execute ins_medidas_corporales_bovino '1990-04-05','Bueno',30,2
execute ins_medidas_corporales_bovino '1991-04-05','malo',50,4
execute ins_medidas_corporales_bovino '1990-06-05','Bueno',30,3
execute ins_medidas_corporales_bovino '1995-04-05','Bueno',150,1
go


/*Procedimiento de upd_medidas_corporales*/
go
CREATE or ALTER  PROCEDURE upd_medidas_corporales
	@fecha	DATE ,
	@condicion	VARCHAR(10) ,
	@peso	INT
AS
	update medidas_corporales
	set		fecha=@fecha,
			condicion=@condicion,
			peso=@peso
	where fecha=@fecha
go


/*Procedimiento de upd_bovino*/
go
CREATE or ALTER PROCEDURE upd_bovino
	@id_Bovino INT,
	@Nombre varchar(20),
	@idEmpresa TINYINT,
	@Color TINYINT,
	@idSexo TINYINT,
	@Raza TINYINT,
	@FechaNacimiento DATE
	
AS
	update Bovino
	set		id_Bovino=@id_Bovino,
			Nombre=@Nombre,
			idEmpresa=@idEmpresa,
			Color=@Color,
			idSexo=@idSexo,
			Raza=@Raza,
			FechaNacimiento=@FechaNacimiento
	where id_Bovino=@id_Bovino
go



/*Procedimiento de sel_bovino*/
go
CREATE or ALTER PROCEDURE sel_bovino
	@id_Bovino INT,
	@Nombre varchar(20),
	@idEmpresa TINYINT,
	@Color TINYINT,
	@idSexo TINYINT,
	@Raza TINYINT,
	@FechaNacimiento DATE,
	@FechaIngreso DATE,
	@FechaSalida DATE
AS
	select * from Bovino
	where 
		(@id_Bovino IS NULL or id_Bovino=@id_Bovino) and
		(@Nombre IS NULL or Nombre=@Nombre) and
		(@idEmpresa IS NULL or idEmpresa=@idEmpresa) and
		(@Color IS NULL or Color=@Color) and
		(@idSexo IS NULL or idSexo=@idSexo) and
		(@Raza IS NULL or Raza=@Raza) and
		(@FechaNacimiento IS NULL or FechaNacimiento=@FechaNacimiento) and
		(@FechaIngreso IS NULL or FechaIngreso=@FechaIngreso) and
		(@FechaSalida IS NULL or FechaSalida=@FechaSalida) 
go


/*Procedimiento de del_bovino*/
GO
CREATE or ALTER PROCEDURE del_bovino
	@id_Bovino INT
AS
	delete Bovino
	
	where id_Bovino=@id_Bovino
GO

/*Procedimiento de ins_reproducccion*/
GO
CREATE OR ALTER PROCEDURE ins_reproducccion
	@id_reproduccion INT,
	@id_Bovino	INT

AS
	declare
		@error bit;
	set @error='False';
INSERT INTO reproduccion(id_reproduccion)
     VALUES (@id_reproduccion)


INSERT INTO reproduccion_bovinos(id_reproduccion,id_Bovino)
     VALUES(@id_reproduccion,@id_Bovino)

go

/*Procedimiento de upd_reproduccion*/
go
CREATE PROCEDURE upd_reproduccion
	@id_reproduccion INT,
	@id_Bovino	INT
	
AS
	update reproduccion
	set		id_reproduccion=@id_reproduccion,
			fecha_registro=CURRENT_TIMESTAMP
	where id_reproduccion=@id_reproduccion
go

/*Procedimiento de sel_reproduccion*/
go
CREATE or ALTER PROCEDURE sel_reproduccion
	@id_reproduccion INT,
	@fecha_registro	DATETIME
AS
	select * from reproduccion
	where 
		(@id_reproduccion IS NULL or id_reproduccion=@id_reproduccion) and
		(@fecha_registro IS NULL or fecha_registro=@fecha_registro)
go

/*Procedimiento de sel_reproduccion_bovinos*/
go
CREATE or ALTER PROCEDURE sel_reproduccion_bovinos
	@id_reproduccion INT,
	@id_Bovino	INT 
AS
	select * from reproduccion_bovinos
	where 
		(@id_reproduccion IS NULL or id_reproduccion=@id_reproduccion) and
		(@id_Bovino IS NULL or id_Bovino=@id_Bovino)
go

/*Procedimiento de del_reproduccion*/
go
CREATE PROCEDURE del_reproduccion
	@id_reproduccion INT
AS
	delete reproduccion
	
	where id_reproduccion=@id_reproduccion
go

/*Procedimiento de ins_reproducccion_celos*/
go
CREATE or ALTER PROCEDURE ins_reproducccion_celos
	@id_reproduccion INT,
	@id_Bovino	INT,
	@detalle	VARCHAR(40)
	

AS
	declare
		@error bit;
	set @error='False';
	SET IDENTITY_INSERT reproduccion ON;

	begin transaction
	INSERT INTO reproduccion(id_reproduccion)
		 VALUES (@id_reproduccion)
	if @@error>0
		begin
			print ('Error al momento insertar la reproduccion')
			set @error='True';
		end

	INSERT INTO reproduccion_bovinos(id_reproduccion,id_Bovino)
		 VALUES(@id_reproduccion,@id_Bovino)
	if @@error>0
		begin
			print ('Error al momento insertar la reproduccion en bovinos')
			set @error='True';
		end
	INSERT INTO celos(id_celos,detalle)
		 VALUES(@id_reproduccion,@detalle)
	SET IDENTITY_INSERT reproduccion OFF;

		if @@error>0
		begin
			print ('Error al momento de insertar en el celos')
			set @error='True';
		end
		if @error='True'
		begin
			print ('NO se registró el celo con el bovino')
			rollback transaction
		end
		else
		begin
			print ('Se registró el celo con el bovino')
			commit transaction
		end;
go

exec ins_reproducccion_celos 30,1,'regular'
exec ins_reproducccion_celos 31,2,'regular'
exec ins_reproducccion_celos 32,3,'irregular'
exec ins_reproducccion_celos 33,4,'regular'
exec ins_reproducccion_celos 34,1,'irregular'

go
select * from celos
go


/*Procedimiento de sel_celos*/
CREATE or ALTER PROCEDURE sel_celos
	@id_celos INT,
	@detalle	VARCHAR(40)
AS
	select * from celos
	where 
		(@id_celos IS NULL or id_celos=@id_celos) and
		(@detalle IS NULL or detalle=@detalle)
go


/*Procedimiento de upd_reproduccion_celos*/
go
CREATE PROCEDURE upd_reproduccion_celos
	@id_celos INT,
	@detalle	VARCHAR(40)
AS
	update celos
	set		id_celos=@id_celos,
			detalle=@detalle
	where id_celos=@id_celos
go


/*Procedimiento de del_celos*/
go
CREATE PROCEDURE del_celos
	@id_celos INT
AS
	delete celos
	
	where id_celos=@id_celos
go


/*Procedimiento de ins_reproducccion_servicio*/
go
CREATE or Alter PROCEDURE ins_reproducccion_servicio
	@id_reproduccion INT,
	@id_Bovino	INT,
	@comentario	VARCHAR(40)
AS
	declare
		@error bit;
	set @error='False';
	SET IDENTITY_INSERT reproduccion ON;
		begin transaction
	INSERT INTO reproduccion(id_reproduccion)
		 VALUES (@id_reproduccion)
	if @@error>0
		begin
			print ('Error al momento insertar la reproduccion')
			set @error='True';
		end

	INSERT INTO reproduccion_bovinos(id_reproduccion,id_Bovino)
		 VALUES(@id_reproduccion,@id_Bovino)
	if @@error>0
		begin
			print ('Error al momento insertar la reproduccion en bovinos')
			set @error='True';
		end

	INSERT INTO servicios(id_servicio,comentario)
		 VALUES(@id_reproduccion,@comentario)
		SET IDENTITY_INSERT reproduccion OFF;
	if @@error>0
		begin
			print ('Error al momento de insertar el servicio')
			set @error='True';
		end
		if @error='True'
		begin
			print ('NO se registró el servicio con el bovino')
			rollback transaction
		end
		else
		begin
			print ('Se registró el servicio con el bovino')
			commit transaction
		end;
go
exec ins_reproducccion_servicio 1,1,'toro'
exec ins_reproducccion_servicio 8,2,'toro'
exec ins_reproducccion_servicio 9,3,'artificial'
exec ins_reproducccion_servicio 10,4,'artificial'
exec ins_reproducccion_servicio 11,5,'toro'
go

/*Procedimiento de sel_servicios*/
CREATE or ALTER PROCEDURE sel_servicios
	@id_servicios INT,
	@comentario	VARCHAR(40),
	@numero_servicio TINYINT,
	@id_preñez int
AS
	select * from servicios
	where 
		(@id_servicios IS NULL or id_servicio=@id_servicios) and
		(@comentario IS NULL or comentario=@comentario) and
		(@numero_servicio IS NULL or numero_servicio=@numero_servicio) and
		(@id_preñez IS NULL or id_preñez=@id_preñez) 
go

/*Procedimiento de upd_servicios*/
go
CREATE or ALTER PROCEDURE upd_servicios
	@id_servicios INT,
	@comentario	VARCHAR(40),
	@numero_servicio TINYINT,
	@id_preñez	INT
AS
	update servicios
	set		id_servicio=@id_servicios,
			comentario=@comentario,
			numero_servicio=@numero_servicio,
			id_preñez=@id_preñez
	where id_servicio=@id_servicios
go

/*Procedimiento de del_servicios*/
go
CREATE PROCEDURE del_servicios
	@id_servicio INT
AS
	delete servicios
	where id_servicio=@id_servicio
go

/*Procedimiento de ins_reproducccion_preñez*/
go
CREATE or ALTER PROCEDURE ins_reproducccion_preñez
	@id_reproduccion INT,
	@id_Bovino	INT,
	@id_bovino_padre	INT,
	@dias_preñez	INT,
	@tipo_fecu	TINYINT
	
AS
	declare
		@error bit;
	set @error='False';
		SET IDENTITY_INSERT reproduccion ON;
		begin transaction
	INSERT INTO reproduccion(id_reproduccion)
		 VALUES (@id_reproduccion)
	if @@error>0
		begin
			print ('Error al momento insertar la reproduccion')
			set @error='True';
		end

	INSERT INTO reproduccion_bovinos(id_reproduccion,id_Bovino)
		 VALUES(@id_reproduccion,@id_Bovino)
	if @@error>0
		begin
			print ('Error al momento insertar la reproduccion en bovinos')
			set @error='True';
		end
	INSERT INTO preñez(id_preñez,id_bovino,dias_preñez,tipo_fecu)
		 VALUES(@id_reproduccion,@id_bovino_padre,@dias_preñez,@tipo_fecu)
	SET IDENTITY_INSERT reproduccion OFF;

	if @@error>0
		begin
			print ('Error al momento de insertar el preñez')
			set @error='True';
		end
		if @error='True'
		begin
			print ('NO se registró el preñez con el bovino')
			rollback transaction
		end
		else
		begin
			print ('Se registró el preñez con el bovino')
			commit transaction
		end;
go


/***************Trigger: Valida que un bovino_padre no puede ser hembra***********************/
go
create or alter trigger dbo.trigger_validar_bovino_padre
on preñez
for insert,update
as
	declare
		@id_bovino_padre int,
		@id_sexo TINYINT;
		set @id_bovino_padre=(select id_bovino from inserted);
		set @id_sexo=(select idSexo from Bovino where id_Bovino=@id_bovino_padre);

	if (@id_sexo=0)
	begin
		RAISERROR('Estoy ejecutando el trigger y voy a rechazar la transacción por que el padre no es macho',16,1)
		rollback;
	end
	else
	begin
		print ('Registrado la preñez del bovino')		
	end;
go

go
insert into tipo_fecu(tipo_fecu,fecundacion) values 
	(1,'natural'),
	(2,'inseminación');
go


go
exec ins_reproducccion_preñez 18,1,2,60,1
exec ins_reproducccion_preñez 19,3,4,50,2
exec ins_reproducccion_preñez 20,5,2,30,1
exec ins_reproducccion_preñez 21,6,2,40,1
exec ins_reproducccion_preñez 22,7,4,20,2
exec ins_reproducccion_preñez 27,1,3,20,2
exec ins_reproducccion_preñez 28,3,5,20,2


go
select*from reproduccion
go

/*Procedimiento de sel_preñez*/
CREATE or ALTER PROCEDURE sel_preñez
	@id_preñez INT,
	@id_bovino_padre INT,
	@dias_preñez	INT,
	@posible_fecha_parto DATE,
	@tipo_fecu	TINYINT
AS
	select * from preñez
	where 
		(@id_preñez IS NULL or id_preñez=@id_preñez) and
		(@id_bovino_padre IS NULL or id_bovino=@id_bovino_padre) and
		(@dias_preñez IS NULL or dias_preñez=@dias_preñez) and
		(@posible_fecha_parto IS NULL or posible_fecha_parto=@posible_fecha_parto) and
		(@tipo_fecu IS NULL or tipo_fecu=@tipo_fecu) 
go


/*Procedimiento de upd_preñez*/
go
CREATE or ALTER PROCEDURE upd_preñez
	@id_preñez INT,
	@id_bovino_padre INT,
	@dias_preñez	INT,
	@posible_fecha_parto DATE,
	@tipo_fecu	TINYINT
AS
	update preñez
	set		id_preñez=@id_preñez,
			id_bovino=@id_bovino_padre,
			dias_preñez=@dias_preñez,
			posible_fecha_parto=@posible_fecha_parto,
			tipo_fecu=@tipo_fecu
	where id_preñez=@id_preñez
go


/*Procedimiento de del_preñez*/
go
CREATE PROCEDURE del_preñez
	@id_preñez INT
AS
	delete preñez
	where id_preñez=@id_preñez
go

/*Procedimiento de ins_reproducccion_partos*/
go
CREATE or ALTER PROCEDURE ins_reproducccion_partos
	@id_reproduccion INT,
	@id_Bovino	INT,
	@id_sexo		TINYINT,
	@comentario	VARCHAR(40),
	@id_parto	TINYINT,
	@id_estado	TINYINT
	
AS
	declare
		@error bit;
	set @error='False';
	SET IDENTITY_INSERT reproduccion ON;
	begin transaction
	INSERT INTO reproduccion(id_reproduccion)
		 VALUES (@id_reproduccion)
	if @@error>0
		begin
			print ('Error al momento de insertar reproducccion')
			set @error='True';
		end
	INSERT INTO reproduccion_bovinos(id_reproduccion,id_Bovino)
		 VALUES(@id_reproduccion,@id_Bovino)
	if @@error>0
		begin
			print ('Error al momento de insertar reproduccion en bovinos')
			set @error='True';
		end
	INSERT INTO partos(id_partos,id_sexo,comentario,id_parto,id_estado)
		 VALUES(@id_reproduccion,@id_sexo,@comentario,@id_parto,@id_estado)
	SET IDENTITY_INSERT reproduccion OFF;
	if @@error>0
		begin
			print ('Error al momento de insertar partos')
			set @error='True';
		end
		if @error='True'
		begin
			print ('NO se registró el partos con el bovino')
			rollback transaction
		end
		else
		begin
			print ('Se registró el parto con el bovino')
			commit transaction
		end;
go


/*Procedimiento de ins_reproducccion_partos_bovino*/
go
CREATE or ALTER PROCEDURE ins_reproducccion_partos_bovino
	@id_reproduccion INT,
	@id_Bovino	INT,
	@id_sexo		TINYINT,
	@comentario	VARCHAR(40),
	@id_parto	TINYINT,
	@id_estado	TINYINT,
	@id_cria INT,
	@Nombre varchar(20),
	@idEmpresa TINYINT,
	@Color TINYINT,
	@Raza TINYINT,
	@FechaNacimiento DATE
AS
	declare
		@error bit;
	set @error='False';
	SET IDENTITY_INSERT reproduccion ON;
	begin transaction
	INSERT INTO reproduccion(id_reproduccion)
		 VALUES (@id_reproduccion)
	if @@error>0
		begin
			print ('Error al momento de insertar reproducccion')
			set @error='True';
		end
	INSERT INTO reproduccion_bovinos(id_reproduccion,id_Bovino)
		 VALUES(@id_reproduccion,@id_Bovino)
	if @@error>0
		begin
			print ('Error al momento de insertar reproduccion en bovinos')
			set @error='True';
		end
	INSERT INTO partos(id_partos,id_sexo,comentario,id_parto,id_estado)
		 VALUES(@id_reproduccion,@id_sexo,@comentario,@id_parto,@id_estado)
	SET IDENTITY_INSERT reproduccion OFF;
	if @@error>0
		begin
			print ('Error al momento de insertar partos')
			set @error='True';
		end
	if @id_estado=0 and @id_cria<>NULL
		begin
			INSERT INTO Bovino
				   (id_Bovino,Nombre,Color,idSexo,Raza,FechaNacimiento,Edad,FechaIngreso,idEmpresa)
			 VALUES
				   (@id_cria,@Nombre,@Color,@id_sexo,@Raza,@FechaNacimiento,DATEDIFF(YEAR,@FechaNacimiento,GETDATE()),GETDATE(),@idEmpresa)
			if @@error>0
				begin
					print ('Error al momento de insertar la cria nueva')
					set @error='True';
				end

			INSERT INTO partos_bovinos(id_partos,id_Bovino)
				 VALUES(@id_reproduccion,@id_cria)
			if @@error>0
				begin
					print ('Error al momento de insertar la cria con el parto')
					set @error='True';
				end
		end
		else
		begin
			if @error='True'
			begin
				print ('NO se registró el partos con el bovino y la cria')
				rollback transaction
			end
			else
			begin
				print ('Se registró el toda el parto con el bovino')
				commit transaction
			end
		end;
go

go
exec ins_reproducccion_partos_bovino 25,5,0,'bien',0,0,10,'Vaca10',112,2,1,'2022-05-04'
exec ins_reproducccion_partos_bovino 26,7,0,'bien',0,0,11,'Vaca11',112,3,0,'2022-05-04'
exec ins_reproducccion_partos_bovino 27,1,0,'bien',0,0,12,'Vaca12',112,0,1,'2022-06-04'
exec ins_reproducccion_partos_bovino 28,3,0,'bien',0,1,13,'Vaca13',112,0,1,'2022-06-04' 


select*from Bovino
go

go
insert into tipo_parto(id_parto,tipo_parto) values
	(0,'N'),
	(1,'A'),
	(2,'C'),
	(3,'D');
go

go
insert into estado_parto(id_estado,estado_parto) values
	(0,'E'),
	(1,'F');
go

go
exec ins_reproducccion_partos 23,1,2,'mal',0,2
exec ins_reproducccion_partos 24,3,1,'mal',1,1
exec ins_reproducccion_preñez 19,3,4,50,2
exec ins_reproducccion_preñez 20,5,2,30,1
exec ins_reproducccion_preñez 21,6,2,40,1
exec ins_reproducccion_preñez 22,7,4,20,2
go


/*Procedimiento de sel_partos*/
go
CREATE or ALTER PROCEDURE sel_partos
	@id_partos INT,
	@id_sexo		TINYINT,
	@comentario	VARCHAR(40),
	@id_parto	TINYINT,
	@id_estado	TINYINT
AS
	select * from partos
	where 
		(@id_partos IS NULL or id_parto=@id_partos) and
		(@id_sexo IS NULL or id_sexo=@id_sexo) and
		(@comentario IS NULL or comentario=@comentario) and
		(@id_parto IS NULL or id_parto=@id_parto) and
		(@id_estado IS NULL or id_estado=@id_estado) 
go



/*Procedimiento de upd_partos*/
go
CREATE or ALTER PROCEDURE upd_partos
	@id_partos INT,
	@id_sexo	TINYINT,
	@comentario	VARCHAR(40),
	@id_parto	TINYINT,
	@id_estado	TINYINT
AS
	update partos
	set		id_parto=@id_partos,
			id_sexo=@id_sexo,
			comentario=@comentario,
			id_parto=@id_parto,
			id_estado=@id_estado
	where id_parto=@id_partos
go

/*Procedimiento de del_partos*/
go
CREATE PROCEDURE del_partos
	@id_partos INT
AS
	delete partos
	where id_partos=@id_partos
go




go
ALTER TABLE reproduccion Add DEFAULT (current_timestamp) for fecha_registro;

alter table servicios alter column numero_servicio TINYINT;

ALTER TABLE Bovino Add DEFAULT (getdate()) for FechaIngreso;
go

go
alter table medidas_bovinos drop constraint FK_medidas_bovinos_id_bovino;

alter table medidas_bovinos add
	constraint FK_medidas_bovinos_id_bovino
	foreign key (id_Bovino) references Bovino ON UPDATE CASCADE ON DELETE CASCADE;
go


alter table medidas_bovinos add
	constraint FK_medidas_bovinos_id_bovino
	foreign key (id_Bovino) references Bovino ON UPDATE CASCADE ON DELETE CASCADE;
go


ALTER TABLE Bovino Add DEFAULT (getdate()) for FechaIngreso;

ALTER TABLE Bovino Add DEFAULT (112) for idEmpresa;


go
alter table servicios drop constraint FK_servicios_id_servicio;

alter table servicios add
	constraint FK_servicios_id_servicio
	foreign key (id_servicio) references reproduccion (id_reproduccion) ON UPDATE CASCADE ON DELETE CASCADE;
go

go
alter table servicios drop constraint FK_servicios_id_preñez;

alter table servicios add
	constraint FK_servicios_id_preñez
	foreign key (id_preñez) references preñez (id_preñez)
go

go
alter table celos drop constraint FK_celos_id_celos;

alter table celos add
	constraint FK_celos_id_celos
	foreign key (id_celos) references reproduccion (id_reproduccion) ON UPDATE CASCADE ON DELETE CASCADE;
go

go
alter table preñez drop constraint FK_preñez_id_preñez;

alter table preñez add
	constraint FK_preñez_id_preñez
	foreign key (id_preñez) references reproduccion ON UPDATE CASCADE ON DELETE CASCADE;
go


go
alter table partos drop constraint FK_partos_id_partos;

alter table partos add
	constraint FK_partos_id_partos
	foreign key (id_partos) references reproduccion (id_reproduccion) ON UPDATE CASCADE ON DELETE CASCADE;
go

go
alter table partos_bovinos drop constraint FK_partos_bovinos_id_partos;

alter table partos_bovinos add
	constraint FK_partos_bovinos_id_partos
	foreign key (id_partos) references reproduccion (id_reproduccion) ON UPDATE CASCADE ON DELETE CASCADE;
go


/*Vista de la info de celos de los vacas*/
create view info_celos_bovinos
as
	Select b.id_Bovino,b.Nombre, re.id_reproduccion,re.fecha_registro,ce.detalle from
	 Bovino as b inner join reproduccion_bovinos as rb on (b.id_Bovino = rb.id_Bovino) inner join 
	 reproduccion as re on (rb.id_reproduccion=re.id_reproduccion) inner join 
	 celos as ce on (re.id_reproduccion=ce.id_celos)
go





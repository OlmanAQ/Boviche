CREATE TABLE [dbo].[Tipo] (
    [idTipo]         TINYINT  NOT NULL,
    [TipoVacunacion] CHAR (1) NOT NULL,
    PRIMARY KEY CLUSTERED ([idTipo] ASC),
    CONSTRAINT [FK_Tipo_idTipo] FOREIGN KEY ([idTipo]) REFERENCES [dbo].[Vacunacion] ([idVacunacion])
);


GO

CREATE TABLE [dbo].[usuario] (
    [nombreUsuario] VARCHAR (10) NOT NULL,
    [idEmpresa]     TINYINT      NOT NULL,
    [contraseña]    VARCHAR (8)  NOT NULL,
    CONSTRAINT [PK_usuario_nombreUsuario] PRIMARY KEY CLUSTERED ([nombreUsuario] ASC),
    CONSTRAINT [FK_usuario_idEmpresa] FOREIGN KEY ([idEmpresa]) REFERENCES [dbo].[empresa] ([idEmpresa]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO

CREATE TABLE [dbo].[Vacunacion] (
    [idVacunacion] TINYINT NOT NULL,
    [idTipo]       TINYINT NOT NULL,
    PRIMARY KEY CLUSTERED ([idVacunacion] ASC)
);


GO

CREATE TABLE [dbo].[Producto] (
    [Nombre]  VARCHAR (20) NOT NULL,
    [Detalle] VARCHAR (40) NULL,
    PRIMARY KEY CLUSTERED ([Nombre] ASC)
);


GO

CREATE TABLE [dbo].[estado_parto] (
    [id_estado]    TINYINT  NOT NULL,
    [estado_parto] CHAR (1) NOT NULL,
    CONSTRAINT [PK_estado_parto_id_estado] PRIMARY KEY CLUSTERED ([id_estado] ASC),
    CONSTRAINT [UNK_estado_parto_estado_parto] UNIQUE NONCLUSTERED ([estado_parto] ASC)
);


GO

CREATE TABLE [dbo].[Bovino] (
    [id_Bovino]       INT          NOT NULL,
    [Edad]            INT          NULL,
    [idSexo]          TINYINT      NULL,
    [FechaSalida]     DATE         NULL,
    [FechaIngreso]    DATE         NULL,
    [FechaNacimiento] DATE         NULL,
    [Nombre]          VARCHAR (20) NULL,
    [Raza]            TINYINT      NULL,
    [Color]           TINYINT      NULL,
    [idEmpresa]       TINYINT      NOT NULL,
    CONSTRAINT [PK_Bovino_ID] PRIMARY KEY CLUSTERED ([id_Bovino] ASC),
    CONSTRAINT [FK_Bovino_Color] FOREIGN KEY ([Color]) REFERENCES [dbo].[Color] ([Color]),
    CONSTRAINT [FK_Bovino_idEmpresa] FOREIGN KEY ([idEmpresa]) REFERENCES [dbo].[empresa] ([idEmpresa]),
    CONSTRAINT [FK_Bovino_idSexo] FOREIGN KEY ([idSexo]) REFERENCES [dbo].[sexo] ([id_sexo]),
    CONSTRAINT [FK_Bovino_Raza] FOREIGN KEY ([Raza]) REFERENCES [dbo].[Raza] ([Raza])
);


GO

CREATE TABLE [dbo].[Enfermedades_Producto] (
    [Fecha]  DATE         NOT NULL,
    [Nombre] VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([Fecha] ASC),
    CONSTRAINT [FK_Enfermedades_Producrto_Fecha] FOREIGN KEY ([Fecha]) REFERENCES [dbo].[Enfermedades] ([Fecha]),
    CONSTRAINT [FK_Enfermedades_Producrto_Nombre] FOREIGN KEY ([Nombre]) REFERENCES [dbo].[Producto] ([Nombre])
);


GO

CREATE TABLE [dbo].[tipo_fecu] (
    [tipo_fecu]   TINYINT      NOT NULL,
    [fecundacion] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_tipo_fecu_tipo] PRIMARY KEY CLUSTERED ([tipo_fecu] ASC),
    CONSTRAINT [UNK_tipo_fecu_fecundacion] UNIQUE NONCLUSTERED ([fecundacion] ASC)
);


GO

CREATE TABLE [dbo].[partos_bovinos] (
    [id_partos] INT NOT NULL,
    [id_Bovino] INT NOT NULL,
    CONSTRAINT [PK_partos_bovinos_id_partos_id_bovino] PRIMARY KEY CLUSTERED ([id_partos] ASC, [id_Bovino] ASC),
    CONSTRAINT [FK_partos_bovinos_id_Bovino] FOREIGN KEY ([id_Bovino]) REFERENCES [dbo].[Bovino] ([id_Bovino]),
    CONSTRAINT [FK_partos_bovinos_id_partos] FOREIGN KEY ([id_partos]) REFERENCES [dbo].[partos] ([id_partos])
);


GO

CREATE TABLE [dbo].[Nombre_Sintomas] (
    [Nombre_Sintoma]  TINYINT  NOT NULL,
    [Especializacion] CHAR (2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Nombre_Sintoma] ASC)
);


GO

CREATE TABLE [dbo].[Enfermedades] (
    [Fecha]       DATE         NOT NULL,
    [Diagnostico] VARCHAR (30) NULL,
    [Comentario]  VARCHAR (40) NULL,
    PRIMARY KEY CLUSTERED ([Fecha] ASC)
);


GO

CREATE TABLE [dbo].[tipo_parto] (
    [id_parto]   TINYINT  NOT NULL,
    [tipo_parto] CHAR (1) NOT NULL,
    CONSTRAINT [PK_tipo_parto_id_parto] PRIMARY KEY CLUSTERED ([id_parto] ASC),
    CONSTRAINT [UNK_tipo_parto_id_parto] UNIQUE NONCLUSTERED ([tipo_parto] ASC)
);


GO

CREATE TABLE [dbo].[preñez] (
    [id_preñez]           INT     NOT NULL,
    [id_bovino]           INT     NULL,
    [dias_preñez]         INT     NOT NULL,
    [posible_fecha_parto] DATE    NULL,
    [tipo_fecu]           TINYINT NULL,
    CONSTRAINT [PK_preñez_id_preñez] PRIMARY KEY CLUSTERED ([id_preñez] ASC),
    CONSTRAINT [FK_preñez_id_bovino] FOREIGN KEY ([id_bovino]) REFERENCES [dbo].[Bovino] ([id_Bovino]),
    CONSTRAINT [FK_preñez_id_preñez] FOREIGN KEY ([id_preñez]) REFERENCES [dbo].[reproduccion] ([id_reproduccion]),
    CONSTRAINT [FK_preñez_tipo_fecu] FOREIGN KEY ([tipo_fecu]) REFERENCES [dbo].[tipo_fecu] ([tipo_fecu])
);


GO

CREATE TABLE [dbo].[Producto_Vacunacion] (
    [idVacunacion] TINYINT      NOT NULL,
    [Nombre]       VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([idVacunacion] ASC),
    CONSTRAINT [FK_Producto_Vacunacion_idVacunacion] FOREIGN KEY ([idVacunacion]) REFERENCES [dbo].[Vacunacion] ([idVacunacion]),
    CONSTRAINT [FK_Producto_Vacunacion_Nombre] FOREIGN KEY ([Nombre]) REFERENCES [dbo].[Producto] ([Nombre])
);


GO

CREATE TABLE [dbo].[empresa] (
    [idEmpresa] TINYINT      NOT NULL,
    [nombre]    VARCHAR (20) NOT NULL,
    [ubicacion] VARCHAR (40) NOT NULL,
    CONSTRAINT [PK_empresa_idEmpresa] PRIMARY KEY CLUSTERED ([idEmpresa] ASC)
);


GO

CREATE TABLE [dbo].[Color] (
    [Color]       TINYINT   NOT NULL,
    [NombreColor] CHAR (15) NOT NULL,
    PRIMARY KEY CLUSTERED ([Color] ASC)
);


GO

CREATE TABLE [dbo].[reproduccion_bovinos] (
    [id_reproduccion] INT NOT NULL,
    [id_Bovino]       INT NOT NULL,
    CONSTRAINT [PK_reproduccion_bovinos_id_reproduccion_id_bovino] PRIMARY KEY CLUSTERED ([id_reproduccion] ASC, [id_Bovino] ASC),
    CONSTRAINT [FK_reproduccion_bovinos_id_Bovino] FOREIGN KEY ([id_Bovino]) REFERENCES [dbo].[Bovino] ([id_Bovino]),
    CONSTRAINT [FK_reproduccion_bovinos_id_reproduccion] FOREIGN KEY ([id_reproduccion]) REFERENCES [dbo].[reproduccion] ([id_reproduccion])
);


GO

CREATE TABLE [dbo].[Raza] (
    [Raza]       TINYINT      NOT NULL,
    [NombreRaza] VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([Raza] ASC)
);


GO

CREATE TABLE [dbo].[medidas_corporales] (
    [fecha]     DATE         NOT NULL,
    [condicion] VARCHAR (10) NULL,
    [peso]      INT          NULL,
    CONSTRAINT [PK_medidas_corporales_fecha] PRIMARY KEY CLUSTERED ([fecha] ASC)
);


GO

CREATE TABLE [dbo].[Sintomas] (
    [Fecha]          DATE    NOT NULL,
    [Nombre_Sintoma] TINYINT NOT NULL,
    PRIMARY KEY CLUSTERED ([Fecha] ASC),
    CONSTRAINT [FK_Sintomas_Nombre_Fecha] FOREIGN KEY ([Fecha]) REFERENCES [dbo].[Enfermedades] ([Fecha]),
    CONSTRAINT [FK_Sintomas_Nombre_Sintoma] FOREIGN KEY ([Nombre_Sintoma]) REFERENCES [dbo].[Nombre_Sintomas] ([Nombre_Sintoma])
);


GO

CREATE TABLE [dbo].[Enfermedades_Bovinos] (
    [idBovino] INT  NOT NULL,
    [Fecha]    DATE NOT NULL,
    CONSTRAINT [FK_Enfermedades_Bovino_Fecha] FOREIGN KEY ([Fecha]) REFERENCES [dbo].[Enfermedades] ([Fecha]),
    CONSTRAINT [FK_Enfermedades_Bovino_idBovino] FOREIGN KEY ([idBovino]) REFERENCES [dbo].[Bovino] ([id_Bovino])
);


GO

CREATE TABLE [dbo].[servicios] (
    [id_servicio]     INT          NOT NULL,
    [comentario]      VARCHAR (40) NULL,
    [numero_servicio] INT          NULL,
    [id_preñez]       INT          NULL,
    CONSTRAINT [PK_servicios_id_servicio] PRIMARY KEY CLUSTERED ([id_servicio] ASC),
    CONSTRAINT [FK_servicios_id_preñez] FOREIGN KEY ([id_preñez]) REFERENCES [dbo].[preñez] ([id_preñez]),
    CONSTRAINT [FK_servicios_id_servicio] FOREIGN KEY ([id_servicio]) REFERENCES [dbo].[reproduccion] ([id_reproduccion])
);


GO

CREATE TABLE [dbo].[Vacunacion_Bovino] (
    [idBovino]     INT     NOT NULL,
    [idVacunacion] TINYINT NOT NULL,
    CONSTRAINT [FK_Vacunacion_Bovino_idBovino] FOREIGN KEY ([idBovino]) REFERENCES [dbo].[Bovino] ([id_Bovino]),
    CONSTRAINT [FK_Vacunacion_Bovino_idVacunacion] FOREIGN KEY ([idVacunacion]) REFERENCES [dbo].[Vacunacion] ([idVacunacion])
);


GO

CREATE TABLE [dbo].[medidas_bovinos] (
    [fecha]     DATE NOT NULL,
    [id_bovino] INT  NOT NULL,
    CONSTRAINT [PK_medidas_bovinos_fecha_id_bovino] PRIMARY KEY CLUSTERED ([fecha] ASC, [id_bovino] ASC),
    CONSTRAINT [FK_medidas_bovinos_fecha] FOREIGN KEY ([fecha]) REFERENCES [dbo].[medidas_corporales] ([fecha]),
    CONSTRAINT [FK_medidas_bovinos_id_bovino] FOREIGN KEY ([id_bovino]) REFERENCES [dbo].[Bovino] ([id_Bovino])
);


GO

CREATE TABLE [dbo].[partos] (
    [id_partos]  INT          NOT NULL,
    [id_sexo]    TINYINT      NULL,
    [comentario] VARCHAR (40) NULL,
    [id_parto]   TINYINT      NULL,
    [id_estado]  TINYINT      NULL,
    CONSTRAINT [PK_partos_id_partos] PRIMARY KEY CLUSTERED ([id_partos] ASC),
    CONSTRAINT [FK_partos_id_estado] FOREIGN KEY ([id_estado]) REFERENCES [dbo].[estado_parto] ([id_estado]),
    CONSTRAINT [FK_partos_id_parto] FOREIGN KEY ([id_parto]) REFERENCES [dbo].[tipo_parto] ([id_parto]),
    CONSTRAINT [FK_partos_id_partos] FOREIGN KEY ([id_partos]) REFERENCES [dbo].[reproduccion] ([id_reproduccion]),
    CONSTRAINT [FK_partos_id_sexo] FOREIGN KEY ([id_sexo]) REFERENCES [dbo].[sexo] ([id_sexo])
);


GO

CREATE TABLE [dbo].[sexo] (
    [id_sexo]     TINYINT  NOT NULL,
    [sexo_animal] CHAR (1) NOT NULL,
    CONSTRAINT [PK_sexo_id_sexo] PRIMARY KEY CLUSTERED ([id_sexo] ASC),
    CONSTRAINT [UNK_sexo_sexo_animal] UNIQUE NONCLUSTERED ([sexo_animal] ASC)
);


GO

CREATE TABLE [dbo].[produccion] (
    [fecha]    DATE NOT NULL,
    [total]    INT  NOT NULL,
    [idBovino] INT  NOT NULL,
    CONSTRAINT [PK_produccion_fecha] PRIMARY KEY CLUSTERED ([fecha] ASC),
    CONSTRAINT [FK_produccion_idBovino] FOREIGN KEY ([idBovino]) REFERENCES [dbo].[Bovino] ([id_Bovino])
);


GO

CREATE TABLE [dbo].[reproduccion] (
    [id_reproduccion] INT      NOT NULL,
    [fecha_registro]  DATETIME NOT NULL,
    CONSTRAINT [PK_reproduccion_id_reproduccion] PRIMARY KEY CLUSTERED ([id_reproduccion] ASC),
    CONSTRAINT [UNK_reproduccion_fecha_registro] UNIQUE NONCLUSTERED ([fecha_registro] ASC)
);


GO

CREATE PROCEDURE upd_usuario
	@nombreUsuario varchar(10),
	@contraseña varchar(8),
	@idEmpresa TINYINT
	
AS
	update usuario
	set		nombreUsuario=@nombreUsuario,
			contraseña=@contraseña,
			idEmpresa=@idEmpresa
	where nombreUsuario=@nombreUsuario

GO

CREATE PROCEDURE upd_empresa
	@idEmpresa TINYINT,
	@nombre varchar(20),
	@ubicacion varchar(40)
	
AS
	update empresa
	set		idEmpresa=@idEmpresa,
			nombre=@nombre,
			ubicacion=@ubicacion
	where idEmpresa=@idEmpresa

GO

CREATE PROCEDURE ins_bovino
	@id_Bovino INT,
	@Nombre varchar(20),
	@idEmpresa TINYINT,
	@Color TINYINT,
	@idSexo TINYINT,
	@Raza TINYINT,
	@FechaNacimiento DATE,
	@FechaIngreso DATE

AS
INSERT INTO Bovino
           (id_Bovino,Nombre,Color,idSexo,Raza,FechaNacimiento,Edad,FechaIngreso,idEmpresa)
     VALUES
           (@id_Bovino,@Nombre,@Color,@idSexo,@Raza,@FechaNacimiento,DATEDIFF(YEAR,@FechaNacimiento,GETDATE()),GETDATE(),@idEmpresa)

GO

CREATE   PROCEDURE sel_usuario
	@idEmpresa TINYINT,
	@nombreUsuario varchar(10),
	@contraseña varchar(8)
AS
	select * from usuario
	where 
		(@idEmpresa IS NULL or idEmpresa=@idEmpresa) and
		(@nombreUsuario IS NULL or nombreUsuario=@nombreUsuario) and
		(@contraseña IS NULL or contraseña=@contraseña)

GO

CREATE PROCEDURE upd_bovino
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

GO

CREATE   PROCEDURE sel_empresa 
	@idEmpresa TINYINT,
	@nombre varchar(20),
	@ubicacion varchar(40)
AS
	select * from empresa
	where 
		(@idEmpresa IS NULL or idEmpresa=@idEmpresa) and
		(@nombre IS NULL or nombre=@nombre) and
		(@ubicacion IS NULL or ubicacion=@ubicacion)

GO
CREATE PROCEDURE ins_empresa_usuario
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

GO


CREATE DATABASE CLINICA_NEWAGE
go
use CLINICA_NEWAGE
set dateformat DMY
go
-- Tabla Paciente
CREATE TABLE Paciente (
    PacienteID INT IDENTITY(1,1),
    Nombre NVARCHAR(100),
    FechaNacimiento DATE,
    Genero CHAR(1),
    ObraSocial NVARCHAR(100),
    Email NVARCHAR(100),
    Telefono NVARCHAR(30), -- unico?

	CONSTRAINT PK_Paciente_PacienteID PRIMARY KEY(PacienteID),
	CONSTRAINT CK_Paciente_Genero CHECK (Genero IN ('M', 'F')),
	CONSTRAINT UQ_Paciente_Email UNIQUE (Email), --Con UNIQUE inferimos que la columna es a su vez un indice!
);
go
-- Tabla Profesional
CREATE TABLE Profesional (
    ProfesionalID INT IDENTITY(1,1), --Primary key
    Nombre NVARCHAR(100),
    Especialidad NVARCHAR(100),--Index
    Matricula NVARCHAR(20), --AK unica, Index
    Honorarios DECIMAL(10,2),
    Activo BIT,

	CONSTRAINT PK_Profesional_ProfesionalID PRIMARY KEY(ProfesionalID),
);
go
-- Tabla Turno
CREATE TABLE Turno (
    TurnoID INT IDENTITY(1,1) PRIMARY KEY, --Primary key
    FechaHora DATETIME, --index???
    PacienteID INT FOREIGN KEY REFERENCES Paciente(PacienteID), --FK, Index??
    ProfesionalID INT FOREIGN KEY REFERENCES Profesional(ProfesionalID), --FK, Index
    Estado NVARCHAR(20) CHECK (Estado IN ('Agendado', 'Cancelado', 'Realizado', 'Disponible')), --Ckeck
	Honorarios DECIMAL(10,2)
);
Go
-- Tabla Consulta
CREATE TABLE Consulta (
    ConsultaID INT IDENTITY(1,1) PRIMARY KEY, --Primary key
    TurnoID INT FOREIGN KEY REFERENCES Turno(TurnoID), --FK
    Diagnostico NVARCHAR(255),
    Recomendaciones NVARCHAR(255),
    Receta TEXT,
    Fecha DATE --Index
);
Go
-- Tabla Producto
CREATE TABLE Producto (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY, --PK
    Nombre NVARCHAR(100),
    Tipo NVARCHAR(50) CHECK (Tipo IN ('Farmacéutico', 'Natural', 'Suplemento')), --Index
    Stock INT,
    Precio DECIMAL(10,2),--Index???
    Activo BIT
);
Go
-- Tabla Venta
CREATE TABLE Venta (
    VentaID INT IDENTITY(1,1) PRIMARY KEY, --PK
    FechaVenta DATE, --Index
    PacienteID INT FOREIGN KEY REFERENCES Paciente(PacienteID), --FK, Index
    Total DECIMAL(10,2) --index???
);
go
-- Tabla DetalleVenta
CREATE TABLE DetalleVenta (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY, --PK
    VentaID INT FOREIGN KEY REFERENCES Venta(VentaID), --FK
    ProductoID INT FOREIGN KEY REFERENCES Producto(ProductoID), --FK
    Cantidad INT,
    PrecioUnitario DECIMAL(10,2)
);
Go
-- Tabla TerapiasAlternativas
CREATE TABLE TerapiasAlternativas (
    TerapiaID INT IDENTITY(1,1) PRIMARY KEY, --PK
    TipoTerapia NVARCHAR(50), --Index
    Nombre NVARCHAR(100),
    Descripcion TEXT,
    Costo DECIMAL(10,2)
);
go
-- Tabla TerapiasAlternasAplicadas
CREATE TABLE TerapiasAlternasAplicadas (
    TerapiaAplicadaID INT IDENTITY(1,1) PRIMARY KEY, --PK
    TerapiaID INT FOREIGN KEY REFERENCES TerapiasAlternativas(TerapiaID), --FK, Index
    PacienteID INT FOREIGN KEY REFERENCES Paciente(PacienteID), --FK, Index
    ProfesionalID INT FOREIGN KEY REFERENCES Profesional(ProfesionalID), --FK, Index
    FechaInicio DATE, --Index
    Frecuencia NVARCHAR(30),
    DescripcionTratamientoEspecifico TEXT,
    Costo DECIMAL(10,2)
);
go
CREATE TABLE AuditoriaTurnosCancelados (
    AuditoriaID INT IDENTITY(1,1) PRIMARY KEY, --PK
    TurnoID INT NOT NULL, --FK
    PacienteID INT, --FK, Index
    ProfesionalID INT, --FK, Index
    FechaIntento DATETIME DEFAULT GETDATE(), --Index??
    UsuarioSistema NVARCHAR(100) DEFAULT SYSTEM_USER, --Index??
    Motivo NVARCHAR(255)
);
Go



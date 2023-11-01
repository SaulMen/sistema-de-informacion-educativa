CREATE SCHEMA IF NOT EXISTS proyecto2;

-- TABLA CARRERA
CREATE TABLE IF NOT EXISTS  proyecto2.carrera (
	id_carrera INTEGER NOT NULL AUTO_INCREMENT,
    nombre_carrera VARCHAR (50),
    PRIMARY KEY (id_carrera)
);

-- TABLA ESTUDIANTE
CREATE TABLE IF NOT EXISTS  proyecto2.estudiante (
	carnet INTEGER NOT NULL,
    nombre VARCHAR (25) NOT NULL,
    apellido VARCHAR (25) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR (50) NOT NULL,
    telefono INTEGER NOT NULL,
    direccion VARCHAR (100) NOT NULL,
    dpi BIGINT NOT NULL,
	id_carrera INTEGER NOT NULL,
    PRIMARY KEY (carnet),
    FOREIGN KEY (id_carrera) REFERENCES proyecto2.carrera (id_carrera) 
);

-- TABLA DOCENTE
CREATE TABLE IF NOT EXISTS  proyecto2.docente (
	id_docente INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR (25) NOT NULL,
    apellido VARCHAR (25) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR (50) NOT NULL,
    telefono INTEGER NOT NULL,
    direccion VARCHAR (100) NOT NULL,
    dpi BIGINT NOT NULL,
    siif INTEGER NOT NULL,
    PRIMARY KEY (id_docente) -- Tal vez dejar solo el SIIF como PK
);

-- TABLA CURSO
CREATE TABLE IF NOT EXISTS  proyecto2.curso (
	codigo INTEGER NOT NULL,
    nombre VARCHAR (50) NOT NULL,
    creditos_necesarios INTEGER NOT NULL,
    creditos_dados INTEGER NOT NULL,
    obligatorio BOOLEAN NOT NULL,
	id_carrera INTEGER NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (id_carrera) REFERENCES proyecto2.carrera(id_carrera)
);


-- TABLA HABILITAR_CURSO
CREATE TABLE IF NOT EXISTS  proyecto2.habilitar_curso (
	id_habilitar INTEGER NOT NULL AUTO_INCREMENT,
	ciclo VARCHAR (2)  NOT NULL,
    cupo_maximo INTEGER NOT NULL,
    seccion CHAR (1) NOT NULL,
    id_docente INTEGER NOT NULL,
    anio INTEGER NOT NULL,
    total_asignados INTEGER NOT NULL,
    codigo INTEGER NOT NULL,
    PRIMARY KEY (id_habilitar),
    FOREIGN KEY (id_docente) REFERENCES proyecto2.docente (id_docente),
    FOREIGN KEY (codigo) REFERENCES proyecto2.curso (codigo)
);

-- TABLA ASIGNAR
CREATE TABLE IF NOT EXISTS  proyecto2.asignar (
	id_asignar INTEGER NOT NULL AUTO_INCREMENT,
	ciclo VARCHAR (2)  NOT NULL,
    seccion CHAR (1) NOT NULL,
    carnet INTEGER NOT NULL,
    codigo INTEGER NOT NULL,
    PRIMARY KEY (id_asignar),
    FOREIGN KEY (carnet) REFERENCES proyecto2.estudiante(carnet),
    FOREIGN KEY (codigo) REFERENCES proyecto2.curso (codigo)
);

-- TABLA DESASIGNAR_CURSO
CREATE TABLE IF NOT EXISTS  proyecto2.desasignar_curso (
	id_desasignar INTEGER NOT NULL AUTO_INCREMENT,
	ciclo VARCHAR (2)  NOT NULL,
    seccion CHAR (1) NOT NULL,
    carnet INTEGER NOT NULL,
    codigo INTEGER NOT NULL,
    PRIMARY KEY (id_desasignar),
    FOREIGN KEY (carnet) REFERENCES proyecto2.estudiante (carnet),
    FOREIGN KEY (codigo) REFERENCES proyecto2.curso(codigo)
);

-- TABLA CREDITO
CREATE TABLE IF NOT EXISTS  proyecto2.credito (
	id_credito INTEGER NOT NULL AUTO_INCREMENT,
	creditos INTEGER NOT NULL,
    codigo INTEGER NOT NULL,
    PRIMARY KEY (id_credito),
    FOREIGN KEY (codigo) REFERENCES proyecto2.curso (codigo)
);

-- TABLA NOTA
CREATE TABLE IF NOT EXISTS  proyecto2.nota (
	id_nota INTEGER NOT NULL AUTO_INCREMENT,
	ciclo VARCHAR (2)  NOT NULL,
    seccion CHAR (1) NOT NULL,
    nota INTEGER NOT NULL,
    carnet INTEGER NOT NULL,
    codigo INTEGER NOT NULL,
    anio INTEGER NOT NULL,
    PRIMARY KEY (id_nota),
    FOREIGN KEY (carnet) REFERENCES proyecto2.estudiante(carnet),
    FOREIGN KEY (codigo) REFERENCES proyecto2.curso (codigo)
);

-- TABLA HORARIO
CREATE TABLE IF NOT EXISTS  proyecto2.horario (
	id_horario INTEGER NOT NULL AUTO_INCREMENT,
	dia INTEGER  NOT NULL,
    horario VARCHAR (15) NOT NULL,
	id_habilitar INTEGER  NOT NULL,
    PRIMARY KEY (id_horario),
    FOREIGN KEY (id_habilitar) REFERENCES proyecto2.habilitar_curso (id_habilitar)
);

-- TABLA ACTA
CREATE TABLE IF NOT EXISTS  proyecto2.acta (
	id_acta INTEGER NOT NULL AUTO_INCREMENT,
	ciclo VARCHAR (2)  NOT NULL,
    seccion CHAR (1) NOT NULL,
	codigo INTEGER  NOT NULL,
    fecha DATETIME NOT NULL,
    PRIMARY KEY (id_acta),
    FOREIGN KEY (codigo) REFERENCES proyecto2.curso (codigo)
);
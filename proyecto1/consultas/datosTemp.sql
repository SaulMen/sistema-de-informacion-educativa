-- Creación de tablas temporales
CREATE TEMPORARY TABLE prueba.cargo_temporal (
	id_cargo INTEGER NOT NULL,
	cargo VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE prueba.ciudadano_temporal (
	dpi VARCHAR(13) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	edad INTEGER NOT NULL,
	genero VARCHAR(10) NOT NULL
);

CREATE TEMPORARY TABLE IF NOT EXISTS prueba.departamento_temporal (
	id_departamento INTEGER NOT NULL,
	nombre VARCHAR(25) NOT NULL
	);

CREATE TEMPORARY TABLE IF NOT EXISTS prueba.partido_temporal (
	id_partido INTEGER NOT NULL,
	nombre_partido VARCHAR(50) NOT NULL,
	siglas VARCHAR(25) NOT NULL,
	fundacion DATE NOT NULL
	);

CREATE TEMPORARY TABLE IF NOT EXISTS prueba.candidato_temporal (
	id_candidato INTEGER NOT NULL,
	nombre_candidato VARCHAR(100) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	id_partido INTEGER NOT NULL,
	id_cargo INTEGER NOT NULL 
	);

CREATE TEMPORARY TABLE IF NOT EXISTS prueba.mesa_temporal (
	id_mesa INTEGER NOT NULL,
	id_departamento INTEGER NOT NULL
	);

CREATE TEMPORARY TABLE IF NOT EXISTS prueba.voto_temporal (
	id_voto INTEGER NOT NULL,
	id_candidato INTEGER NOT NULL,
	fecha_hora DATETIME NOT NULL,
	dpi_ciudadano VARCHAR(13) NOT NULL,
	id_mesa INTEGER NOT NULL
	);
    
-- Carga de datos CSV a tablas temporales y de tablas temporales al modelo
-- Cargo
INSERT INTO prueba.cargo_temporal (id_cargo, cargo) VALUES (?, ?);
INSERT INTO prueba.cargo (id_cargo, cargo) SELECT id_cargo, cargo FROM prueba.cargo_temporal;

-- Ciudadano 
INSERT INTO prueba.ciudadano_temporal (dpi, nombre, apellido, direccion, telefono, edad, genero) VALUES (?, ?, ?, ?, ?, ?, ?);
INSERT INTO prueba.ciudadano (dpi, nombre, apellido, direccion, telefono, edad, genero) 
        SELECT dpi, nombre, apellido, direccion, telefono, edad, genero FROM prueba.ciudadano_temporal;

-- Departamento
INSERT INTO prueba.departamento_temporal (id_departamento, nombre) VALUES (?, ?);
INSERT INTO prueba.departamento (id_departamento, nombre) SELECT id_departamento, nombre FROM prueba.departamento_temporal;

-- Partido
INSERT INTO prueba.partido_temporal (id_partido, nombre_partido, siglas, fundacion) VALUES (?, ?, ?, ?);
INSERT INTO prueba.partido (id_partido, nombre_partido, siglas, fundacion) 
		SELECT id_partido, nombre_partido, siglas, fundacion FROM prueba.partido_temporal;

-- Candidato
INSERT INTO prueba.candidato_temporal (id_candidato, nombre_candidato, fecha_nacimiento, id_partido, id_cargo) VALUES (?, ?, ?, ?, ?);
INSERT INTO prueba.candidato (id_candidato, nombre_candidato, fecha_nacimiento, id_partido, id_cargo) 
        SELECT id_candidato, nombre_candidato, fecha_nacimiento, id_partido, id_cargo FROM prueba.candidato_temporal;

-- Mesa
INSERT INTO prueba.mesa_temporal (id_mesa, id_departamento) VALUES (?, ?);
INSERT INTO prueba.mesa (id_mesa, id_departamento) SELECT id_mesa, id_departamento FROM prueba.mesa_temporal;

-- Voto
INSERT IGNORE INTO prueba.voto_temporal (id_voto, id_candidato, fecha_hora, dpi_ciudadano, id_mesa) VALUES (?, ?, ?, ?, ?);
INSERT IGNORE INTO prueba.voto (id_voto, fecha_hora, dpi_ciudadano, id_mesa)
		SELECT DISTINCT id_voto, fecha_hora, dpi_ciudadano, id_mesa FROM prueba.voto_temporal;



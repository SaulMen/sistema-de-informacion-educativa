
CREATE SCHEMA IF NOT EXISTS prueba;

CREATE TABLE IF NOT EXISTS prueba.ciudadano (
  dpi VARCHAR(13) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  edad INTEGER NOT NULL,
  genero VARCHAR(10) NOT NULL,
  PRIMARY KEY (dpi));

-- TABLA DEPARTAMENTO
CREATE TABLE IF NOT EXISTS prueba.departamento (
  id_departamento INTEGER NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(25) NOT NULL,
  PRIMARY KEY (id_departamento)
  );

-- TABLA MESA
CREATE TABLE IF NOT EXISTS prueba.mesa (
  id_mesa INTEGER NOT NULL AUTO_INCREMENT,
  id_departamento INTEGER NOT NULL,
  PRIMARY KEY (id_mesa),
  FOREIGN KEY (id_departamento) REFERENCES prueba.departamento(id_departamento)
  );

-- TABLA VOTO
CREATE TABLE IF NOT EXISTS prueba.voto (
  id_voto INTEGER NOT NULL AUTO_INCREMENT,
  fecha_hora DATETIME NOT NULL,
  dpi_ciudadano VARCHAR(13) NOT NULL,
  id_mesa INTEGER NOT NULL,
  PRIMARY KEY (id_voto),
  FOREIGN KEY (dpi_ciudadano) REFERENCES prueba.ciudadano(dpi),
  FOREIGN KEY (id_mesa) REFERENCES prueba.mesa(id_mesa)
  );

-- TABLA CARGO
CREATE TABLE IF NOT EXISTS prueba.cargo (
  id_cargo INTEGER NOT NULL,
  cargo VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_cargo)
);
  
  -- TABLA PARTIDO
CREATE TABLE IF NOT EXISTS prueba.partido (
  id_partido INTEGER NOT NULL AUTO_INCREMENT,
  nombre_partido VARCHAR(50) NOT NULL,
  siglas VARCHAR(25) NOT NULL,
  fundacion DATE NOT NULL,
  PRIMARY KEY (id_partido)
  );

-- TABLA CANDIDATO
CREATE TABLE IF NOT EXISTS prueba.candidato (
  id_candidato INTEGER NOT NULL AUTO_INCREMENT,
  nombre_candidato VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  id_partido INTEGER NOT NULL,
  id_cargo INTEGER NOT NULL,
  PRIMARY KEY (id_candidato),
  FOREIGN KEY (id_partido) REFERENCES prueba.partido(id_partido),
  FOREIGN KEY (id_cargo) REFERENCES prueba.cargo(id_cargo) 
  );

-- TABLA DETALLE VOTO
CREATE TABLE IF NOT EXISTS prueba.detalle_voto (
  id_detalle INTEGER NOT NULL AUTO_INCREMENT,
  id_voto INTEGER NOT NULL,
  id_candidato INTEGER NOT NULL,
  PRIMARY KEY (id_detalle),
  FOREIGN KEY (id_candidato) REFERENCES prueba.candidato(id_candidato),
  FOREIGN KEY (id_voto) REFERENCES prueba.voto(id_voto)
  );
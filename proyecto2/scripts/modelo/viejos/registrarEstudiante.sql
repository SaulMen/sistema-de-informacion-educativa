USE proyecto2;
DELIMITER $$
CREATE FUNCTION registrarEstudiante (
	carnet BIGINT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR (50),
    telefono INTEGER,
    direccion VARCHAR(100),
    dpi BIGINT,
    id_carrera INTEGER
)
RETURNS INTEGER DETERMINISTIC
BEGIN
	
    IF (correo REGEXP '^[a-zA-Z0-9]+@[a-zA-Z]+(\.[a-zA-Z]+)+$' AND telefono REGEXP '^[0-9]{8}$') THEN 
        INSERT INTO proyecto2.estudiante (carnet, nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera) 
        VALUES (carnet, nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera);
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN -1;
    END IF;
END $$
DELIMITER ;
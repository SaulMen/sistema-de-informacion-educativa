USE proyecto2;
DELIMITER $$
CREATE FUNCTION registrarDocente (
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR (50),
    telefono INTEGER,
    direccion VARCHAR(100),
    dpi BIGINT,
    siif INTEGER
)
RETURNS INTEGER DETERMINISTIC

BEGIN
	-- DECLARE docente_id INTEGER;
    -- SELECT id_docente INTO docente_id FROM proyecto2.docente WHERE siif = siif LIMIT 1;
    -- Y agregarlo al if
    IF (correo REGEXP '^[a-zA-Z0-9]+@[a-zA-Z]+(\.[a-zA-Z]+)+$' AND telefono REGEXP '^[0-9]{8}$') THEN 
        INSERT INTO proyecto2.docente (nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, siif) 
        VALUES (nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, siif);
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN -1;
    END IF;
END $$
DELIMITER ;
USE proyecto2;
DELIMITER $$
CREATE PROCEDURE registrarDocente (
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR (50),
    telefono INTEGER,
    direccion VARCHAR(100),
    dpi BIGINT,
    siif INTEGER
)

BEGIN
	DECLARE docente_existente INTEGER;
    -- Verificar si el docente ya existe por su número de SIIF
    SELECT COUNT(*) INTO docente_existente FROM proyecto2.docente WHERE siif = proyecto2.docente.siif;
	-- Y agregarlo al if
    IF ( docente_existente = 0 AND (correo REGEXP '^[a-zA-Z0-9]+@[a-zA-Z]+(\.[a-zA-Z]+)+$' AND telefono REGEXP '^[0-9]{8}$')) THEN 
        INSERT INTO proyecto2.docente (nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, siif) 
        VALUES (nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, siif);
    ELSE
        SELECT docente_existente AS Resultado, siif AS siif, correo AS correo, telefono AS telefono;
    END IF;
END $$
DELIMITER ;
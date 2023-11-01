USE proyecto2;
DELIMITER $$
CREATE FUNCTION crearCurso (
    codigo INTEGER,
    nombre VARCHAR(50),
    creditos_necesarios INTEGER,
    creditos_dados INTEGER,
    id_carrera INTEGER,
    obligatorio BOOLEAN
)
RETURNS INTEGER DETERMINISTIC

BEGIN
    IF (creditos_necesarios >=0 AND creditos_dados >0) THEN 
        INSERT INTO proyecto2.curso (codigo, nombre, creditos_necesarios, creditos_dados, obligatorio,id_carrera) 
        VALUES (codigo, nombre, creditos_necesarios, creditos_dados, obligatorio,id_carrera);
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN -1;
    END IF;
END $$
DELIMITER ;

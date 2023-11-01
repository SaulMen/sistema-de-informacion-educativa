USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarPensum (
	carrera INTEGER
)

BEGIN
	DECLARE carrera_valida INTEGER;
    SELECT COUNT(*) INTO carrera_valida FROM proyecto2.carrera AS c
    WHERE carrera = c.id_carrera;
    
    IF (carrera_valida = 1) THEN 
        SELECT codigo,nombre,obligatorio,creditos_dados FROM proyecto2.curso as c
        WHERE carrera = c.id_carrera;
    ELSE
        SELECT "No se encontró la carrera" AS resultado;
    END IF;
END $$
DELIMITER ;
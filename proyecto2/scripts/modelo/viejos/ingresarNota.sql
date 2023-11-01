USE proyecto2;
DELIMITER $$
CREATE FUNCTION ingresarNota (
    codigo INTEGER,
    ciclo VARCHAR (2),
    seccion CHAR (1),
    carnet BIGINT,
    nota DOUBLE
)
RETURNS INTEGER DETERMINISTIC

BEGIN
	-- *Es el código como tal del curso (no	del habilitado) Se debe hacer match con la relación
	-- de curso habilitado por medio del año actual, ciclo y sección. 
	IF (nota >0) THEN 
		INSERT INTO proyecto2.nota (codigo, ciclo, seccion, carnet, nota, anio) 
		VALUES (codigo, ciclo, seccion, carnet, CAST(nota AS SIGNED), YEAR(NOW()));
		RETURN LAST_INSERT_ID();
	ELSE
        RETURN -1;
    END IF;
END $$
DELIMITER ;
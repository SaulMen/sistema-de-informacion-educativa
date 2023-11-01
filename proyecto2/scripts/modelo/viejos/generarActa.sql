USE proyecto2;
DELIMITER $$
CREATE FUNCTION generarActa (
    codigo INTEGER,
    ciclo VARCHAR (2),
    seccion CHAR (1)
)
RETURNS INTEGER DETERMINISTIC

BEGIN
	-- *Es el código como tal del curso (no	del habilitado) Se debe hacer match con la relación
	-- de curso habilitado por medio del año actual, ciclo y sección. 
	INSERT INTO proyecto2.acta (codigo, ciclo, seccion, fecha) 
	VALUES (codigo, ciclo, seccion, now());
	RETURN LAST_INSERT_ID();
END $$
DELIMITER ;
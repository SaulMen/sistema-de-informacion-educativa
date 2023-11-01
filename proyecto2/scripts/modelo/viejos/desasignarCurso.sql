USE proyecto2;
DELIMITER $$
CREATE FUNCTION desasignarCurso (
    codigo INTEGER,
    ciclo VARCHAR (2),
    seccion CHAR (1),
    carnet BIGINT
)
RETURNS INTEGER DETERMINISTIC

BEGIN
	-- *Es el código como tal del curso (no	del habilitado) Se debe hacer match con la relación
	-- de curso habilitado por medio del año actual, ciclo y sección. 
	INSERT INTO proyecto2.desasignar_curso (codigo, ciclo, seccion, carnet) VALUES (codigo, ciclo, seccion, carnet);
	RETURN LAST_INSERT_ID();
END $$
DELIMITER ;
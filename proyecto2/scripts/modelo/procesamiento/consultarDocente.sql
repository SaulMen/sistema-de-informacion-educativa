USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarDocente (
	siif BIGINT
)

BEGIN
	DECLARE siif_valido INTEGER;
    SELECT COUNT(*) INTO siif_valido FROM proyecto2.docente AS d
    WHERE siif = d.siif;
    
    IF (siif_valido = 1) THEN 
        SELECT siif, CONCAT(nombre, ' ', apellido) AS nombre_completo, fecha_nacimiento, correo, telefono, direccion, dpi
        FROM proyecto2.docente AS d
        WHERE siif = d.siif;
    ELSE
        SELECT "No se encontró al estudiante" AS resultado;
    END IF;
END $$
DELIMITER ;
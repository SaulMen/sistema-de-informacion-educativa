USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarEstudiante (
	carnet BIGINT
)

BEGIN
	DECLARE carnet_valido INTEGER;
    SELECT COUNT(*) INTO carnet_valido FROM proyecto2.estudiante AS e
    WHERE carnet = e.carnet;
    
    IF (carnet_valido = 1) THEN 
        SELECT carnet, CONCAT(nombre, ' ', apellido) AS nombre_completo, fecha_nacimiento, correo, telefono,
        direccion, dpi, num_creditos, id_carrera AS carrera
        FROM proyecto2.estudiante AS e
        WHERE carnet = e.carnet;
    ELSE
        SELECT "No se encontró al estudiante" AS resultado;
    END IF;
END $$
DELIMITER ;
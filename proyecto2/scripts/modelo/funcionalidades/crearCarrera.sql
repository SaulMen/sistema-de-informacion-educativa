USE proyecto2;
DELIMITER $$
CREATE PROCEDURE crearCarrera (
    nombre_carrera VARCHAR(50)
)

BEGIN
    IF (nombre_carrera REGEXP '^[A-Za-z ]+$') THEN 
        INSERT INTO proyecto2.carrera (nombre_carrera) VALUES (nombre_carrera);
    END IF;
END $$
DELIMITER ;

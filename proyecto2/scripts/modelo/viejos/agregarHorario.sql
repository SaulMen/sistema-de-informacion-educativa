USE proyecto2;
DELIMITER $$
CREATE FUNCTION agregarHorario (
    id_habilitar INTEGER,
    dia INTEGER,
    horario VARCHAR(15)
)
RETURNS INTEGER DETERMINISTIC

BEGIN
	-- Añadir la condición si ya se encuentra el curso habilitado con el id_habilitado
    IF (dia >0 AND dia <8) THEN 
        INSERT INTO proyecto2.horario (id_habilitar, dia, horario) VALUES (id_habilitar, dia, horario);
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN -1;
    END IF;
END $$
DELIMITER ;

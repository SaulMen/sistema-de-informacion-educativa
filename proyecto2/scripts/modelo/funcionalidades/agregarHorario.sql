USE proyecto2;
DELIMITER $$
CREATE PROCEDURE agregarHorario (
    id_habilitar INTEGER,
    dia INTEGER,
    horario VARCHAR(15)
)

BEGIN

    DECLARE habilitado INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO habilitado FROM proyecto2.habilitar_curso AS h WHERE id_habilitar = h.id_habilitar;
    
    IF (dia >0 AND dia <8 AND habilitado=1) THEN 
        INSERT INTO proyecto2.horario (id_habilitar, dia, horario) VALUES (id_habilitar, dia, horario);
    ELSE
        SELECT "No se pudo agregar el horario" AS resultado;
    END IF;
END $$
DELIMITER ;

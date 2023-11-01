USE proyecto2;
DELIMITER $$
CREATE PROCEDURE ingresarNota (
    codigo INTEGER,
    ciclo VARCHAR (2),
    seccion CHAR (1),
    carnet BIGINT,
    nota DOUBLE
)

BEGIN
	-- *Es el código como tal del curso (no	del habilitado) Se debe hacer match con la relación
	-- de curso habilitado por medio del año actual, ciclo y sección.
    DECLARE ciclo_valido INTEGER;
    DECLARE carnet_valido INTEGER;
    -- Valido ciclo
    IF UPPER(ciclo) = '1S' OR UPPER(ciclo)="2S" OR UPPER(ciclo)="VJ" OR UPPER(ciclo)="VD" THEN
		SET ciclo_valido = 1;
    ELSE
		SET ciclo_valido = 0;
    END IF;
    
    SELECT COUNT(*) INTO carnet_valido FROM proyecto2.estudiante as e
    WHERE carnet = e.carnet;
    
	IF (nota >0 AND ciclo_valido=1 AND carnet_valido=1) THEN 
		INSERT INTO proyecto2.nota (codigo, ciclo, seccion, carnet, nota, anio) 
		VALUES (codigo, ciclo, UPPER(seccion), carnet, CAST(nota AS SIGNED), YEAR(NOW()));
        IF CAST(nota AS SIGNED)>=61 THEN
			UPDATE proyecto2.estudiante
            SET num_creditos = num_creditos + (
                SELECT creditos_dados
                FROM proyecto2.curso AS c
                WHERE codigo = c.codigo
            )
            WHERE carnet = proyecto2.estudiante.carnet;
		ELSE
			SELECT "Perdió el curso" as Nota;
        END IF;
	ELSE
        SELECT "Hubo un error al ingresar nota" as resultado;
    END IF;
END $$
DELIMITER ;
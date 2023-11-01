USE proyecto2;
DELIMITER $$
CREATE PROCEDURE habilitarCurso (
    codigo INTEGER,
    ciclo VARCHAR(2),
    id_docente INTEGER,
    cupo_maximo INTEGER,
    seccion CHAR(1)
)

BEGIN
	-- Sin validación de que existe docente    
    DECLARE curso_existente INTEGER;
    DECLARE ciclo_valido INTEGER;
	SELECT COUNT(*) INTO curso_existente FROM proyecto2.curso WHERE codigo = proyecto2.curso.codigo;
    IF ciclo = "1S" OR ciclo="2S" OR ciclo="VJ" OR ciclo="VD" THEN
		SET ciclo_valido = 1;
    ELSE
		SET ciclo_valido = 0;
    END IF;
    
    IF (cupo_maximo >0 AND ciclo_valido=1 AND curso_existente=1) THEN 
        INSERT INTO proyecto2.habilitar_curso (codigo, ciclo, id_docente, cupo_maximo, seccion, anio, total_asignados) 
        VALUES (codigo, ciclo, id_docente, cupo_maximo, UPPER(seccion), YEAR(now()), 0);
    ELSE
        SELECT "No se pudo habilitar el curso" AS resultado;
    END IF;
END $$
DELIMITER ;

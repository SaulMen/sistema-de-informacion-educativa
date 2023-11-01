USE proyecto2;
DELIMITER $$
CREATE FUNCTION habilitarCurso (
    codigo INTEGER,
    ciclo VARCHAR(2),
    id_docente INTEGER,
    cupo_maximo INTEGER,
    seccion CHAR(1),
    anio INTEGER,
    total_asignados INTEGER
)
RETURNS INTEGER DETERMINISTIC

BEGIN
	-- DECLARE codigo_curso INTEGER;
    -- SELECT codigo_curso INTO codigo FROM proyecto2.curso WHERE codigo = codigo LIMIT 1;
    -- Y agregarlo al if
    -- (BINARY ciclo = '1S' OR BINARY ciclo= '2S' OR BINARY ciclo= 'VD' OR BINARY ciclo= 'VJ')
    -- DECLARE siif_docente INTEGER;
    -- SELECT siif_docente INTO siif FROM proyecto2.curso WHERE id_docente = siif LIMIT 1; -- cambiar id_docente a SIIF
    -- Y agregarlo al if
    IF (cupo_maximo >0 AND total_asignados = 0) THEN 
        INSERT INTO proyecto2.habilitar_curso (codigo, ciclo, id_docente, cupo_maximo, seccion, anio, total_asignados) 
        VALUES (codigo, ciclo, id_docente, cupo_maximo, seccion, anio, total_asignados);
        RETURN LAST_INSERT_ID();
    ELSE
        RETURN -1;
    END IF;
END $$
DELIMITER ;

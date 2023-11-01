USE proyecto2;
DELIMITER $$
CREATE PROCEDURE desasignarCurso (
    codigo INTEGER,
    ciclo VARCHAR (2),
    seccion CHAR (1),
    carnet BIGINT
)

BEGIN
	-- *Es el código como tal del curso (no	del habilitado) Se debe hacer match con la relación
	-- de curso habilitado por medio del año actual, ciclo y sección.
    DECLARE si_esta INTEGER;
    DECLARE ciclo_valido INTEGER;
    -- Valido ciclo
    IF UPPER(ciclo) = '1S' OR UPPER(ciclo)="2S" OR UPPER(ciclo)="VJ" OR UPPER(ciclo)="VD" THEN
		SET ciclo_valido = 1;
    ELSE
		SET ciclo_valido = 0;
    END IF;
    -- Valido que este asignado el carnet
    SELECT COUNT(*) INTO si_esta FROM proyecto2.asignar AS a
    WHERE ciclo = a.ciclo AND UPPER(seccion) = a.seccion AND carnet = a.carnet AND codigo = a.codigo;
    IF (si_esta=1 AND ciclo_valido =1 ) THEN
		INSERT INTO proyecto2.desasignar_curso (codigo, ciclo, seccion, carnet) VALUES (codigo, ciclo, UPPER(seccion), carnet);
	ELSE
		SELECT "No se pudo desasignar" AS resultado, codigo AS codigo, ciclo as ciclo, seccion as seccion, carnet as carnet,
        si_esta as esta, ciclo_valido as valido_ciclo;
    END IF;
END $$
DELIMITER ;
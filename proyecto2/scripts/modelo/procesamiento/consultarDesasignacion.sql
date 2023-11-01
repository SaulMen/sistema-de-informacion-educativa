USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarDesasignacion (
	codigo INTEGER,
    ciclo VARCHAR(2),
    anio INTEGER,
    seccion CHAR(1)
)

BEGIN
    DECLARE ciclo_valido INTEGER;
    DECLARE codigo_valido INTEGER;
	DECLARE estudiantes_total INTEGER;
	DECLARE estudiantes_desasignados INTEGER;
	DECLARE porcentaje_desasignacion DECIMAL(5,2);
    IF UPPER(ciclo) = "1S" OR UPPER(ciclo)="2S" OR UPPER(ciclo)="VJ" OR UPPER(ciclo)="VD" THEN
		SET ciclo_valido = 1;
    ELSE
		SET ciclo_valido = 0;
    END IF;
    
    SELECT COUNT(*) INTO codigo_valido FROM proyecto2.curso AS c
    WHERE codigo = c.codigo;
    
    IF (codigo_valido = 1 AND ciclo_valido=1) THEN
        SELECT COUNT(*) INTO estudiantes_total
        FROM proyecto2.asignar AS a
        WHERE a.codigo = codigo AND a.ciclo = ciclo AND a.seccion = seccion;
        
        SELECT COUNT(*) INTO estudiantes_desasignados
        FROM proyecto2.desasignar_curso AS d
        WHERE d.codigo = codigo AND d.ciclo = ciclo AND d.seccion = seccion;
        
        IF estudiantes_total > 0 THEN
            SET porcentaje_desasignacion = (estudiantes_desasignados / estudiantes_total) * 100;
        ELSE
            SET porcentaje_desasignacion = 0;
        END IF;
        
        SELECT codigo , seccion,
        CASE
            WHEN ciclo = '1S' THEN 'PRIMER SEMESTRE'
            WHEN ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN ciclo = 'VJ' THEN 'VACACIONES DE JUNIO'
            WHEN ciclo = 'VD' THEN 'VACACIONES DE DICIEMBRE'
            ELSE 'Ciclo Desconocido'
        END AS ciclo, anio AS anio,
        estudiantes_total AS estudiantes_asignados, estudiantes_desasignados AS estudiantes_desasignados, porcentaje_desasignacion AS porcentaje_desasignacion;
        
    ELSE
        SELECT "Código de curso no válido" AS resultado;
    END IF;
END $$
DELIMITER ;
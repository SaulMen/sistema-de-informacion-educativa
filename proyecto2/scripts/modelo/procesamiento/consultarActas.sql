USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarActas (
	codigo INTEGER
)

BEGIN
    DECLARE codigo_valido INTEGER;
    SELECT COUNT(*) INTO codigo_valido FROM proyecto2.curso AS c
    WHERE codigo = c.codigo;
    
    IF (codigo_valido = 1) THEN
        SELECT
            a.codigo,
            a.seccion,
            CASE
                WHEN a.ciclo = '1S' THEN 'PRIMER SEMESTRE'
                WHEN a.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
                WHEN a.ciclo = 'VJ' THEN 'VACACIONES DE JUNIO'
                WHEN a.ciclo = 'VD' THEN 'VACACIONES DE DICIEMBRE'
                ELSE 'Ciclo Desconocido'
            END AS ciclo,
            YEAR(NOW()) as anio,
            (SELECT COUNT(*) FROM proyecto2.nota AS n WHERE n.ciclo = a.ciclo AND n.seccion = a.seccion AND n.codigo = a.codigo) AS cantidad_estudiantes,
            a.fecha
        FROM proyecto2.acta AS a
        WHERE a.codigo = codigo
        ORDER BY a.fecha;
    ELSE
        SELECT "Código de curso no válido" AS resultado;
    END IF;
END $$
DELIMITER ;
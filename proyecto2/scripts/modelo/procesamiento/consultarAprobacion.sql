USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarAprobacion (
	codigo INTEGER,
    ciclo VARCHAR (2),
    anio INTEGER,
    seccion CHAR (1)
)

BEGIN
	DECLARE ciclo_valido INTEGER;
    DECLARE codigo_valido INTEGER;
    IF UPPER(ciclo) = "1S" OR UPPER(ciclo)="2S" OR UPPER(ciclo)="VJ" OR UPPER(ciclo)="VD" THEN
		SET ciclo_valido = 1;
    ELSE
		SET ciclo_valido = 0;
    END IF;
    
    SELECT COUNT(*) INTO codigo_valido FROM proyecto2.curso AS c
    WHERE codigo = c.codigo;
    
    
    IF (codigo_valido = 1 AND ciclo_valido=1 AND anio=YEAR(NOW())) THEN 
        SELECT CONCAT(e.nombre, ' ', e.apellido) as nombre_completo, n.codigo, e.carnet,
            CASE
                WHEN n.nota >= 61 THEN "APROBADO"
                ELSE "DESAPROBADO"
            END AS Estado
        FROM proyecto2.nota AS n
        INNER JOIN proyecto2.estudiante AS e ON n.carnet = e.carnet
        WHERE n.ciclo = ciclo AND UPPER(n.seccion) = seccion AND n.codigo = codigo;
    ELSE
        SELECT "No se encontró al estudiante" AS resultado;
    END IF;
END $$
DELIMITER ;
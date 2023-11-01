USE proyecto2;
DELIMITER $$
CREATE PROCEDURE generarActa (
    codigo INTEGER,
    ciclo VARCHAR (2),
    seccion CHAR (1)
)

BEGIN
    DECLARE total_asignados INTEGER;
    DECLARE total_notas INTEGER;
    
    SELECT COUNT(*) INTO total_notas FROM proyecto2.nota AS n
    WHERE codigo = n.codigo AND UPPER(ciclo) = n.ciclo AND UPPER(seccion) = n.seccion;
    
    SELECT COUNT(*) INTO total_asignados FROM proyecto2.asignar AS a
    WHERE codigo = a.codigo AND UPPER(ciclo) = a.ciclo AND UPPER(seccion) = a.seccion;
    
    IF (total_asignados = total_notas AND (total_asignados>0 OR total_notas >0)) THEN
		INSERT INTO proyecto2.acta (codigo, ciclo, seccion, fecha) 
		VALUES (codigo, ciclo, seccion, now());
    ELSE
		SELECT "No se pudo generar el acta" AS resultado;
    END IF;
    
END $$
DELIMITER ;
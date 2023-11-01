-- CREACION DE LOS PROCESAMIENTOS
USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarPensum (
	carrera INTEGER
)

BEGIN
	DECLARE carrera_valida INTEGER;
    SELECT COUNT(*) INTO carrera_valida FROM proyecto2.carrera AS c
    WHERE carrera = c.id_carrera;
    
    IF (carrera_valida = 1) THEN 
        SELECT codigo,nombre,obligatorio,creditos_dados FROM proyecto2.curso as c
        WHERE carrera = c.id_carrera;
    ELSE
        SELECT "No se encontró la carrera" AS resultado;
    END IF;
END $$
DELIMITER ;

USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarEstudiante (
	carnet BIGINT
)

BEGIN
	DECLARE carnet_valido INTEGER;
    SELECT COUNT(*) INTO carnet_valido FROM proyecto2.estudiante AS e
    WHERE carnet = e.carnet;
    
    IF (carnet_valido = 1) THEN 
        SELECT carnet, CONCAT(nombre, ' ', apellido) AS nombre_completo, fecha_nacimiento, correo, telefono,
        direccion, dpi, num_creditos, id_carrera AS carrera
        FROM proyecto2.estudiante AS e
        WHERE carnet = e.carnet;
    ELSE
        SELECT "No se encontró al estudiante" AS resultado;
    END IF;
END $$
DELIMITER ;

USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarDocente (
	siif BIGINT
)

BEGIN
	DECLARE siif_valido INTEGER;
    SELECT COUNT(*) INTO siif_valido FROM proyecto2.docente AS d
    WHERE siif = d.siif;
    
    IF (siif_valido = 1) THEN 
        SELECT siif, CONCAT(nombre, ' ', apellido) AS nombre_completo, fecha_nacimiento, correo, telefono, direccion, dpi
        FROM proyecto2.docente AS d
        WHERE siif = d.siif;
    ELSE
        SELECT "No se encontró al estudiante" AS resultado;
    END IF;
END $$
DELIMITER ;

USE proyecto2;
DELIMITER $$
CREATE PROCEDURE consultarAsignados (
	codigo INTEGER,
    ciclo VARCHAR (2),
    anio INTEGER,
    seccion CHAR (1)
)

BEGIN
	DECLARE ciclo_valido INTEGER;
    DECLARE codigo_valido INTEGER;
    DECLARE carrera_valida INTEGER;
    IF UPPER(ciclo) = "1S" OR UPPER(ciclo)="2S" OR UPPER(ciclo)="VJ" OR UPPER(ciclo)="VD" THEN
		SET ciclo_valido = 1;
    ELSE
		SET ciclo_valido = 0;
    END IF;
    
    SELECT COUNT(*) INTO codigo_valido FROM proyecto2.curso AS c
    WHERE codigo = c.codigo;
    
    
    IF (codigo_valido = 1 AND ciclo_valido=1 AND anio=YEAR(NOW())) THEN 
        SELECT e.carnet, CONCAT(e.nombre, ' ', e.apellido) AS nombre_completo, e.num_creditos 
        FROM proyecto2.estudiante AS e
        INNER JOIN proyecto2.asignar AS a ON e.carnet = a.carnet 
        WHERE a.ciclo = ciclo AND a.seccion = seccion AND codigo = a.codigo;
    ELSE
        SELECT "No se encontró al estudiante" AS resultado;
    END IF;
END $$
DELIMITER ;

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
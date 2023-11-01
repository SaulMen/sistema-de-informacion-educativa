USE proyecto2;
DELIMITER $$
CREATE PROCEDURE asignarCurso (
    codigo INTEGER,
    ciclo VARCHAR (2),
    seccion CHAR (1),
    carnet BIGINT
)

BEGIN
	-- *Es el código como tal del curso (no	del habilitado) Se debe hacer match con la relación
	-- de curso habilitado por medio del año actual, ciclo y sección.alter
    DECLARE es_nuevo INTEGER ;
    DECLARE ya_esta INTEGER ;
    DECLARE ciclo_valido INTEGER ;
    DECLARE creditos_estudiante INTEGER;
    DECLARE creditos_curso INTEGER ;
    DECLARE carrera_curso INTEGER ;
    DECLARE carrera_estudiante INTEGER;
    DECLARE cupo_actual INTEGER;
    DECLARE cupo_maximo_curso INTEGER;
    -- Validacion si es primera vez
    SELECT COUNT(*) INTO es_nuevo FROM proyecto2.asignar as a
    WHERE codigo = a.codigo AND seccion = a.seccion AND carnet = a.carnet;
    -- Valida si está aunque sea en otra seccion
    SELECT COUNT(*) INTO ya_esta FROM proyecto2.asignar as a
    WHERE codigo = a.codigo AND carnet = a.carnet;
    -- valido ciclo correcto
    IF ciclo = "1S" OR ciclo="2S" OR ciclo="VJ" OR ciclo="VD" THEN
		SET ciclo_valido = 1;
    ELSE
		SET ciclo_valido = 0;
    END IF;
    -- Obtengo los creditos del estudiante
    SELECT num_creditos INTO creditos_estudiante FROM proyecto2.estudiante AS e
    WHERE carnet = e.carnet;
    -- Obtengo los creditos del curso y el id carrera a la que pertenece el curso
    SELECT creditos_necesarios, id_carrera INTO creditos_curso, carrera_curso FROM proyecto2.curso as c
    WHERE codigo = c.codigo;
    -- ID carrera del estudiante
    SELECT id_carrera INTO carrera_estudiante FROM proyecto2.estudiante AS e
    WHERE carnet = e.carnet;
    -- Cupo maximo del curso
    SELECT cupo_maximo INTO cupo_maximo_curso FROM proyecto2.habilitar_curso AS h
    WHERE codigo = h.codigo;

    -- cupo actual del curso
    SELECT COUNT(*) INTO cupo_actual FROM proyecto2.asignar AS a
    WHERE codigo = a.codigo AND ciclo = a.ciclo AND seccion = a.seccion;
    
    IF (es_nuevo=0 AND ya_esta=0 AND creditos_estudiante>=creditos_curso AND (carrera_curso=carrera_estudiante OR carrera_curso=0) 
		AND	cupo_actual<cupo_maximo_curso AND ciclo_valido=1)THEN
		INSERT INTO proyecto2.asignar (ciclo, seccion, carnet,codigo) VALUES (ciclo, UPPER(seccion), carnet,codigo);
	ELSE
		SELECT "Hubo un problema en la asignacion" AS resultado, creditos_estudiante AS creditos_estudiante, 
        creditos_curso AS creditos_curso, carrera_curso AS Carrera_del_curso, carrera_estudiante AS carrera_del_estu,
        cupo_maximo_curso AS cupo_curso_max, cupo_actual AS cupo_actual_curso;
    END IF;
    
END $$
DELIMITER ;
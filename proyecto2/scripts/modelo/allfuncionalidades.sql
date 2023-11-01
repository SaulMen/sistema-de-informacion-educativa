-- CREACION DE LAS FUNCIONALIDADES
USE proyecto2;
DELIMITER $$
CREATE PROCEDURE registrarEstudiante (
	carnet BIGINT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR (50),
    telefono INTEGER,
    direccion VARCHAR(100),
    dpi BIGINT,
    id_carrera INTEGER
)

BEGIN
	
    IF (correo REGEXP '^[a-zA-Z0-9]+@[a-zA-Z]+(\.[a-zA-Z]+)+$' AND telefono REGEXP '^[0-9]{8}$') THEN 
        INSERT INTO proyecto2.estudiante (carnet, nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, num_creditos, id_carrera) 
        VALUES (carnet, nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, 0, id_carrera);
    ELSE
        SELECT "Hubo un problema al registrar" AS resultado;
    END IF;
END $$
DELIMITER ;

USE proyecto2;
DELIMITER $$
CREATE PROCEDURE crearCarrera (
    nombre_carrera VARCHAR(50)
)

BEGIN
    IF (nombre_carrera REGEXP '^[A-Za-z ]+$') THEN 
        INSERT INTO proyecto2.carrera (nombre_carrera) VALUES (nombre_carrera);
    END IF;
END $$
DELIMITER ;

USE proyecto2;
DELIMITER $$
CREATE PROCEDURE registrarDocente (
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR (50),
    telefono INTEGER,
    direccion VARCHAR(100),
    dpi BIGINT,
    siif INTEGER
)

BEGIN
	DECLARE docente_existente INTEGER;
    -- Verificar si el docente ya existe por su número de SIIF
    SELECT COUNT(*) INTO docente_existente FROM proyecto2.docente WHERE siif = proyecto2.docente.siif;
	-- Y agregarlo al if
    IF ( docente_existente = 0 AND (correo REGEXP '^[a-zA-Z0-9]+@[a-zA-Z]+(\.[a-zA-Z]+)+$' AND telefono REGEXP '^[0-9]{8}$')) THEN 
        INSERT INTO proyecto2.docente (nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, siif) 
        VALUES (nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, siif);
    ELSE
        SELECT docente_existente AS Resultado, siif AS siif, correo AS correo, telefono AS telefono;
    END IF;
END $$
DELIMITER ;

USE proyecto2;
DELIMITER $$
CREATE PROCEDURE crearCurso (
    codigo INTEGER,
    nombre VARCHAR(50),
    creditos_necesarios INTEGER,
    creditos_dados INTEGER,
    id_carrera INTEGER,
    obligatorio BOOLEAN
)

BEGIN
	DECLARE curso_existente INTEGER;
	SELECT COUNT(*) INTO curso_existente FROM proyecto2.curso WHERE codigo = proyecto2.curso.codigo;
    IF (curso_existente=0 AND (creditos_necesarios >=0 AND creditos_dados >0)) THEN 
        INSERT INTO proyecto2.curso (codigo, nombre, creditos_necesarios, creditos_dados, obligatorio,id_carrera) 
        VALUES (codigo, nombre, creditos_necesarios, creditos_dados, obligatorio,id_carrera);
    ELSE
        SELECT "Error, al crear el curso" AS resultado;
    END IF;
END $$
DELIMITER ;

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

USE proyecto2;
DELIMITER $$
CREATE PROCEDURE agregarHorario (
    id_habilitar INTEGER,
    dia INTEGER,
    horario VARCHAR(15)
)

BEGIN

    DECLARE habilitado INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO habilitado FROM proyecto2.habilitar_curso AS h WHERE id_habilitar = h.id_habilitar;
    
    IF (dia >0 AND dia <8 AND habilitado=1) THEN 
        INSERT INTO proyecto2.horario (id_habilitar, dia, horario) VALUES (id_habilitar, dia, horario);
    ELSE
        SELECT "No se pudo agregar el horario" AS resultado;
    END IF;
END $$
DELIMITER ;

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


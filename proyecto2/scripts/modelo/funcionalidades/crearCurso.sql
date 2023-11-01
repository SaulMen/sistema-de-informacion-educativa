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

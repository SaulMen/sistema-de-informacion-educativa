-- select * from proyecto2.carrera;
-- SELECT crearCarrera('Sistemas');
-- SELECT crearCarrera('Idustrial');

 CALL crearCarrera('Ingenieria Civil');       -- 1  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Industrial');  -- 2  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Sistemas');    -- 3  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Electronica'); -- 4  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Mecanica');    -- 5  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Mecatronica'); -- 6  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Quimica');     -- 7  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Materiales');  -- 9  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
 CALL crearCarrera('Ingenieria Textil');

-- SELECT registrarDocente("Saul Jafet", "Menchu Recinos", '2023-10-30', "jafetmenchu13@gmail.com", 12345678, "mi direccion", 
-- 3806336630101, 111);
 CALL registrarDocente('Docente1','Apellido1','1999-10-30','aadf@ingenieria.usac.edu.gt',12345678,'direccion',12345678910,1);
 CALL registrarDocente('Docente2','Apellido2','1999-11-20','docente2@ingenieria.usac.edu.gt',12345678,'direcciondocente2',12345678911,2);
 CALL registrarDocente('Docente3','Apellido3','1980-12-20','docente3@ingenieria.usac.edu.gt',12345678,'direcciondocente3',12345678912,3);
 CALL registrarDocente('Docente4','Apellido4','1981-11-20','docente4@ingenieria.usac.edu.gt',12345678,'direcciondocente4',12345678913,4);
 CALL registrarDocente('Docente5','Apellido5','1982-09-20','docente5@ingenieria.usac.edu.gt',12345678,'direcciondocente5',12345678914,5);

-- REGISTRAR ESTUDIANTES
-- SISTEMAS
 CALL registrarEstudiante(202000001,'Estudiante de','Sistemas Uno','1999-10-30','sistemasuno@gmail.com',12345678,'direccion estudiantes sistemas 1',337859510101,3);
 CALL registrarEstudiante(202000002,'Estudiante de','Sistemas Dos','2000-5-3','sistemasdos@gmail.com',12345678,'direccion estudiantes sistemas 2',32781580101,3);
 CALL registrarEstudiante(202000003,'Estudiante de','Sistemas Tres','2002-5-3','sistemastres@gmail.com',12345678,'direccion estudiantes sistemas 3',32791580101,3);
-- CIVIL
 CALL registrarEstudiante(202100001,'Estudiante de','Civil Uno','1990-5-3','civiluno@gmail.com',12345678,'direccion de estudiante civil 1',3182781580101,1);
 CALL registrarEstudiante(202100002,'Estudiante de','Civil Dos','1998-08-03','civildos@gmail.com',12345678,'direccion de estudiante civil 2',3181781580101,1);
-- INDUSTRIAL
 CALL registrarEstudiante(202200001,'Estudiante de','Industrial Uno','1999-10-30','industrialuno@gmail.com',12345678,'direccion de estudiante industrial 1',3878168901,2);
 CALL registrarEstudiante(202200002,'Estudiante de','Industrial Dos','1994-10-20','industrialdos@gmail.com',89765432,'direccion de estudiante industrial 2',29781580101,2);
-- ELECTRONICA
 CALL registrarEstudiante(202300001, 'Estudiante de','Electronica Uno','2005-10-20','electronicauno@gmail.com',89765432,'direccion de estudiante electronica 1',29761580101,4);
 CALL registrarEstudiante(202300002, 'Estudiante de','Electronica Dos', '2008-01-01','electronicados@gmail.com',12345678,'direccion de estudiante electronica 2',387916890101,4);
-- ESTUDIANTES RANDOM
 CALL registrarEstudiante(201710160, 'ESTUDIANTE','SISTEMAS RANDOM','1994-08-20','estudiasist@gmail.com',89765432,'direccionestudisist random',29791580101,3);
 CALL registrarEstudiante(201710161, 'ESTUDIANTE','CIVIL RANDOM','1995-08-20','estudiacivl@gmail.com',89765432,'direccionestudicivl random',30791580101,1);

-- AGREGAR CURSO
-- aqui se debe de agregar el AREA COMUN a carrera
-- Insertar el registro con id 0
 INSERT INTO proyecto2.carrera (id_carrera,nombre_carrera) VALUES (0,'Area Comun');
 UPDATE proyecto2.carrera SET id_carrera = 0 WHERE id_carrera = LAST_INSERT_ID();

-- AREA COMUN
CALL crearCurso(0006,'Idioma Tecnico 1',0,7,0,false); 
CALL crearCurso(0007,'Idioma Tecnico 2',0,7,0,false);
CALL crearCurso(101,'MB 1',0,7,0,true); 
CALL crearCurso(103,'MB 2',0,7,0,true); 
CALL crearCurso(017,'SOCIAL HUMANISTICA 1',0,4,0,true); 
CALL crearCurso(019,'SOCIAL HUMANISTICA 2',0,4,0,true); 
CALL crearCurso(348,'QUIMICA GENERAL',0,3,0,true); 
CALL crearCurso(349,'QUIMICA GENERAL LABORATORIO',0,1,0,true);
-- INGENIERIA EN SISTEMAS
CALL crearCurso(777,'Compiladores 1',80,4,3,true); 
CALL crearCurso(770,'INTR. A la Programacion y computacion 1',0,4,3,true); 
CALL crearCurso(960,'MATE COMPUTO 1',33,5,3,true); 
CALL crearCurso(795,'lOGICA DE SISTEMAS',33,2,3,true);
CALL crearCurso(796,'LENGUAJES FORMALES Y DE PROGRAMACIÓN',0,3,3,TRUE);
-- INGENIERIA INDUSTRIAL
CALL crearCurso(123,'Curso Industrial 1',0,4,2,true); 
CALL crearCurso(124,'Curso Industrial 2',0,4,2,true);
CALL crearCurso(125,'Curso Industrial enseñar a pensar',10,2,2,false);
CALL crearCurso(126,'Curso Industrial ENSEÑAR A DIBUJAR',2,4,2,true);
CALL crearCurso(127,'Curso Industrial 3',8,4,2,true);
-- INGENIERIA CIVIL
CALL crearCurso(321,'Curso Civil 1',0,4,1,true);
CALL crearCurso(322,'Curso Civil 2',4,4,1,true);
CALL crearCurso(323,'Curso Civil 3',8,4,1,true);
CALL crearCurso(324,'Curso Civil 4',12,4,1,true);
CALL crearCurso(325,'Curso Civil 5',16,4,1,false);
CALL crearCurso(0250,'Mecanica de Fluidos',0,5,1,true);
-- INGENIERIA ELECTRONICA
CALL crearCurso(421,'Curso Electronica 1',0,4,4,true);
CALL crearCurso(422,'Curso Electronica 2',4,4,4,true);
CALL crearCurso(423,'Curso Electronica 3',8,4,4,false);
CALL crearCurso(424,'Curso Electronica 4',12,4,4,true);
CALL crearCurso(425,'Curso Electronica 5',16,4,4,true);

-- PROPIAS
-- Habilitar curso
CALL habilitarCurso(6,'1S',1,36,'a');
CALL habilitarCurso(17,'VD',3,110,'b');
CALL habilitarCurso(7,'2S',4,110,'A');
CALL habilitarCurso(19,'VJ',5,36,'A');
CALL habilitarCurso(322,'1S',5,36,'A');

-- Añadir horario 9:00-10:40
CALL agregarHorario(2,1,'9:00-10:40');
CALL agregarHorario(3,4,'10:40-11:30');
CALL agregarHorario(2,6,'7:10-8:50');

-- Asignar curso
CALL asignarCurso(7,'1S','C',201710161);
CALL asignarCurso(7,'1S','C',202000003);
CALL asignarCurso(7,'1S','C',202100002);
CALL asignarCurso(7,'1S','C',202300001);
CALL asignarCurso(6,'1S','A',202000001);
CALL asignarCurso(19,'2S','A',202200001);

-- Desasignar curso
CALL desasignarCurso(7,'1S','C',201710161);
CALL desasignarCurso(6,'1S','C',202000001);
CALL desasignarCurso(19,'2S','A',202200001);

-- Ingresar nota
CALL ingresarNota(7,'1S','C',201710161,34.7);
CALL ingresarNota(7,'1S','C',202000003,67.7);
CALL ingresarNota(7,'1S','C',202100002,90.1);
CALL ingresarNota(7,'1S','C',202300001,61.0);
CALL ingresarNota(6,'1S','A',202000001,60.5);
CALL ingresarNota(19,'2S','A',202200001,89.4);

-- Generar acta
CALL generarActa(7,'1S','C');
CALL generarActa(7,'1S','A'); -- Este no
CALL generarActa(19,'2S','A');

--
-- PETICIONES Y PROCESAMIENTO DE DATOS
--
CALL consultarPensum(1);
CALL consultarEstudiante(202000003);
CALL consultarDocente(3);
CALL consultarAsignados(7,'1S',2023,'C');
CALL consultarAprobacion(7,'1S',2023,'C');
CALL consultarActas(7);
CALL consultarDesasignacion(7,'1S',2023,'C');


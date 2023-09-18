const db = require('../db/conexion');
const config = require('../db/config');
const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');
const filePath = path.join(__dirname, '../../carga/cargos.csv');
const fileCiudadanos = path.join(__dirname, '../../carga/ciudadanos.csv');
const fileDepatamento = path.join(__dirname, '../../carga/departamentos.csv');
const filePartido = path.join(__dirname, '../../carga/partidos.csv');
const fileCandidato = path.join(__dirname, '../../carga/candidatos.csv');
const fileVoto = path.join(__dirname, '../../carga/votaciones.csv');
const fileMesa = path.join(__dirname, '../../carga/mesas.csv');

exports.temporales = async (req, res) => {

    const scriptTemporal=`
    -- TABLA CANDIDATO TEMPORAL
        CREATE TEMPORARY TABLE prueba.cargo_temporal (
            id_cargo INTEGER NOT NULL,
            cargo VARCHAR(50) NOT NULL
        );

        CREATE TEMPORARY TABLE prueba.ciudadano_temporal (
            dpi VARCHAR(13) NOT NULL,
            nombre VARCHAR(50) NOT NULL,
            apellido VARCHAR(50) NOT NULL,
            direccion VARCHAR(100) NOT NULL,
            telefono VARCHAR(10) NOT NULL,
            edad INTEGER NOT NULL,
            genero VARCHAR(10) NOT NULL
        );

        CREATE TEMPORARY TABLE IF NOT EXISTS prueba.departamento_temporal (
            id_departamento INTEGER NOT NULL,
            nombre VARCHAR(25) NOT NULL
            );

        CREATE TEMPORARY TABLE IF NOT EXISTS prueba.partido_temporal (
            id_partido INTEGER NOT NULL,
            nombre_partido VARCHAR(50) NOT NULL,
            siglas VARCHAR(25) NOT NULL,
            fundacion DATE NOT NULL
            );

        CREATE TEMPORARY TABLE IF NOT EXISTS prueba.candidato_temporal (
            id_candidato INTEGER NOT NULL,
            nombre_candidato VARCHAR(100) NOT NULL,
            fecha_nacimiento DATE NOT NULL,
            id_partido INTEGER NOT NULL,
            id_cargo INTEGER NOT NULL 
            );

        CREATE TEMPORARY TABLE IF NOT EXISTS prueba.mesa_temporal (
            id_mesa INTEGER NOT NULL,
            id_departamento INTEGER NOT NULL
            );

        CREATE TEMPORARY TABLE IF NOT EXISTS prueba.voto_temporal (
            id_voto INTEGER NOT NULL,
            id_candidato INTEGER NOT NULL,
            fecha_hora DATETIME NOT NULL,
            dpi_ciudadano VARCHAR(13) NOT NULL,
            id_mesa INTEGER NOT NULL
            );
        `;
    try {
        // Crear una conexión que se cerrará automáticamente al terminar
        const connection = await mysql.createConnection(config.db);
        // Eliminar los comentarios del script SQL
        const scriptWithoutComments = scriptTemporal.replace(/(--.*)/g, '');

        // Ejecutar el script SQL sin comentarios
        const sqlCommands = scriptWithoutComments.split(";").map(command => command.trim());

        for (let i = 0; i < sqlCommands.length; i++) {
            sql = sqlCommands[i];
            if (sql.length === 0) {
                continue;
            }
            await db.querywithoutclose(connection, sql, []);
        }

        // cargo los datos a mi tabla temporal de cargos
        const datosCargos = fs.readFileSync(filePath,'UTF-8');
        const lineas = datosCargos.split('\n');
        for (let i = 0; i < lineas.length; i++) {
            if (i===0) {
                continue;
            }
            const fields = lineas[i].split(',');
            
            if (fields.length!=2) {
                console.log(fields.length)
                continue;
            }
            const id_cargo = fields[0];
            const nombre_cargo = fields[1];
            // Se insertan los datos de a la tabla temporal 
            await db.querywithoutclose(connection, `INSERT INTO prueba.cargo_temporal (id_cargo, cargo) VALUES (?, ?)`, [id_cargo, nombre_cargo]);

        }

        const datosTempCargos = await db.querywithoutclose(connection, `SELECT * FROM prueba.cargo_temporal`, []);
        console.log(datosTempCargos);

        // por ultimo pasamos los datos de la tabla temporal a la tabla clientes
        await db.querywithoutclose(connection, `INSERT INTO prueba.cargo (id_cargo, cargo) SELECT id_cargo, cargo FROM prueba.cargo_temporal`, []);

        // Tabla temporal de ciudadanos
        const datosCiudadanos = fs.readFileSync(fileCiudadanos,'UTF-8');
        const lineas2 = datosCiudadanos.split('\n');
        for (let i = 0; i < lineas2.length; i++) {
            if (i===0) {
                continue;
            }
            const fields = lineas2[i].split(',');
            
            
            if (fields.length<7) {
                console.log(fields.length)
                continue;
            }
            const dpi = fields[0];
            const nombre = fields[1];
            const apellido = fields[2];
            const direccion = fields[3];
            const telefono = fields[4];
            const edad = fields[5];
            const genero = fields[6];
            // Se insertan los datos de a la tabla temporal 
            await db.querywithoutclose(connection, `INSERT INTO prueba.ciudadano_temporal (dpi, nombre, apellido, direccion, telefono, edad, genero) 
                        VALUES (?, ?, ?, ?, ?, ?, ?)`, [dpi, nombre , apellido, direccion, telefono, edad, genero.replace('\r','')]);

        }
        const datosTempCiu = await db.querywithoutclose(connection, `SELECT * FROM prueba.ciudadano_temporal`, []);
        console.log(datosTempCiu.length);

        await db.querywithoutclose(connection, `INSERT INTO prueba.ciudadano (dpi, nombre, apellido, direccion, telefono, edad, genero) 
        SELECT dpi, nombre, apellido, direccion, telefono, edad, genero FROM prueba.ciudadano_temporal`, []);

        // Tabla temporal de departamentos
        const datosDepartamentos = fs.readFileSync(fileDepatamento,'UTF-8');
        const lineas3 = datosDepartamentos.split('\n');
        for (let i = 0; i < lineas3.length; i++) {
            if (i===0) {
                continue;
            }
            const fields = lineas3[i].split(',');
            
            
            if (fields.length<2) {
                console.log(fields.length)
                continue;
            }
            const id = fields[0];
            const nombre = fields[1];
            // Se insertan los datos de a la tabla temporal 
            await db.querywithoutclose(connection, `INSERT INTO prueba.departamento_temporal (id_departamento, nombre) 
                        VALUES (?, ?)`, [id, nombre]);

        }
        const datosTempDepa = await db.querywithoutclose(connection, `SELECT * FROM prueba.departamento_temporal`, []);
        console.log(datosTempDepa.length);

        await db.querywithoutclose(connection, `INSERT INTO prueba.departamento (id_departamento, nombre) 
        SELECT id_departamento, nombre FROM prueba.departamento_temporal`, []);

        // Tabla temporal de partidos
        const datosPartidos = fs.readFileSync(filePartido,'UTF-8');
        const lineas4 = datosPartidos.split('\n');
        for (let i = 0; i < lineas4.length; i++) {
            if (i===0) {
                continue;
            }
            const fields = lineas4[i].split(/,(?=(?:(?:[^"]*"){2})*[^"]*$)/);
            for (let i = 0; i < fields.length; i++) {
                fields[i] = fields[i].replace(/"/g, '');
            }
            console.log(fields);
            if (fields.length<4) {
                console.log(fields.length)
                continue;
            }
            const id = fields[0];
            const nombre = fields[1];
            const siglas = fields[2];
            const fundacion = fields[3].replace(/\r/g,'');
            // Se insertan los datos de a la tabla temporal 
            console.log(id,nombre,siglas, fundacion);
            await db.querywithoutclose(connection, `INSERT INTO prueba.partido_temporal (id_partido, nombre_partido, siglas, fundacion) 
                        VALUES (?, ?, ?, ?)`, [id, nombre, siglas, fundacion]);

        }
        const datosTempParti = await db.querywithoutclose(connection, `SELECT * FROM prueba.partido_temporal`, []);
        console.log(datosTempParti.length);

        await db.querywithoutclose(connection, `INSERT INTO prueba.partido (id_partido, nombre_partido, siglas, fundacion) 
        SELECT id_partido, nombre_partido, siglas, fundacion FROM prueba.partido_temporal`, []);

        // Tabla temporal de candidatos
        const datosCandidatos = fs.readFileSync(fileCandidato,'UTF-8');
        const lineas5 = datosCandidatos.split('\n');
        for (let i = 0; i < lineas5.length; i++) {
            if (i===0) {
                continue;
            }
            const fields = lineas5[i].split(',');


            if (fields.length<5) {
                console.log(fields.length)
                continue;
            }
            const id = fields[0];
            const nombre = fields[1];
            const fecha = fields[2].replace(/\r/g,'');;
            const id_partido = fields[3];
            const id_cargo = fields[4];
            // Se insertan los datos de a la tabla temporal
            await db.querywithoutclose(connection, `INSERT INTO prueba.candidato_temporal (id_candidato, nombre_candidato, fecha_nacimiento, id_partido, id_cargo) 
                        VALUES (?, ?, ?, ?, ?)`, [id, nombre, fecha, id_partido, id_cargo]);

        }
        const datosTempCan = await db.querywithoutclose(connection, `SELECT * FROM prueba.candidato_temporal`, []);
        console.log(datosTempCan.length);

        await db.querywithoutclose(connection, `INSERT INTO prueba.candidato (id_candidato, nombre_candidato, fecha_nacimiento, id_partido, id_cargo) 
        SELECT id_candidato, nombre_candidato, fecha_nacimiento, id_partido, id_cargo FROM prueba.candidato_temporal`, []);

        // Tabla temporal de mesas
        const datosMesas = fs.readFileSync(fileMesa,'UTF-8');
        const lineas6 = datosMesas.split('\n');
        for (let i = 0; i < lineas6.length; i++) {
            if (i===0) {
                continue;
            }
            const fields = lineas6[i].split(',');


            if (fields.length<2) {
                console.log(fields.length)
                continue;
            }
            const id = fields[0];
            const id_departamento = fields[1];
            //console.log(fecha);
            // Se insertan los datos de a la tabla temporal
            await db.querywithoutclose(connection, `INSERT INTO prueba.mesa_temporal (id_mesa, id_departamento) 
                        VALUES (?, ?)`, [id, id_departamento]);
        }
        const datosTempMesa= await db.querywithoutclose(connection, `SELECT * FROM prueba.mesa_temporal`, []);
        console.log(datosTempMesa.length);

        await db.querywithoutclose(connection, `INSERT INTO prueba.mesa 
                                                (id_mesa, id_departamento)
                                                SELECT id_mesa, id_departamento
                                                FROM prueba.mesa_temporal;`, []);

        // Tabla temporal de votos
        const datosVotos = fs.readFileSync(fileVoto,'UTF-8');
        const lineas7 = datosVotos.split('\n');
        for (let i = 0; i < lineas7.length; i++) {
            if (i===0) {
                continue;
            }
            const fields = lineas7[i].split(',');


            if (fields.length<5) {
                console.log(fields.length)
                continue;
            }
            const id = fields[0];
            const id_candidato = fields[1];
            const dpi_ciudadano = fields[2];
            const id_mesa = fields[3];
            const fecha = fields[4].replace(/\r/g,'');
            //console.log(fecha);
            // Se insertan los datos de a la tabla temporal
            await db.querywithoutclose(connection, `INSERT IGNORE INTO prueba.voto_temporal (id_voto, id_candidato, fecha_hora, dpi_ciudadano, id_mesa) 
                        VALUES (?, ?, ?, ?, ?)`, [id, id_candidato, fecha, dpi_ciudadano, id_mesa]);
        }
        // Añadir datos a tabla votos
        const datosTempVoto= await db.querywithoutclose(connection, `SELECT * FROM prueba.voto_temporal`, []);
        console.log(datosTempVoto.length);
        
        await db.querywithoutclose(connection,`INSERT IGNORE INTO prueba.voto 
                                            (id_voto, fecha_hora, dpi_ciudadano, id_mesa)
                                            SELECT DISTINCT id_voto, fecha_hora, dpi_ciudadano, id_mesa
                                            FROM prueba.voto_temporal`, []);;
        // Añadir datos a tabla detalles votos
        const datosTempDetalle= await db.querywithoutclose(connection, `SELECT * FROM prueba.voto_temporal`, []);
        //console.log(datosTempDetalle.length);

        await db.querywithoutclose(connection,`INSERT IGNORE INTO prueba.detalle_voto 
                                            (id_voto, id_candidato)
                                            SELECT id_voto, id_candidato
                                            FROM prueba.voto_temporal`, []);;
        

        // CIERRO LA CONEXIÓN
        await connection.end();

        res.status(200).json({
            consulta: 'Creación de tablas temporales, carga de datos a tablas temporales y a tablas del modelo', 
            message: 'TABLA TEMPORAL Y DATOS CARGADOS CORRECTAMENTE AL MODELO DE LA BBDD' },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN PROBLEMA AL CARGAR DATOS A LA BBDD', error },
        });
    }
}
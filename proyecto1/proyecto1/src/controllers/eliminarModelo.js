const db = require('../db/conexion');

exports.eliminar = async (req, res) => {
    
    const scriptEliminar=`
    -- ELIMINAR BBDD

    DROP DATABASE IF EXISTS prueba;

    DROP TABLE IF EXISTS prueba.ciudadano;

    DROP TABLE IF EXISTS prueba.voto;

    DROP TABLE IF EXISTS prueba.mesa;

    DROP TABLE IF EXISTS prueba.dapartamento;

    DROP TABLE IF EXISTS prueba.detalle_voto;

    DROP TABLE IF EXISTS prueba.candidato;

    DROP TABLE IF EXISTS prueba.cargo;

    DROP TABLE IF EXISTS prueba.parrtido;
    `;

    try {
        // Eliminar los comentarios del script SQL
        const scriptWithoutComments = scriptEliminar.replace(/(--.*)/g, '');

        // Ejecutar el script SQL sin comentarios
        const sqlCommands = scriptWithoutComments.split(";").map(command => command.trim());

        for (let i = 0; i < sqlCommands.length; i++) {
            sql = sqlCommands[i];
            if (sql.length === 0) {
                continue;
            }
            await db.query(sql,[]);
        }

        res.status(200).json({
            consulta: 'Eliminar tablas y modelo de BBDD', message: 'SE HA ELIMINADO EL MODELO EXITOSAMENTE' },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN PROBLEMA AL ELIMINAR LA BBDD', error },
        });
    }
}
const db = require('../db/conexion');

exports.consulta1 = async (req, res) => {
    
    const scriptConsulta=`
    SELECT presi.nombre_candidato AS "Presidente",
        vice.nombre_candidato AS "Vicepresidente",
        par.nombre_partido AS "Partido"
    FROM prueba.candidato AS presi
    JOIN prueba.candidato AS vice ON presi.id_partido = vice.id_partido
    JOIN prueba.partido AS par ON presi.id_partido = par.id_partido
    WHERE presi.id_cargo = 1 AND vice.id_cargo = 2;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Candidatos a presidentes y vicepresidentes por partido', message: msg,
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'Ocurrió UN error al realizar la consulta', error },
        });
    }
}
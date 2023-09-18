const db = require('../db/conexion');

exports.consulta8 = async (req, res) => {
    
    const scriptConsulta=`
        SELECT c.nombre_candidato AS 'Presidente', cc.nombre_candidato AS 'Vicepresidente', COUNT(d.id_detalle) AS 'Total de Votos'
        FROM prueba.candidato AS c
        JOIN prueba.detalle_voto AS d ON c.id_candidato = d.id_candidato
        LEFT JOIN prueba.candidato AS cc ON c.id_partido = cc.id_partido AND cc.id_cargo = 2
        WHERE c.id_cargo = 1
        GROUP BY c.nombre_candidato, cc.nombre_candidato
        ORDER BY COUNT(d.id_detalle) DESC
        LIMIT 10;
    
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Top 10 de candidatos más votados para presidente y vicepresidente', message: msg },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
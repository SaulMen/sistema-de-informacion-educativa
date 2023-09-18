const db = require('../db/conexion');

exports.consulta6 = async (req, res) => {
    
    const scriptConsulta=`
            select count(distinct d.id_voto) as 'Total nulos'
            from prueba.detalle_voto as d
            where d.id_candidato = -1
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Cantidad de votos nulos', message: msg },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
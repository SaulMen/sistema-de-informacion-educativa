const db = require('../db/conexion');

exports.consulta4 = async (req, res) => {
    
    const scriptConsulta=`
            SELECT count(c.id_candidato) as 'Total Candidatos' ,
                p.nombre_partido AS "Partido"
            FROM prueba.candidato as c
            join prueba.partido as p on p.id_partido=c.id_partido
            where c.id_cargo in (1,2,3,4,5,6)
            group by p.nombre_partido;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Cantidad de candidatos por partido', message: msg },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
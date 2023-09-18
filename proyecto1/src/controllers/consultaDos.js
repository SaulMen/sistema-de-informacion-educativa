const db = require('../db/conexion');

exports.consulta2 = async (req, res) => {
    
    const scriptConsulta=`
            SELECT p.nombre_partido AS "Partido",
                count(c.id_candidato) as 'Total Diputados' 
            FROM prueba.candidato as c
            join prueba.partido as p on p.id_partido=c.id_partido
            where c.id_cargo in (3,4,5)
            group by p.nombre_partido;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Total candidatos a diputados', message: msg,
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
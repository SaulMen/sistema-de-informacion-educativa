const db = require('../db/conexion');

exports.consulta3 = async (req, res) => {
    
    const scriptConsulta=`
            select c.nombre_candidato as 'Alcalde',
                p.nombre_partido as 'Partido'
            from prueba.candidato as c
            join prueba.partido as p on c.id_partido=p.id_partido
            where c.id_cargo=6;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Nombre de los candidatos a alcalde por partido.', message: msg},
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
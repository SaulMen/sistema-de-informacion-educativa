const db = require('../db/conexion');

exports.consulta7 = async (req, res) => {
    
    const scriptConsulta=`
            select count(c.nombre) as "Votos totales" , edad  
            from prueba.ciudadano as c
            group by c.edad order by count(c.nombre) desc limit 10;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Top 10 de ciudadanos que realizaron su voto por edad', message: msg },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
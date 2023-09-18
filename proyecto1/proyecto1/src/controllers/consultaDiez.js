const db = require('../db/conexion');

exports.consulta10 = async (req, res) => {
    
    const scriptConsulta=`
            select v.fecha_hora as 'Hora y Minuto' , count(v.dpi_ciudadano) as 'Total ciudadanos'
            from prueba.voto as v
            group by v.fecha_hora
            order by count(v.id_voto) DESC
            limit 5;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Top 5 hora más concurrida de votos emitidos', message: msg },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
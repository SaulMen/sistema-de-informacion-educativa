const db = require('../db/conexion');

exports.consulta11 = async (req, res) => {
    
    const scriptConsulta=`
            select c.genero as 'Genero' , count(v.dpi_ciudadano) as 'Total votos'
            from prueba.ciudadano as c
            join  prueba.voto as v on c.dpi=v.dpi_ciudadano
            where v.dpi_ciudadano = c.dpi
            group by c.genero
            order by c.genero;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Cantidad de votos por genero', message: msg },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
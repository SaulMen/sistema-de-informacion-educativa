const db = require('../db/conexion');

exports.consulta5 = async (req, res) => {
    
    const scriptConsulta=`
            select count(v.id_voto) as 'Total votos',
                d.nombre as 'Departamento'
            from prueba.voto as v
            join prueba.mesa as m on m.id_mesa = v.id_mesa
            join prueba.departamento as d on d.id_departamento = m.id_departamento
            group by d.id_departamento;
    `;

    try {
        
        const msg = await db.query(scriptConsulta,[]);

        res.status(200).json({
            consulta: 'Cantidad de votaciones por departamentos', message: msg },
        );
    } catch (error) {
        console.log(error);
        res.status(500).json({
            body: { res: false, message: 'OCURRIÓ UN error al realizar la consulta', error },
        });
    }
}
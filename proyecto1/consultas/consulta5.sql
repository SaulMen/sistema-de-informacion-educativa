select count(v.id_voto) as 'Total votos',
		d.nombre as 'Departamento'
from prueba.voto as v
join prueba.mesa as m on m.id_mesa = v.id_mesa
join prueba.departamento as d on d.id_departamento = m.id_departamento
group by d.id_departamento;
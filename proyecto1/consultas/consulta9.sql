-- Top 5 de mesas más frecuentadas (mostrar no. Mesa y departamento al que pertenece).

select m.id_mesa as 'No. mesa', d.nombre as 'Departamento', count(v.id_mesa) as 'Votos totales'
from prueba.mesa as m
join prueba.voto as v on v.id_mesa=m.id_mesa
left join prueba.departamento as d on d.id_departamento=m.id_departamento
group by m.id_mesa, d.nombre
order by  count(v.id_mesa) DESC
limit 5;
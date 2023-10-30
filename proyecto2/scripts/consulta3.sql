select c.nombre_candidato as 'Alcalde',
	p.nombre_partido as 'Partido'
from prueba.candidato as c
join prueba.partido as p on c.id_partido=p.id_partido
where c.id_cargo=6;

SELECT count(c.id_candidato) as 'Total Diputados' ,
		p.nombre_partido AS "Partido"
FROM prueba.candidato as c
join prueba.partido as p on p.id_partido=c.id_partido
where c.id_cargo in (3,4,5)
group by p.nombre_partido;

-- Mostrar el número de candidatos a diputados (esto incluye lista nacional, distrito
-- electoral, parlamento) por cada partido.
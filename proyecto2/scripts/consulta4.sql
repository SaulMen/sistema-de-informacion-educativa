SELECT count(c.id_candidato) as 'Total Candidatos' ,
		p.nombre_partido AS "Partido"
FROM prueba.candidato as c
join prueba.partido as p on p.id_partido=c.id_partido
where c.id_cargo in (1,2,3,4,5,6)
group by p.nombre_partido;
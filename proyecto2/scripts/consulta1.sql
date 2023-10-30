SELECT presi.nombre_candidato AS "Presidente",
    par.nombre_partido AS "Partido"
FROM prueba.candidato AS presi
JOIN prueba.partido AS par ON presi.id_partido = par.id_partido
WHERE presi.id_cargo = 1 ;
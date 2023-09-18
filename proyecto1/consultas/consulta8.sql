-- Top 10 de candidatos más votados para presidente y vicepresidente (el voto por
-- presidente incluye el vicepresidente).

SELECT c.nombre_candidato AS 'Presidente', cc.nombre_candidato AS 'Vicepresidente', COUNT(d.id_detalle) AS 'Total de Votos'
FROM prueba.candidato AS c
JOIN prueba.detalle_voto AS d ON c.id_candidato = d.id_candidato
LEFT JOIN prueba.candidato AS cc ON c.id_partido = cc.id_partido AND cc.id_cargo = 2
WHERE c.id_cargo = 1
GROUP BY c.nombre_candidato, cc.nombre_candidato
ORDER BY COUNT(d.id_detalle) DESC
LIMIT 10;


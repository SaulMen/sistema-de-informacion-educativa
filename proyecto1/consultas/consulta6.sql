select count(distinct d.id_voto) as 'Total nulos'
from prueba.detalle_voto as d
where d.id_candidato = -1
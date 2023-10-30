-- Mostrar el top 5 la hora más concurrida en que los ciudadanos fueron a votar

select v.fecha_hora as 'Hora y Minuto' , count(v.dpi_ciudadano) as 'Total ciudadanos'
from prueba.voto as v
group by v.fecha_hora
order by count(v.id_voto) DESC
limit 5;
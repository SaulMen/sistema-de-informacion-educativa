-- Top 10 de edad de ciudadanos que realizaron su voto.
-- agrupos por edad y mostrar para mientras
select count(c.nombre) as "Votos totales" , edad  
from prueba.ciudadano as c
group by c.edad order by count(c.nombre) desc limit 10;
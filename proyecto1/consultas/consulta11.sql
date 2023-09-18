-- Cantidad de votos por genero (Masculino, Femenino).

select c.genero as 'Genero' , count(v.dpi_ciudadano) as 'Total votos'
from prueba.ciudadano as c
join  prueba.voto as v on c.dpi=v.dpi_ciudadano
where v.dpi_ciudadano = c.dpi
group by c.genero
order by c.genero;

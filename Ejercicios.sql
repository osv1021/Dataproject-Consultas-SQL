-- Ejercicio 2: muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ. 
select "title", "rating" 
from "film"
where "rating" = 'R';

-- Ejercicio 3: encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40. 
select "actor_id", concat("first_name", ' ',"last_name") as "Nombre_completo"
from "actor"
where "actor_id" between 30 and 40;

-- Ejercicio 4: obtén las películas cuyo idioma coincide con el idioma original. 
select "title", "language_id", "original_language_id"
from "film"
where "language_id"="original_language_id";

--Ejercicio 5: ordena las películas por duración de forma ascendente.
select "title", "length" as "Duracion"
from "film"
order by "length" ASC;

--  Ejercicio 6: encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select concat("first_name", ' ', "last_name") as "Nombre_completo" 
from "actor"
where "last_name" ilike '%Allen%';

//*Ejercicio 7: encuentra la cantidad total de películas en cada clasificación de la tabla  
“filmˮ y muestra la clasificación junto con el recuento.*//
 select count("film_id") as "Cantidad_peliculas", "rating"  as "Clasificacion"
 from "film"
group by "rating";

//*Ejercicio 8: encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una 
duración mayor a 3 horas en la tabla film.*//
select "title" , "rating", "length" 
from "film" 
where "rating" = 'PG-13'
or "length" > 180;

--Ejercicio 9:encuentra la variabilidad de lo que costaría reemplazar las películas.
select stddev("replacement_cost") as "Variabilidad"
from "film";

--Ejercicio 10:encuentra la mayor y menor duración de una película de nuestra BBDD.
select min("length") as "Pelicula_menor_duracion", max("length") as "Pelicula_mayor_duracion"
from "film";

-- Ejercicio 11: encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select r."rental_id" ,p."amount"
from "rental" as r
inner join "payment" as p
on r."rental_id"=p."rental_id"
order by r."rental_date" desc
limit 1
offset 2;

//* Ejercicio 12: encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-
 17ʼ ni ‘Gʼ en cuanto a su clasificación.*//
 select "title", "rating"
 from "film"
where "rating" not in ('NC-17', 'G');

//* Ejercicio 13: encuentra el promedio de duración de las películas para cada 
clasificación de la tabla film y muestra la clasificación junto con el promedio de duración. *//
select round(avg("length"),2) as "Promedio_duracion", "rating" as "Clasificacion"
from "film"
group by "rating";

--Ejercicio 14: encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title", "length"
from "film"
where "length" > 180;

--Ejercicio 15: ¿Cuánto dinero ha generado en total la empresa?
select sum("amount") as "Dinero_generado"
from "payment";

--Ejercicio 16: muestra los 10 clientes con mayor valor de id.
select "customer_id"
from "customer"
order by "customer_id" desc 
limit 10;

--Ejercicio 17 encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
select concat(a."first_name", ' ',a."last_name") as Nombre_actores, f."title" 
from "actor" as a
inner join "film_actor" as fa
on a."actor_id" = fa."actor_id"
inner join "film" as f 
on fa."film_id" = f."film_id"
where f."title"= 'EGG IGBY';

--Ejercicio 18: selecciona todos los nombres de las películas únicos.
select distinct "title" as "Nombre_pelicula"
from "film";

--Ejercicio 19: encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
select f."title" as "Titulo_peliculas", f."length" as "Duracion", c."name" as "Categoria"
from "film" as f
inner join "film_category" as fc 
on f."film_id" = fc."film_id"
inner join "category" as c
on fc."category_id" = c."category_id"
where c."name" ='Comedy'
and f."length" > 180;

//* Ejercicio 20: encuentra las categorías de películas que tienen un promedio de 
duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.*//
select round(avg(f."length"),2) as "Promedio_duracion", c."name" as "Categoria"
from "film" as f
inner join "film_category" as fc 
on f."film_id" = fc."film_id"
inner join "category" as c
on fc."category_id" = c."category_id"
group by c."name"
having avg(f."length") > 110;

--Ejercicio 21: ¿Cuál es la media de duración del alquiler de las películas?
select avg("return_date" - "rental_date") as "Promedio_duracion_alquiler"
from "rental"
where "return_date" is not null;

--Ejercicio 22: crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat("first_name", ' ',"last_name") as "Nombre_completo" 
from "actor";

--Ejercicio 23: números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select count("rental_id") as "Numero_alquiler", Date("rental_date") as "Dia"
from "rental"
group by date("rental_date")
order by "Numero_alquiler" DESC;

--Ejercicio 24: encuentra las películas con una duración superior al promedio.
select "title" 
from "film"
where "length" > (
      select avg("length") 
      from "film"
);

--Ejercicio 25: averigua el número de alquileres registrados por mes.
select count("rental_id") as "Numero_alquileres" , date_trunc('month',"rental_date") as "Mes" 
from "rental"
group by date_trunc('month',"rental_date");

--Ejercicio 26: encuentra el promedio, la desviación estándar y varianza del total pagado.
select avg("amount") as "Promedio", stddev("amount") as "Desviacion_estandar" , variance("amount") as "Varianza"
from "payment";

--Ejercicio 27: ¿Qué películas se alquilan por encima del precio medio?
select "title" as "Nombre_pelicula", "rental_rate" as "Precio"
from "film"
where "rental_rate" > (
       select round(avg("rental_rate"),2)
       from "film"
);

--Ejercicio 28: muestra el id de los actores que hayan participado en más de 40 películas.
select "actor_id",count("film_id") as "Numero_peliculas"
from "film_actor"
group by "actor_id"
having count("film_id") > 40;

--Ejercicio 29: obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select f."title", count(i."film_id") as "Cantidad"
from "film" as f
left join "inventory" as i
on f."film_id" = i."film_id"
group by f."film_id";

--Ejercicio 30: obtener los actores y el número de películas en las que ha actuado.
select concat(a."first_name", ' ',a."last_name") as "Nombre_actores" , count(distinct (fa."film_id")) as "Numero_peliculas"
from "actor" as a
inner join "film_actor" as fa 
on a."actor_id" = fa."actor_id"
group by concat(a."first_name", ' ',a."last_name");

//*Ejercicio 31: obtener todas las películas y mostrar los actores que han actuado en 
ellas, incluso si algunas películas no tienen actores asociados.*//
select f."title" as "Nombre_pelicula", concat(a."first_name", ' ',a."last_name") as "Nombre_actores"
from "film" as f
left join "film_actor" as fa 
on f."film_id" = fa."film_id"
left join "actor" as a
on fa."actor_id"=a."actor_id"
order by f."title";

//*Ejercicio 32: obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película.*//
select concat(a."first_name", ' ', a."last_name") as "Nombre_actores", f."title"
from "actor" as a
left join "film_actor" as fa
on a."actor_id" = fa."actor_id"
left join "film" as f
on fa."film_id" =f."film_id";

-- Ejercicio 33: obtener todas las películas que tenemos y todos los registros de alquiler.
select f."title" as "Titulo_pelicula", r."rental_id", r."rental_date", r."return_date",
    r."customer_id", r."staff_id"
from "film" as f
left join "inventory" as i 
on f."film_id" = i."film_id"
left join "rental" as r 
on i."inventory_id" = r."inventory_id"
order by f."title", r."rental_date";

--Ejercicio 34: encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select concat(c."first_name", ' ',c."last_name") as "Nombre_clientes", sum(p."amount") as "Total_gastado"
from "customer" as c
inner join "rental" as r
on c."customer_id" = r."customer_id"
inner join "payment" as p
on r."rental_id" = p."rental_id"
group by concat(c."first_name", ' ',c."last_name")
order by "Total_gastado" desc
limit 5;

--Ejercicio 35: selecciona todos los actores cuyo primer nombre es 'Johnny'.
select "first_name", "last_name" 
from "actor"
where "first_name" = 'JOHNNY';

--Ejercicio 36: renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
select "first_name" as "Nombre", "last_name" as "Apellido"
from "actor";

--Ejercicio 37: encuentra el ID del actor más bajo y más alto en la tabla actor.
select min("actor_id") as "ID_bajo", max("actor_id") as "ID_alto"
from "actor";

--Ejercicio 38: cuenta cuántos actores hay en la tabla “actorˮ.
select count(*) as "Numero_actores"
from "actor";

 --Ejercicio 39: selecciona todos los actores y ordénalos por apellido en orden ascendente.
select "first_name", "last_name" 
from "actor"
order by "last_name" asc; 

--Ejercicio 40: selecciona las primeras 5 películas de la tabla “filmˮ.
select "title" 
from "film"
limit 5;

--Ejercicio 41: agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select "first_name", count("first_name") as "Numero_actores"
from "actor"
group by "first_name"
order by "Numero_actores" desc;

--Ejercicio 42: encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r."rental_id", f."title" as "Nombre_alquiler", concat(c."first_name", ' ', c."last_name") as "Nombre_cliente"
from "rental" as r 
left join "customer" as c 
on r."customer_id" = c."customer_id"
left join "inventory" as i 
on r."inventory_id" =i."inventory_id" 
left join "film" as f 
on i."film_id" =f."film_id"
ORDER BY r."rental_id";

--Ejercicio 43: muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select concat(c."first_name", ' ', c."last_name") as "Nombre_cliente", f."title" as "Pelicula_alquilada"
from "customer" as c 
left join "rental" as r
on c."customer_id" = r."customer_id"
left join "inventory" as i 
on r."inventory_id" =i."inventory_id" 
left join "film" as f 
on i."film_id" =f."film_id"
order by "Nombre_cliente";

//*Ejercicio 44: realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta?
¿Por qué? Deja después de la consulta la contestación.*//
select*
from "film" as f
cross join "category" as c;

--Esta consulta lo que hace es multiplicar cada fila de la tabla "film" por cada una de las filas de la tabla "category"

--Ejercicio 45: encuentra los actores que han participado en películas de la categoría 'Action'.
select concat(a."first_name", ' ',a."last_name") as "Nombre_actores", c."name" as "Categoria"	
from "actor" as a 
inner join "film_actor" as fa 
on a."actor_id" =fa."actor_id" 
inner join "film" as f 
on fa."film_id" = f."film_id"
inner join "film_category" as fc
on f."film_id"=fc."film_id"
inner join "category" as c
on fc."category_id" = c."category_id"
where c."name"= 'Action';

--Ejercicio 46: encuentra todos los actores que no han participado en películas.
select concat(a."first_name", ' ',a."last_name") as "Nombre_actores"
from "actor" as a
left join "film_actor" as fa
on a."actor_id"= fa."actor_id"
where fa."film_id" is null;

--Ejercicio 47: selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select concat(a."first_name", ' ',a."last_name") as "Nombre_actores", count(distinct fa."film_id") as "Numero_peliculas"
from "actor" as a
left join "film_actor" as fa
on a."actor_id"= fa."actor_id"
group by concat(a."first_name", ' ',a."last_name");

//* Ejercicio 48: crea una vista llamada “actor_num_peliculasˮ que muestre los nombres 
de los actores y el número de películas en las que han participado.*//
create view "actor_num_peliculas" as 
select concat(a."first_name", ' ',a."last_name") as "Nombre_actor", count(distinct "film_id") "Numero_peliculas"
from "actor" as a
inner join "film_actor" as fa 
on a."actor_id" = fa."actor_id"
group by concat(a."first_name", ' ',a."last_name");

select*
from actor_num_peliculas;

--Ejercicio 49: calcula el número total de alquileres realizados por cada cliente.
select concat(c."first_name", ' ',c."last_name") as "Nombre_cliente", count(distinct(r."rental_id")) as "Numero_alquileres"
from "customer" as c 
left join "rental" as r
on c."customer_id" = r."customer_id"
group by concat(c."first_name", ' ',c."last_name");

--Ejercicio 50: calcula la duración total de las películas en la categoría 'Action'.
select c."name" as "Categoria", sum(f."length") as "Duracion_total" 
from "film" as f
inner join "film_category" as fc 
on f."film_id" = fc."film_id"
inner join "category" as c
on fc."category_id" = c."category_id"
where c."name" ='Action'
group by c."name";

--Ejercicio 51: crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
create temporary table "cliente_rentas_temporal" as
select concat(c."first_name", ' ',c."last_name") as "Nombre_clientes", count(distinct r."rental_id") as "Numero_alquileres"
from "customer" as c
inner join "rental" as r
on c."customer_id" = r."customer_id"
group by concat(c."first_name", ' ',c."last_name");

select *
from "cliente_rentas_temporal";

//*Ejercicio 52: crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido 
alquiladas al menos 10 veces*//
create temporary table "peliculas_alquiladas" as
select f."title" as "Titulo_peliculas", count(r."inventory_id") as "Numero_alquiler"
from "film" as f 
inner join "inventory" as i 
on f."film_id"=i."film_id"
inner join "rental" as r 
on i."inventory_id"=r."inventory_id"
group by f."title"
having count(r."inventory_id") >= 10;

select *
from "peliculas_alquiladas"

//*Ejercicio 53: encuentra el título de las películas que han sido alquiladas por el cliente 
con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.*//
select distinct f."title"
from "customer" as c
inner join "rental" as r 
on c."customer_id" = r."customer_id"
inner join "inventory" as i 
on r."inventory_id" = i."inventory_id"
inner join "film" as f 
on i."film_id" = f."film_id"
where c."first_name" = 'Tammy' 
and c."last_name" = 'Sanders'
and r."return_date" IS NULL
order by f."title";

//* Ejercicio 54: encuentra los nombres de los actores que han actuado en al menos una 
película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.*//
select distinct a."first_name", a."last_name"
from "actor" as a
inner join "film_actor" as fa 
on a."actor_id" = fa."actor_id"
inner join "film_category" as fc 
on fa."film_id" = fc."film_id"
inner join "category" as c 
on fc."category_id" = c."category_id"
where c."name" = 'Sci-Fi'
order by a."last_name";

//* Ejercicio 55: encuentra el nombre y apellido de los actores que han actuado en 
películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados 
alfabéticamente por apellido.*//
select distinct a."first_name", a."last_name"
from "actor" as a
inner join "film_actor" as fa 
on a."actor_id" = fa."actor_id"
inner join "inventory" as i 
on fa."film_id" = i."film_id"
inner join "rental" as r 
on i."inventory_id" = r."inventory_id"
where r."rental_date" > (
    select min(r2."rental_date")
    from "film" as f2
    inner join "inventory" as i2 
    on f2."film_id" = i2."film_id"
    inner join "rental" as r2 
    on i2."inventory_id" = r2."inventory_id"
    where f2."title" = 'Spartacus Cheaper'
)
order by a."last_name";

--Ejercicio 56: encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
select CONCAT(a.first_name, ' ', a.last_name) AS nombre_actor
from "actor" as a
where a."actor_id" not in (
    select fa."actor_id"
    from "film_actor" as fa
    inner join "film_category" as fc 
    on fa."film_id" = fc."film_id"
    inner join "category" as c 
    on fc."category_id" = c."category_id"
    where c."name" = 'Music'
);

--Ejercicio 57: encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct f."title"
from "rental" as r
inner join "inventory" as i 
on r."inventory_id" = i."inventory_id"
inner join "film" as f 
on i."film_id" = f."film_id"
where "return_date" is not null
and "return_date" - "rental_date" > INTERVAL '8 days'
order by f."title";

--Ejercicio 58: encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
select f."title" as "Titulo_pelicula", c."name" as "Categoria"
from "film" as f
inner join "film_category" as fc 
on f."film_id" = fc."film_id"
inner join "category" as c
on fc."category_id" = c."category_id"
where c."name"= 'Animation';

//*Ejercicio 59: encuentra los nombres de las películas que tienen la misma duración 
que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.*//
select "title" as "Nombre_pelicula"
from "film"
where "length" = (
      select "length"
      from "film"
     where "title" = 'DANCING FEVER'
)
order by "title";

--Ejercicio 62: encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as "Categoria", count(f."film_id") as "Numero_peliculas" 
from "film" as f
inner join "film_category" as fc
on f."film_id" = fc."film_id"
inner join "category" as c
on fc."category_id" = c."category_id"
where f."release_year"= 2006
group by c."name";

--Ejercicio 63: obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select concat(s."first_name", ' ',s."last_name") as "Trabajador", st."store_id"
from "staff" as s
cross join "store" as st
order by "Trabajador", st."store_id";

//*Ejercicio 64: encuentra la cantidad total de películas alquiladas por cada cliente y 
muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas*//
select c."customer_id", concat(c."first_name", ' ',c."last_name") as "Nombre_cliente", 
       count(distinct r."rental_id") as "Peliculas_alquiladas" 
from "customer" as c
left join "rental" as r
on c."customer_id" = r."customer_id"
group by c."customer_id", concat(c."first_name", ' ',c."last_name");
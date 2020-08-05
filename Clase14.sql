use sakila;

#1
SELECT c.first_name, c.last_name, a.address, c2.city 
FROM customer c
INNER JOIN address a
	ON c.address_id = a.address_id
INNER JOIN city c2 
	ON a.city_id = c2.city_id
INNER JOIN country c3 
	ON c2.country_id = c3.country_id 
WHERE c3.country LIKE '%Argentina%';

#2
SELECT f.title, l.name, f.rating  
FROM film f 
INNER JOIN `language` l 
	ON f.language_id = l.language_id;

#3
SELECT a.first_name, a.last_name, f.title, f.release_year
FROM film_actor fa 
INNER JOIN actor a
	ON fa.actor_id = a.actor_id 
INNER JOIN film f 
	ON fa.film_id = f.film_id ;

	
#4
SELECT f.title, c2.first_name, c2.last_name, r.return_date 
FROM rental r
INNER JOIN customer c2 
	ON r.customer_id = c2.customer_id 
INNER JOIN inventory i2 
	ON r.inventory_id = i2.inventory_id 
INNER JOIN film f 
	ON i2.film_id = f.film_id 
WHERE r.rental_date BETWEEN 2005-05 AND 2005-06;

#5
#CAST O CONVERT lo podemos usar para convertir en la tabla film release_year a datatime.

#6
#IFNULL permite devolver un valor alternativo cuando la expresion es NULL 
#(Por ejemplo cuando una pelicula no fue devuelta y entrega un valor NULL podemos mostrar otra cosa)
#NLV no es usado en sql
# COALESCE devuelve el primer valor no nulo de una lista
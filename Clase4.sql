use sakila;

#Show title and special_features of films that are PG-13.
SELECT title, special_features, rating 
FROM film 
WHERE rating = 'PG-13';

#Get a list of all the different films duration.
SELECT title , `length` 
FROM film;

#Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00.
SELECT title, rental_rate, replacement_cost 
FROM film 
WHERE replacement_cost BETWEEN 20.00 AND 24.00;

#Show title, category and rating of films that have 'Behind the Scenes' as special_features
SELECT f.title, f.rating, f.special_features, c.name 
FROM film f, category c 
WHERE special_features LIKE '%Behind the Scenes';

#Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
SELECT first_name, last_name, f.title 
FROM actor a, film_actor fa, film f
WHERE a.actor_id = fa.actor_id 
and fa.film_id = f.film_id 
and f.title = 'ZOOLANDER FICTION';

#Show the address, city and country of the store with id 1
SELECT c.country, c2.city, a.address
FROM country c, city c2, address a
WHERE c.country_id = 1
and c2.city_id = 1
and a.address_id = 1;

#Show pair of film titles and rating of films that have the same rating.
SELECT  f.title, f.rating 
FROM film f, film f2 
WHERE f.title LIKE 'A%'
AND f.rating = f2.rating; 

#Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
SELECT s.store_id, s2.first_name, s2.last_name, f.title 
FROM store s, staff s2, film f
WHERE s.store_id = 2;






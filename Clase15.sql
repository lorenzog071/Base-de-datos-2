use sakila;


#1
CREATE OR REPLACE VIEW list_of_customers
SELECT c2.customer_id, c2.first_name, c2.last_name, a2.address, a2.postal_code, a2.phone, c3.city, c4.country, s2.store_id  
FROM customer c2, address a2, city c3, country c4, store s2 ; 
  
#2
CREATE OR REPLACE VIEW film_details 
SELECT f.film_id, f.title, f.description, c.name, f.rental_rate, f.`length`, f.rating, group_concat (a.last_name )
FROM film f, actor a, category c, film_category fc 
WHERE f.film_id = fc.film_id 
and fc.category_id = c.category_id ;

#3
ALTER VIEW sales_by_film_category 
SELECT c.name, f2.rental_rate 
FROM category c, film f2; 

#4
CREATE OR REPLACE VIEW actor_information AS
SELECT a.first_name, a.last_name, f.title 
FROM film f, actor a, film_actor fa
WHERE a.actor_id = fa.actor_id 
and fa.film_id = f.film_id; 

#5
# Primero nos crea la vista actor_info y nos trae el actor_id, nombre, apellido de cada actor
# Despues con un GROUP_CONCAT nos hace una tabla para mostrar la categoria y luego el nombre de la pelicula de cada actor


#6
# Las materialized views cuando se produce una se almacena en algun lugar (por lo general en una tabla)
# y se usan cuando se necesita una respuesta rapida. MYSQL no posee materialized views pero se pueden construir.
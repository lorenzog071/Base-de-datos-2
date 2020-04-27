use sakila;

#List all the actors that share the last name. Show them in order
SELECT DISTINCT a.first_name, a.last_name 
FROM actor a, actor a2 
WHERE a.last_name = a2.last_name 
ORDER BY a.last_name; 

#Find actors that don't work in any film
SELECT actor_id, first_name, last_name 
FROM actor 
WHERE NOT EXISTS ( SELECT actor_id FROM film_actor 
);

#Find customers that rented only one film
SELECT first_name, last_name 
FROM customer 
WHERE (SELECT COUNT(*)
	   FROM rental r, customer c
	   WHERE c.customer_id = r.customer_id) = 1 ;
	  
#Find customers that rented more than one film
SELECT first_name, last_name 
FROM customer 
WHERE (SELECT COUNT(*)
	   FROM rental r , customer c 
	   WHERE c.customer_id = r.customer_id) > 1 ;
	  

	  
	 


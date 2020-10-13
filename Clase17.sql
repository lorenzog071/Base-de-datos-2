/*1*/
select postal_code from address where postal_code IN (select postal_code from address 
inner join city using(city_id)
inner join country using(country_id)
where country like('%Philippines%'));
/*4ms*/

select postal_code from address where postal_code NOT IN (select postal_code from address 
inner join city using(city_id)
inner join country using(country_id)
where country like('%Brazil%'));
/*4ms*/

SELECT postal_code FROM address;  
/*4ms*/
CREATE INDEX postal_code ON address(postal_code);

/*El tiempo de ejecucion bajo por 1ms en todos lo casos tal vez sea poco pero tecnicamente el tiempo de ejecucion bajo un 25% es decir que los 
indices bajan el tiempo de ejecucion de las queries de manera significativa*/
/*2*/
select first_name from film 
inner join film_actor using(film_id)
inner join actor using(actor_id)
where first_name like('A%');
/*6ms*/
select last_name from film 
inner join film_actor using(film_id)
inner join actor using(actor_id)
where last_name like('A%');
/*2ms*/
/*La razon por la que la query de last name es mas rapida es porque lastname tiene un index y firstname no*/
ALTER TABLE film_text 
ADD FULLTEXT(description);

SELECT description
FROM film_text
WHERE MATCH(description) AGAINST('Dentist');
/*2ms*/
SELECT description
FROM film
WHERE description like ('%Dentist%');
/*5ms*/

/*Match against es mucho mas rapido que buscar por like */
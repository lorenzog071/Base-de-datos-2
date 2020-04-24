CREATE database if not exists imdb;

use imdb; 

CREATE table if not exists film (
	film_id int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`film_id`),
	title varchar(100),
	description varchar(255),
	release_year year(4)
);

CREATE table if not exists actor(
	actor_id int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`actor_id`),
	first_name varchar(50),
	last_name varchar(50)
);

CREATE table if not exists film_actor(
	actor_id int NOT NULL,
	film_id int NOT NULL
);

ALTER table film 
add last_update_film int;

ALTER table actor 
add last_update_actor int;

INSERT INTO film (title, description, release_year, last_update_film)
VALUES  ('Rapido  y Furioso', 'Autos', '2001', '2019'  );

INSERT INTO actor (first_name, last_name, last_update_actor)
VALUES( 'Brian', 'O´conner', '0');

INSERT INTO film_actor (actor_id, film_id)
VALUES('1', '1')

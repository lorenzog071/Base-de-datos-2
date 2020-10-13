use sakila;
CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 

(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),

(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),

(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

/*Insert a new employee to , but with an null email. Explain what happens.
 */
insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 
(420,'Clown','Marcus','x6969',NULL,'666',NULL,'Certified_clown')
/*Como la linea email tiene un not null cuando la creas no podes */

UPDATE employees SET employeeNumber = employeeNumber - 20
/* cambia el employee number restando 20*/
UPDATE employees SET employeeNumber = employeeNumber + 20

ALTER TABLE employees 
    ADD AGE INT ;


 /*Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.*/
CREATE TRIGGER insert_employees BEFORE 
INSERT ON employees
FOR EACH ROW 
    BEGIN 
        IF NOT NEW.AGE BETWEEN 17 AND 70 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Solo se aceptan empleado de 17 a 70 años de edad';
    END IF;
    END;

ALTER TABLE employees
  ADD age INT

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`,`age`) values 
(423,'Clown','Marcus','x6969','clownmarcus@circus.com','666',NULL,'Certified_clown',6)


/*4)La relacion entre la tabla actor y film es una de many to many ya que un actor úede actuar en muchas peliculas y las peliculas tienen varios actores.
 * Como la relacion es de muchos a muchos se requiere de una tabla intermedia llevando a la creacion de la tabla film_actor que es la tabla intermedia
 * con una id hacia la film y otra hacia el actor y esta relacion debe ser many to many porque si no lo fuera tendria que agregar unafield actor en film relacionada a la id del actor por cada
 * actor que actue en la pelicula generando una redundancia de datos*/
 
/*Create a new column called lastUpdate to table employee 
 * and use trigger(s) to keep the date-time updated on inserts and updates operations. Bonus: add a column lastUpdateUser and the respective 
 * trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, can connect to MySQL and change this table).*/


ALTER TABLE employees
  ADD last_update DATETIME DEFAULT NULL;
ALTER TABLE employees
  ADD lastUpdateUser varchar(255) DEFAULT NULL;

/*DATE*/ 
CREATE TRIGGER insert_last_update BEFORE 
INSERT ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.last_update = CURRENT_TIMESTAMP(); 
    END;
   
CREATE TRIGGER update_last_update BEFORE 
UPDATE ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.last_update = CURRENT_TIMESTAMP(); 
    END;
/*USER*/
CREATE TRIGGER insert_lastUpdateUser BEFORE 
INSERT ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.lastUpdateUser = USER();
    END;

CREATE TRIGGER update_lastUpdateUser BEFORE 
UPDATE ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.lastUpdateUser = USER();
    END;
insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`,`age`) values 
(1,'super_clown','QUESO','x6969','clownqueso@circus.com','666',NULL,'Certified_clown',69);
UPDATE employees SET firstName = 'Super_Clown' WHERE employeeNumber = 423;

/*Find all the triggers in sakila db related to loading film_text table. What do they do? Explain each of them using its source code for the explanation.*/

CREATE DEFINER=`root`@`localhost` TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END
  
/*El trigger ins_film lo que hace es que cuando se realiza un insert a la tabla film,inserta en la tabla film_text la id,titulo y descripcion del insert que se realizo a film
 * Es decir inserta en la tabla film_text los datos que se insertaron a film de forma automatica*/
  
CREATE DEFINER=`root`@`localhost` TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END
/*El trigger upd_film lo que hace es que cuando se realize un update a la tabla film actualiza la tabla film_text con los nuevos datos asi que cuando cambias el titulo de una pelicula se cambia
 * el titulo de esa pelicula en actualizada en la tabla film_text tambien*/
CREATE DEFINER=`root`@`localhost` TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
/*El trigger del_film lo que hace es que cuando se quiera borrar una pelicula de la tabla film lo que hace es borrar esa misma pelicula en la tabla film_text */

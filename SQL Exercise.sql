-- SQL Practice - Part 1 (with sakila database)

SHOW TABLES FROM sakila;

DESCRIBE sakila.actor;

SHOW CREATE TABLE sakila.actor;

SELECT first_name, last_name FROM sakila.actor;

SELECT first_name, last_name FROM sakila.actor WHERE last_name = 'Johansson';

SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS `Actor Name` FROM sakila.actor;

SELECT actor_id, first_name, last_name FROM sakila.actor WHERE first_name = 'Joe';

SELECT last_name 
FROM sakila.actor 
GROUP BY last_name 
HAVING COUNT(last_name) = 1;

SELECT last_name, COUNT(*) AS actor_count 
FROM sakila.actor 
GROUP BY last_name;

SELECT s.first_name, s.last_name, a.address 
FROM sakila.staff s 
JOIN sakila.address a 
ON s.address_id = a.address_id;


-- SQL practice part 1 (world database)

SELECT * FROM world.city LIMIT 10;

SELECT * FROM world.city LIMIT 15, 5;

SELECT COUNT(*) FROM world.city;

SELECT name, population 
FROM world.city 
ORDER BY population DESC 
LIMIT 1;

SELECT name, population 
FROM world.city 
ORDER BY population ASC 
LIMIT 1;

SELECT name 
FROM world.city 
WHERE population BETWEEN 670000 AND 700000;

SELECT name, population 
FROM world.city 
ORDER BY population DESC 
LIMIT 10;

SELECT name 
FROM world.city 
ORDER BY name 
LIMIT 10;

SELECT district 
FROM world.city 
WHERE population > 3000000 AND countrycode = 'USA';

SELECT id, name, population 
FROM world.city 
WHERE id IN (5, 23, 432, 2021);

-- SQL Exercise part 2 (sakila)

SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count
FROM sakila.actor
JOIN sakila.film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY film_count DESC
LIMIT 1;

SELECT category.name AS category_name, AVG(film.length) AS average_length
FROM sakila.category
JOIN sakila.film_category ON category.category_id = film_category.category_id
JOIN sakila.film ON film_category.film_id = film.film_id
GROUP BY category.name;


























 



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













 



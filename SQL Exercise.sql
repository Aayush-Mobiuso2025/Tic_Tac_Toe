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

SELECT category.name AS category_name, AVG(film.length) AS average_length
FROM sakila.category
JOIN sakila.film_category ON category.category_id = film_category.category_id
JOIN sakila.film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING average_length > 120;

SELECT COUNT(*) 
FROM sakila.inventory 
WHERE film_id = (SELECT film_id FROM sakila.film WHERE title = 'Hunchback Impossible');

SELECT sakila.customer.first_name, sakila.customer.last_name, SUM(sakila.payment.amount) AS total_paid
FROM sakila.customer
JOIN sakila.payment 
ON sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY sakila.customer.customer_id, sakila.customer.first_name, sakila.customer.last_name
ORDER BY sakila.customer.last_name;

-- SQL exercise part 2 (world)

SELECT code, name, continent, gnp 
FROM world.country 
ORDER BY gnp DESC 
LIMIT 2 OFFSET 1;

SELECT code, name, continent, gnp 
FROM world.country 
WHERE name LIKE '% d%';

-- Execute new tables in new database.

CREATE DATABASE company_DB;
USE company_DB;


CREATE TABLE IF NOT EXISTS `departments` ( 
  `DEPARTMENT_ID` decimal(4,0) NOT NULL DEFAULT '0', 
  `DEPARTMENT_NAME` varchar(30) NOT NULL, 
  `MANAGER_ID` decimal(6,0) DEFAULT NULL, 
  `LOCATION_ID` decimal(4,0) DEFAULT NULL, 
  PRIMARY KEY (`DEPARTMENT_ID`), 
  KEY `DEPT_MGR_FK` (`MANAGER_ID`), 
  KEY `DEPT_LOCATION_IX` (`LOCATION_ID`) 
);

CREATE TABLE IF NOT EXISTS `employees` ( 
  `EMPLOYEE_ID` decimal(6,0) NOT NULL DEFAULT '0', 
  `FIRST_NAME` varchar(20) DEFAULT NULL, 
  `LAST_NAME` varchar(25) NOT NULL, 
  `EMAIL` varchar(25) NOT NULL, 
  `PHONE_NUMBER` varchar(20) DEFAULT NULL, 
  `HIRE_DATE` date NOT NULL, 
  `JOB_ID` varchar(10) NOT NULL, 
  `SALARY` decimal(8,2) DEFAULT NULL, 
  `COMMISSION_PCT` decimal(2,2) DEFAULT NULL, 
  `MANAGER_ID` decimal(6,0) DEFAULT NULL, 
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL, 
  PRIMARY KEY (`EMPLOYEE_ID`), 
  UNIQUE KEY `EMP_EMAIL_UK` (`EMAIL`), 
  KEY `EMP_DEPARTMENT_IX` (`DEPARTMENT_ID`), 
  KEY `EMP_JOB_IX` (`JOB_ID`), 
  KEY `EMP_MANAGER_IX` (`MANAGER_ID`), 
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`) 
);

INSERT INTO `departments` (`DEPARTMENT_ID`, `DEPARTMENT_NAME`, `MANAGER_ID`, `LOCATION_ID`) VALUES 
('10', 'Administration', '200', '1700'), 
('20', 'Marketing', '201', '1800'), 
('30', 'Purchasing', '114', '1700'), 
('40', 'Human Resources', '203', '2400'), 
('50', 'Shipping', '121', '1500'), 
('60', 'IT', '103', '1400'), 
('70', 'Public Relations', '204', '2700'), 
('80', 'Sales', '145', '2500'), 
('90', 'Executive', '100', '1700'), 
('100', 'Finance', '108', '1700'), 
('110', 'Accounting', '205', '1700'), 
('120', 'Treasury', '0', '1700'), 
('130', 'Corporate Tax', '0', '1700'), 
('140', 'Control And Credit', '0', '1700'), 
('150', 'Shareholder Services', '0', '1700'), 
('160', 'Benefits', '0', '1700'), 
('170', 'Manufacturing', '0', '1700'), 
('180', 'Construction', '0', '1700'), 
('190', 'Contracting', '0', '1700'), 
('200', 'Operations', '0', '1700'), 
('210', 'IT Support', '0', '1700'), 
('220', 'NOC', '0', '1700'), 
('230', 'IT Helpdesk', '0', '1700'), 
('240', 'Government Sales', '0', '1700'), 
('250', 'Retail Sales', '0', '1700'), 
('260', 'Recruiting', '0', '1700'), 
('270', 'Payroll', '0', '1700');


INSERT INTO `employees` (`EMPLOYEE_ID`, `FIRST_NAME`, `LAST_NAME`, `EMAIL`, `PHONE_NUMBER`, `HIRE_DATE`, `JOB_ID`, `SALARY`, `COMMISSION_PCT`, `MANAGER_ID`, `DEPARTMENT_ID`) VALUES 
('100', 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', '24000.00', '0.00', '0', '90'), 
('101', 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1987-06-18', 'AD_VP', '17000.00', '0.00', '100', '90'), 
('102', 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1987-06-19', 'AD_VP', '17000.00', '0.00', '100', '90'), 
('103', 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1987-06-20', 'IT_PROG', '9000.00', '0.00', '102', '60'), 
('104', 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1987-06-21', 'IT_PROG', '6000.00', '0.00', '103', '60'), 
('105', 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1987-06-22', 'IT_PROG', '4800.00', '0.00', '103', '60'), 
('106', 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1987-06-23', 'IT_PROG', '4800.00', '0.00', '103', '60'), 
('107', 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1987-06-24', 'IT_PROG', '4200.00', '0.00', '103', '60'), 
('108', 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1987-06-25', 'FI_MGR', '12000.00', '0.00', '101', '100'), 
('109', 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1987-06-26', 'FI_ACCOUNT', '9000.00', '0.00', '108', '100'), 
('110', 'John', 'Chen', 'JCHEN', '515.124.4269', '1987-06-27', 'FI_ACCOUNT', '8200.00', '0.00', '108', '100'), 
('111', 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '1987-06-28', 'FI_ACCOUNT', '7700.00', '0.00', '108', '100'), 
('112', 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '1987-06-29', 'FI_ACCOUNT', '7800.00', '0.00', '108', '100'), 
('113', 'Luis', 'Popp', 'LPOPP', '515.124.4567', '1987-06-30', 'FI_ACCOUNT', '6900.00', '0.00', '108', '100'), 
('114', 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '1987-07-01', 'PU_MAN', '11000.00', '0.00', '100', '30'), 
('115', 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '1987-07-02', 'PU_CLERK', '3100.00', '0.00', '114', '30'), 
('116', 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '1987-07-03', 'PU_CLERK', '2900.00', '0.00', '114', '30'), 
('117', 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '1987-07-04', 'PU_CLERK', '2800.00', '0.00', '114', '30');


SELECT * FROM employees;
SELECT * FROM departments;

SELECT EMPLOYEE_ID, FIRST_NAME 
FROM employees 
WHERE DEPARTMENT_ID = (
    SELECT DEPARTMENT_ID 
    FROM departments 
    WHERE DEPARTMENT_ID = 100
);

SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SALARY 
FROM employees 
GROUP BY DEPARTMENT_ID 
HAVING MAX(SALARY) > (
    SELECT AVG(SALARY) 
    FROM employees
);

SELECT DISTINCT d.DEPARTMENT_NAME, d.DEPARTMENT_ID 
FROM departments d 
WHERE d.DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID 
    FROM employees 
    WHERE SALARY < 35000
);























 



USE orders;
SHOW TABLES;

DESCRIBE product;
DESCRIBE carton;
DESCRIBE order_items;
DESCRIBE order_header;
DESCRIBE address;
DESCRIBE product_class;

select * from product;
select * from address;
select * from carton;
select * from online_customer;
select * from order_header;
select * from order_items;
select * from product;
select * from product_class;
select * from shipper;

-- Q 3 Query to Show the count of cities in all countries other than USA & MALAYSIA, with more than 1 city, in the descending order of CITIES.

SELECT 
    address.country AS country, 
    COUNT(address.city) AS city_count
FROM address
WHERE address.country NOT IN ('USA', 'Malaysia')
GROUP BY address.country
HAVING COUNT(address.city) > 1
ORDER BY city_count DESC;



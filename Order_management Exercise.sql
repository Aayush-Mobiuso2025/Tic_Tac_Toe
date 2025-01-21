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

-- Q 9 Query to display the order_id, customer id and customer full name of customers along with (product_quantity) as total quantity of products shipped for order ids > 10060.

SELECT 
    order_header.order_id,
    online_customer.customer_id,
    CONCAT(online_customer.customer_fname, ' ', online_customer.customer_lname) AS customer_full_name,
    SUM(order_items.product_quantity) AS total_quantity
FROM online_customer
JOIN order_header ON online_customer.customer_id = order_header.customer_id
JOIN order_items ON order_header.order_id = order_items.order_id
WHERE order_header.order_id > 10060
GROUP BY order_header.order_id;

-- Q8 customers who bought more than 10 products.

SELECT 
    online_customer.customer_id, 
    CONCAT(online_customer.customer_fname, ' ', online_customer.customer_lname) AS customer_full_name,
    order_header.order_id,
    SUM(order_items.product_quantity) AS total_quantity
FROM online_customer
JOIN order_header ON online_customer.customer_id = order_header.customer_id
JOIN order_items ON order_header.order_id = order_items.order_id
GROUP BY online_customer.customer_id, order_header.order_id
HAVING total_quantity > 10;

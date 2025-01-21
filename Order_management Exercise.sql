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

-- Q 1 query to Display the product details (product_class_code, product_id, product_desc, product_price,) as per the following criteria and sort them in descending order of category: a. If the category is 2050, increase the price by 2000 b. If the category is 2051, increase the price by 500 c. If the category is 2052, increase the price by 600. 

SELECT 
    product_class_code, 
    product_id, 
    product_desc, 
    product_price,
    CASE 
        WHEN product_class_code = 2050 THEN product_price + 2000
        WHEN product_class_code = 2051 THEN product_price + 500
        WHEN product_class_code = 2052 THEN product_price + 600
        ELSE product_price
    END AS adjusted_price
FROM product
ORDER BY product_class_code DESC;

-- Q 4 query to display the customer_id,customer full name ,city,pincode,and order details (order id, product class desc, product desc, subtotal(product_quantity * product_price)) for orders shipped to cities whose pin codes do not have any 0s in them.

SELECT 
    online_customer.customer_id,
    CONCAT(online_customer.customer_fname, ' ', online_customer.customer_lname) AS customer_full_name,
    address.city,
    address.pincode,
    order_header.order_id,
    product_class.product_class_desc,
    product.product_desc,
    (order_items.product_quantity * product.product_price) AS subtotal
FROM online_customer
JOIN address ON online_customer.address_id = address.address_id
JOIN order_header ON online_customer.customer_id = order_header.customer_id
JOIN order_items ON order_header.order_id = order_items.order_id
JOIN product ON order_items.product_id = product.product_id
JOIN product_class ON product.product_class_code = product_class.product_class_code
WHERE address.pincode NOT LIKE '%0%'
ORDER BY customer_full_name, subtotal;



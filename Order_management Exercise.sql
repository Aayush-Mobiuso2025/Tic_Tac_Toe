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
WHERE order_header.order_id > 10060 AND order_header.order_status = "shipped"
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
WHERE order_header.order_status = "shipped"
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
WHERE address.pincode NOT LIKE '%0%' AND order_header.order_status = "shipped"
ORDER BY customer_full_name, subtotal;

-- 6 query to display the customer_id,customer name, email and order details (order id, product desc,product qty, subtotal(product_quantity * product_price)) for all customers even if they have not ordered any item.

SELECT 
    online_customer.customer_id,
    CONCAT(online_customer.customer_fname, ' ', online_customer.customer_lname) AS customer_full_name,
    online_customer.customer_email,
    order_header.order_id,
    product.product_desc,
    order_items.product_quantity,
    (order_items.product_quantity * product.product_price) AS subtotal
FROM online_customer
LEFT JOIN order_header ON online_customer.customer_id = order_header.customer_id
LEFT JOIN order_items ON order_header.order_id = order_items.order_id
LEFT JOIN product ON order_items.product_id = product.product_id;

-- Q 2 query to display (product_class_desc, product_id, product_desc, product_quantity_avail ) and Show inventory status of products as below as per their available quantity: a. For Electronics and Computer categories, if available quantity is <= 10, show 'Low stock', 11 <= qty <= 30, show 'In stock', >= 31, show 'Enough stock' b. For Stationery and Clothes categories, if qty <= 20, show 'Low stock', 21 <= qty <= 80, show 'In stock', >= 81, show 'Enough stock' c. Rest of the categories, if qty <= 15 – 'Low Stock', 16 <= qty <= 50 – 'In Stock', >= 51 – 'Enough stock' For all categories, if available quantity is 0, show 'Out of stock'.

SELECT 
    product_class.product_class_desc,
    product.product_id, 
    product.product_desc, 
    product.product_quantity_avail,
    CASE 
        WHEN product.product_quantity_avail = 0 THEN 'Out of stock'
        WHEN product_class.product_class_desc IN ('Electronics', 'Computer') THEN 
            CASE 
                WHEN product.product_quantity_avail <= 10 THEN 'Low stock'
                WHEN product.product_quantity_avail BETWEEN 11 AND 30 THEN 'In stock'
                ELSE 'Enough stock'
            END
        WHEN product_class.product_class_desc IN ('Stationery', 'Clothes') THEN 
            CASE 
                WHEN product.product_quantity_avail <= 20 THEN 'Low stock'
                WHEN product.product_quantity_avail BETWEEN 21 AND 80 THEN 'In stock'
                ELSE 'Enough stock'
            END
        ELSE 
            CASE 
                WHEN product.product_quantity_avail <= 15 THEN 'Low stock'
                WHEN product.product_quantity_avail BETWEEN 16 AND 50 THEN 'In stock'
                ELSE 'Enough stock'
            END
    END AS inventory_status
FROM product
JOIN product_class ON product.product_class_code = product_class.product_class_code;

-- 7 a query to display carton id, (len*width*height) as carton_vol and identify the optimum carton (carton with the least volume whose volume is greater than the total volume of all items (len * width * height * product_quantity)) for a given order whose order id is 10006, Assume all items of an order are packed into one single carton.

SELECT 
    carton.carton_id, 
    (carton.len * carton.width * carton.height) AS carton_volume
FROM carton
WHERE (carton.len * carton.width * carton.height) > (
    SELECT SUM(product.len * product.width * product.height * order_items.product_quantity) AS total_volume
    FROM order_items
    JOIN product ON order_items.product_id = product.product_id
    WHERE order_items.order_id = 10006
)
ORDER BY carton_volume ASC
LIMIT 1;

SELECT 
    carton.carton_id, 
    (carton.len * carton.width * carton.height) AS carton_volume
FROM carton
WHERE (carton.len * carton.width * carton.height) = (
    SELECT MAX(carton.len * carton.width * carton.height)
    FROM carton
    WHERE (carton.len * carton.width * carton.height) > (
        SELECT SUM(product.len * product.width * product.height * order_items.product_quantity) AS total_volume
        FROM order_items
        JOIN product ON order_items.product_id = product.product_id
        WHERE order_items.order_id = 10006
    )
);

-- Q 10 a query to display product class description ,total quantity (sum(product_quantity),Total value (product_quantity * product price) and show which class of products have been shipped highest(Quantity) to countries outside India other than USA? Also show the total value of those items.

SELECT 
    product_class.product_class_desc AS product_class_description,
    SUM(order_items.product_quantity) AS total_quantity,
    SUM(order_items.product_quantity * product.product_price) AS total_value
FROM product
JOIN product_class 
    ON product.product_class_code = product_class.product_class_code
JOIN order_items 
    ON product.product_id = order_items.product_id
JOIN order_header 
    ON order_items.order_id = order_header.order_id
JOIN online_customer 
    ON order_header.customer_id = online_customer.customer_id
JOIN address 
    ON online_customer.address_id = address.address_id
WHERE address.country NOT IN ('India', 'USA')
GROUP BY product_class.product_class_desc
ORDER BY total_quantity DESC
LIMIT 1;

-- Q 5 Write a Query to display product id,product description,totalquantity(sum(product quantity) for an item which has been bought maximum no. of times (Quantity Wise) along with product id 201. (USE SUB-QUERY) (1 ROW) [NOTE: ORDER_ITEMS TABLE, PRODUCT TABLE]

SELECT product.product_id,
       product.product_desc,
       SUM(order_items.product_quantity) AS total_quantity
       FROM product
JOIN order_items ON product.product_id = order_items.product_id
WHERE order_items.order_id IN (
SELECT order_id
FROM order_items
WHERE product_id =  201)
GROUP BY product.product_id
ORDER BY total_quantity DESC
LIMIT 1;




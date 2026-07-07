-- Q1. Create Olist Supply Chain Database
CREATE DATABASE olist_supply_chain;
USE olist_supply_chain;

-- Q2. Verify Current Database
SELECT DATABASE();

-- Q3. Verify Available Tables After Import
SHOW TABLES;

-- Q4. Count Total Imported Tables
SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'olist_supply_chain';

-- Q5. Verify Customers Table Exists

SELECT COUNT(*) AS total_customers
FROM customers;


-- Q6. Verify Orders Table Exists

SELECT COUNT(*) AS total_orders
FROM orders;


-- Q7. Verify Order Items Table Exists

SELECT COUNT(*) AS total_order_items
FROM order_items;


-- Q8. Verify Payments Table Exists

SELECT COUNT(*) AS total_payments
FROM payments;


-- Q9. Verify Reviews Table Exists

SELECT COUNT(*) AS total_reviews
FROM reviews;


-- Q10. Verify Products Table Exists

SELECT COUNT(*) AS total_products
FROM products;


-- Q11. Verify Sellers Table Exists

SELECT COUNT(*) AS total_sellers
FROM sellers;


-- Q12. Verify Category Translation Table Exists

SELECT COUNT(*) AS total_categories
FROM category_translation;


-- Q13. Verify Geolocation Table Exists

SELECT COUNT(*) AS total_geolocations
FROM geolocation;


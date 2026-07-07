-- Q1. What is the row count of each table?

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'category_translation', COUNT(*) FROM category_translation
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation;

-- Q2. Are there duplicate order IDs?

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Q3. Are there duplicate customer IDs?

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Q4. How many missing delivery dates exist?

SELECT
    COUNT(*) AS total_orders,
    SUM(order_delivered_customer_date IS NULL) AS null_delivery_dates
FROM orders;


-- Q5. What is the distribution of order statuses?

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q6. How many orders were delivered?

SELECT COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'delivered';

-- Q7. How many orders were cancelled?

SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'canceled';

-- Q8. How many products have missing category names?

SELECT COUNT(*) AS missing_categories
FROM products
WHERE product_category_name IS NULL;

-- Q9. Which columns in products table contain NULL values?
SELECT
    SUM(product_name_lenght IS NULL) AS missing_product_name_length,
    SUM(product_description_lenght IS NULL) AS missing_description_length,
    SUM(product_photos_qty IS NULL) AS missing_photos,
    SUM(product_weight_g IS NULL) AS missing_weight
FROM products;

-- Q10. How many review IDs appear more than once?
SELECT
    review_id,
    COUNT(*) AS duplicate_count
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

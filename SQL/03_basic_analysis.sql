-- Q1. How many total orders exist?
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q2. How many unique customers exist?
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- Q3. How many active sellers processed orders?
SELECT COUNT(DISTINCT seller_id) AS active_sellers
FROM order_items;

-- Q4. How many products are available?
SELECT COUNT(*) AS total_products
FROM products;

-- Q5. What is the total revenue generated?
SELECT ROUND(SUM(payment_value),2) AS total_revenue
FROM payments;

-- Q6. What is the average order value?
SELECT ROUND(AVG(payment_value),2) AS average_order_value
FROM payments;

-- Q7. What is the minimum, maximum and average payment value?
SELECT
    ROUND(MIN(payment_value),2) AS min_payment,
    ROUND(MAX(payment_value),2) AS max_payment,
    ROUND(AVG(payment_value),2) AS avg_payment
FROM payments;

-- Q8. Which payment methods are used most frequently?
SELECT
    payment_type,
    COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- Q9. Which order statuses occur most frequently?
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q10. What are the monthly order volumes?
SELECT
    DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- Q11. What are the yearly order volumes?
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_year
ORDER BY order_year;

-- Q12. Who are the top 10 repeat customers by number of orders?
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;

-- Q13. How many customers placed more than one order?

SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
) t;
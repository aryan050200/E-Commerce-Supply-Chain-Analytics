-- Q1. What is the cancellation rate?
SELECT ROUND(
       COUNT(CASE WHEN order_status='canceled' THEN 1 END)*100.0/COUNT(*),2)
       AS cancellation_rate_pct
FROM orders;

-- Q2. What is the delivery success rate?
SELECT ROUND(
       COUNT(CASE WHEN order_status='delivered' THEN 1 END)*100.0/COUNT(*),2)
       AS delivery_success_rate_pct
FROM orders;

-- Q3. What is the average delivery time?
SELECT ROUND(
       AVG(DATEDIFF(order_delivered_customer_date,
                    order_purchase_timestamp)),2)
       AS avg_delivery_days
FROM orders
WHERE order_status='delivered';

-- Q4. What is the average estimated delivery time?
SELECT ROUND(
       AVG(DATEDIFF(order_estimated_delivery_date,
                    order_purchase_timestamp)),2)
       AS avg_estimated_delivery_days
FROM orders;

-- Q5. What is the late delivery rate?
SELECT ROUND(
       COUNT(CASE
                WHEN order_delivered_customer_date >
                     order_estimated_delivery_date
                THEN 1
             END)*100.0/COUNT(*),2)
       AS late_delivery_rate_pct
FROM orders
WHERE order_status='delivered'
AND order_estimated_delivery_date IS NOT NULL
AND order_delivered_customer_date IS NOT NULL;

-- Q6. What is the on-time delivery rate?
SELECT ROUND(
       COUNT(CASE
                WHEN order_delivered_customer_date <=
                     order_estimated_delivery_date
                THEN 1
             END)*100.0/COUNT(*),2)
       AS on_time_delivery_rate_pct
FROM orders
WHERE order_status='delivered'
AND order_estimated_delivery_date IS NOT NULL
AND order_delivered_customer_date IS NOT NULL;

-- Q7. Which states have the longest delivery times?
SELECT c.customer_state,
       ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                          order_purchase_timestamp)),2)
       AS avg_delivery_days
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
WHERE o.order_status='delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;

-- Q8. Top 10 fastest sellers
SELECT oi.seller_id,
       ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                          order_purchase_timestamp)),2)
       AS avg_delivery_days
FROM order_items oi
JOIN orders o
ON oi.order_id=o.order_id
WHERE o.order_status='delivered'
GROUP BY oi.seller_id
HAVING COUNT(*)>=30
ORDER BY avg_delivery_days
LIMIT 10;

-- Q9. Top 10 slowest sellers
SELECT oi.seller_id,
       ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                          order_purchase_timestamp)),2)
       AS avg_delivery_days
FROM order_items oi
JOIN orders o
ON oi.order_id=o.order_id
WHERE o.order_status='delivered'
GROUP BY oi.seller_id
HAVING COUNT(*)>=30
ORDER BY avg_delivery_days DESC
LIMIT 10;

-- Q10. Which categories have the longest delivery times?
SELECT ct.product_category_name_english,
       ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                          order_purchase_timestamp)),2)
       AS avg_delivery_days
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
WHERE o.order_status='delivered'
GROUP BY ct.product_category_name_english
ORDER BY avg_delivery_days DESC
LIMIT 10;

-- Q11. Monthly delivery trend
SELECT DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS order_month,
       ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                          order_purchase_timestamp)),2)
       AS avg_delivery_days
FROM orders
WHERE order_status='delivered'
GROUP BY order_month
ORDER BY order_month;
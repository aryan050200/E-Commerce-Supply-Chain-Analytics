-- Q1. Which 10 product categories generate the highest revenue?
SELECT ct.product_category_name_english,
       ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- Q2. Which 10 product categories sell the highest volume?
SELECT ct.product_category_name_english,
       COUNT(*) AS units_sold
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY units_sold DESC
LIMIT 10;

-- Q3. Which states generate the highest revenue?
SELECT c.customer_state,
       ROUND(SUM(pay.payment_value),2) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments pay
ON o.order_id=pay.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- Q4. Which states have the highest average order value?
SELECT c.customer_state,
       ROUND(AVG(pay.payment_value),2) AS avg_order_value
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments pay
ON o.order_id=pay.order_id
GROUP BY c.customer_state
ORDER BY avg_order_value DESC;

-- Q5. What percentage of customers are repeat customers?
WITH customer_orders AS (
    SELECT c.customer_unique_id,
           COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
    ON c.customer_id=o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT ROUND(
       COUNT(CASE WHEN total_orders>1 THEN 1 END)*100.0/
       COUNT(*),2) AS repeat_customer_pct
FROM customer_orders;

-- Q6. Which customers spent the most money?
SELECT c.customer_unique_id,
       ROUND(SUM(pay.payment_value),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments pay
ON o.order_id=pay.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Q7. Which sellers contribute the most revenue?
SELECT seller_id,
       ROUND(SUM(price),2) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q8. What are the monthly revenue trends?
SELECT DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
       ROUND(SUM(pay.payment_value),2) AS revenue
FROM orders o
JOIN payments pay
ON o.order_id=pay.order_id
GROUP BY month
ORDER BY month;

-- Q9. Which categories have the highest review scores?
SELECT ct.product_category_name_english,
       ROUND(AVG(r.review_score),2) AS avg_review_score
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN reviews r
ON oi.order_id=r.order_id
GROUP BY ct.product_category_name_english
HAVING COUNT(*)>=30
ORDER BY avg_review_score DESC
LIMIT 10;

-- Q10. Which categories have the lowest review scores?
SELECT ct.product_category_name_english,
       ROUND(AVG(r.review_score),2) AS avg_review_score
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN reviews r
ON oi.order_id=r.order_id
GROUP BY ct.product_category_name_english
HAVING COUNT(*)>=30
ORDER BY avg_review_score
LIMIT 10;
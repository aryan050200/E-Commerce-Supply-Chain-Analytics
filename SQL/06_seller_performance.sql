-- Q1. Which sellers generated the highest revenue?
SELECT seller_id,
       ROUND(SUM(price),2) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q2. Which sellers fulfilled the most orders?
SELECT seller_id,
       COUNT(DISTINCT order_id) AS total_orders
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;

-- Q3. What is the average order value per seller?
SELECT seller_id,
       ROUND(AVG(price),2) AS avg_order_value
FROM order_items
GROUP BY seller_id
ORDER BY avg_order_value DESC
LIMIT 10;

-- Q4. Which sellers receive the highest review scores?
SELECT oi.seller_id,
       ROUND(AVG(r.review_score),2) AS avg_review_score
FROM order_items oi
JOIN reviews r
ON oi.order_id=r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*)>=30
ORDER BY avg_review_score DESC
LIMIT 10;

-- Q5. Which sellers receive the lowest review scores?
SELECT oi.seller_id,
       ROUND(AVG(r.review_score),2) AS avg_review_score
FROM order_items oi
JOIN reviews r
ON oi.order_id=r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*)>=30
ORDER BY avg_review_score
LIMIT 10;

-- Q6. Which states have the most sellers?
SELECT seller_state,
       COUNT(*) AS total_sellers
FROM sellers
GROUP BY seller_state
ORDER BY total_sellers DESC;

-- Q7. Which seller states generate the highest revenue?
SELECT s.seller_state,
       ROUND(SUM(oi.price),2) AS total_revenue
FROM sellers s
JOIN order_items oi
ON s.seller_id=oi.seller_id
GROUP BY s.seller_state
ORDER BY total_revenue DESC;

-- Q8. Which sellers charge the highest average freight cost?
SELECT seller_id,
       ROUND(AVG(freight_value),2) AS avg_freight
FROM order_items
GROUP BY seller_id
ORDER BY avg_freight DESC
LIMIT 10;

-- Q9. Which sellers charge the lowest average freight cost?
SELECT seller_id,
       ROUND(AVG(freight_value),2) AS avg_freight
FROM order_items
GROUP BY seller_id
ORDER BY avg_freight
LIMIT 10;

-- Q10. Which sellers have the best revenue-to-review balance?
SELECT oi.seller_id,
       ROUND(SUM(oi.price),2) AS revenue,
       ROUND(AVG(r.review_score),2) AS review_score
FROM order_items oi
JOIN reviews r
ON oi.order_id=r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*)>=30
ORDER BY revenue DESC;

-- Q11. Which sellers combine good reviews and fast delivery?

SELECT oi.seller_id,
       ROUND(AVG(r.review_score),2) AS avg_review_score,
       ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,
                          o.order_purchase_timestamp)),2)
       AS avg_delivery_days
FROM order_items oi
JOIN reviews r
ON oi.order_id=r.order_id
JOIN orders o
ON oi.order_id=o.order_id
WHERE o.order_status='delivered'
GROUP BY oi.seller_id
HAVING COUNT(*)>=30
ORDER BY avg_review_score DESC,
         avg_delivery_days ASC;
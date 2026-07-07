-- Q1. Show order details along with customer location
SELECT
    o.order_id,
    o.order_status,
    c.customer_city,
    c.customer_state
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

-- Q2. Which states generated the highest number of orders?
SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

-- Q3. Which states generated the highest revenue?
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- Q4. Top 10 cities by order volume
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- Q5. Top 10 customers by spending
SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Q6. Top 10 sellers by revenue
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q7. Which sellers processed the most orders?
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;

-- Q8. Top 10 product categories by revenue
SELECT
    ct.product_category_name_english,
    ROUND(SUM(oi.price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY revenue DESC
LIMIT 10;

-- Q9. Which product categories sold the most items?
SELECT
    ct.product_category_name_english,
    COUNT(*) AS items_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY items_sold DESC
LIMIT 10;

-- Q10. Average review score by product category
SELECT
    ct.product_category_name_english,
    ROUND(AVG(r.review_score),2) AS avg_review_score
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
JOIN reviews r
ON oi.order_id = r.order_id
GROUP BY ct.product_category_name_english
ORDER BY avg_review_score DESC;

-- Q11. Average review score by seller
SELECT
    oi.seller_id,
    ROUND(AVG(r.review_score),2) AS avg_review_score
FROM order_items oi
JOIN reviews r
ON oi.order_id = r.order_id
GROUP BY oi.seller_id
ORDER BY avg_review_score DESC;

-- Q12. Which states have the highest average order value?
SELECT
    c.customer_state,
    ROUND(AVG(p.payment_value),2) AS avg_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY avg_order_value DESC;
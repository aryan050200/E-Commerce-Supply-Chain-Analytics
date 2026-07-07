-- Q1. Which product categories generate above-average revenue?
WITH category_revenue AS (
    SELECT ct.product_category_name_english,
           SUM(oi.price) AS revenue
    FROM order_items oi
    JOIN products p
    ON oi.product_id=p.product_id
    JOIN category_translation ct
    ON p.product_category_name=ct.product_category_name
    GROUP BY ct.product_category_name_english
)

SELECT *
FROM category_revenue
WHERE revenue >
      (SELECT AVG(revenue) FROM category_revenue)
ORDER BY revenue DESC;

-- Q2. Which sellers generate above-average revenue?
WITH seller_revenue AS (
    SELECT seller_id,
           SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
)

SELECT *
FROM seller_revenue
WHERE revenue >
      (SELECT AVG(revenue) FROM seller_revenue)
ORDER BY revenue DESC;

-- Q3. Which states have above-average order volume?
WITH state_orders AS (
    SELECT c.customer_state,
           COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
    ON c.customer_id=o.customer_id
    GROUP BY c.customer_state
)

SELECT *
FROM state_orders
WHERE total_orders >
      (SELECT AVG(total_orders) FROM state_orders)
ORDER BY total_orders DESC;

-- Q4. Rank sellers by revenue using CTE
WITH seller_revenue AS (
    SELECT seller_id,
           SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
)

SELECT seller_id,
       revenue
FROM seller_revenue
ORDER BY revenue DESC
LIMIT 10;

-- Q5. Which months generated above-average revenue?
WITH monthly_revenue AS (
    SELECT DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
           SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p
    ON o.order_id=p.order_id
    GROUP BY month
)

SELECT *
FROM monthly_revenue
WHERE revenue >
      (SELECT AVG(revenue) FROM monthly_revenue)
ORDER BY revenue DESC;

-- Q6. Which product categories have above-average review scores?
WITH category_reviews AS (
    SELECT ct.product_category_name_english,
           AVG(r.review_score) AS avg_review
    FROM order_items oi
    JOIN products p
    ON oi.product_id=p.product_id
    JOIN category_translation ct
    ON p.product_category_name=ct.product_category_name
    JOIN reviews r
    ON oi.order_id=r.order_id
    GROUP BY ct.product_category_name_english
)

SELECT *
FROM category_reviews
WHERE avg_review >
      (SELECT AVG(avg_review) FROM category_reviews)
ORDER BY avg_review DESC;

-- Q7. Which sellers have both above-average revenue and review score?
WITH seller_metrics AS (
    SELECT oi.seller_id,
           SUM(oi.price) AS revenue,
           AVG(r.review_score) AS review_score
    FROM order_items oi
    JOIN reviews r
    ON oi.order_id=r.order_id
    GROUP BY oi.seller_id
)

SELECT *
FROM seller_metrics
WHERE revenue >
      (SELECT AVG(revenue) FROM seller_metrics)
AND review_score >
      (SELECT AVG(review_score) FROM seller_metrics)
ORDER BY revenue DESC;
-- Q1. Create Customer Orders View
CREATE VIEW vw_customer_orders AS
SELECT
    o.order_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

-- Q2. View Customer Orders
SELECT * 
FROM vw_customer_orders
LIMIT 10;

-- Q3. Create Product Sales View
CREATE VIEW vw_product_sales AS
SELECT
    oi.product_id,
    SUM(oi.price) AS total_revenue,
    COUNT(*) AS units_sold
FROM order_items oi
GROUP BY oi.product_id;

-- Q4. View Product Sales
SELECT *
FROM vw_product_sales
ORDER BY total_revenue DESC
LIMIT 10;

-- Q5. Create Seller Performance View
CREATE VIEW vw_seller_performance AS
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price),2) AS total_revenue,
    ROUND(AVG(freight_value),2) AS avg_freight
FROM order_items
GROUP BY seller_id;

-- Q6. View Seller Performance
SELECT *
FROM vw_seller_performance
ORDER BY total_revenue DESC
LIMIT 10;

-- Q7. Create Monthly Revenue View
CREATE VIEW vw_monthly_revenue AS
SELECT
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY month;

-- Q8. View Monthly Revenue
SELECT *
FROM vw_monthly_revenue
ORDER BY month;

-- Q9. Create Category Revenue View
CREATE VIEW vw_category_revenue AS
SELECT
    ct.product_category_name_english,
    ROUND(SUM(oi.price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english;

-- Q10. View Category Revenue
SELECT *
FROM vw_category_revenue
ORDER BY revenue DESC
LIMIT 10;

-- Q11. Create Delivery Performance View

CREATE VIEW vw_delivery_performance AS
SELECT
    order_id,
    order_status,
    DATEDIFF(order_delivered_customer_date,
             order_purchase_timestamp) AS delivery_days,
    DATEDIFF(order_estimated_delivery_date,
             order_purchase_timestamp) AS estimated_days
FROM orders
WHERE order_status='delivered';

SELECT *
FROM vw_delivery_performance
LIMIT 10;
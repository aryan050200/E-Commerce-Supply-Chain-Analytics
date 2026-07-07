-- Q1. Create a procedure to get revenue by state
DELIMITER //

CREATE PROCEDURE GetRevenueByState(IN state_code VARCHAR(2))
BEGIN
    SELECT c.customer_state,
           ROUND(SUM(p.payment_value),2) AS total_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN payments p
        ON o.order_id = p.order_id
    WHERE c.customer_state = state_code
    GROUP BY c.customer_state;
END //

DELIMITER ;

-- Test:

CALL GetRevenueByState('SP');

-- Result:
-- SP generated R$ 5,998,226.96 revenue.

-- Q2. Create a procedure to get seller revenue
DELIMITER //

CREATE PROCEDURE GetTopSellerRevenue()
BEGIN
    SELECT seller_id,
           ROUND(SUM(price),2) AS total_revenue
    FROM order_items
    GROUP BY seller_id
    ORDER BY total_revenue DESC
    LIMIT 10;
END //

DELIMITER ;

-- Test:
CALL GetTopSellerRevenue();


-- Q3. Create a procedure to get category revenue
DELIMITER //

CREATE PROCEDURE GetCategoryRevenue(IN category_name VARCHAR(100))
BEGIN
    SELECT ct.product_category_name_english,
           ROUND(SUM(oi.price),2) AS revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    WHERE ct.product_category_name_english = category_name
    GROUP BY ct.product_category_name_english;
END //

DELIMITER ;

-- Test:

CALL GetCategoryRevenue('bed_bath_table');

-- Q4. Create a procedure to get monthly revenue
DELIMITER //

CREATE PROCEDURE GetMonthlyRevenue()
BEGIN
    SELECT DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
           ROUND(SUM(p.payment_value),2) AS revenue
    FROM orders o
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY month
    ORDER BY month;
END //

DELIMITER ;

-- Test:

CALL GetMonthlyRevenue();

-- Q5. Create a procedure to get top sellers
DELIMITER //

CREATE PROCEDURE GetTopSellers()
BEGIN
    SELECT seller_id,
           ROUND(SUM(price),2) AS revenue
    FROM order_items
    GROUP BY seller_id
    ORDER BY revenue DESC
    LIMIT 10;
END //

DELIMITER ;

-- Test
CALL GetTopSellers();
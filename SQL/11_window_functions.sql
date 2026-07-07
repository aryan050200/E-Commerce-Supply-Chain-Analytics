-- Q1 Running Revenue
SELECT month,
       revenue,
       SUM(revenue) OVER(ORDER BY month)
       AS running_revenue
FROM vw_monthly_revenue;

-- Q2 Month-over-Month Growth
SELECT month,
       revenue,
       LAG(revenue) OVER(ORDER BY month)
       AS previous_month
FROM vw_monthly_revenue;

-- Q3 Rank Sellers by Revenue
SELECT seller_id,
       revenue,
       RANK() OVER(ORDER BY revenue DESC)
       AS seller_rank
FROM (
    SELECT seller_id,
           SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
) t;

-- Q4 Rank Sellers Within Each State
SELECT seller_state,
       seller_id,
       revenue,
       RANK() OVER(
           PARTITION BY seller_state
           ORDER BY revenue DESC
       ) AS state_rank
FROM (
    SELECT s.seller_state,
           s.seller_id,
           SUM(oi.price) AS revenue
    FROM sellers s
    JOIN order_items oi
    ON s.seller_id=oi.seller_id
    GROUP BY s.seller_state, s.seller_id
) t;

-- Q5 Top Product in Each Category
SELECT *
FROM (
    SELECT
        ct.product_category_name_english,
        oi.product_id,
        SUM(oi.price) AS revenue,
        ROW_NUMBER() OVER(
            PARTITION BY ct.product_category_name_english
            ORDER BY SUM(oi.price) DESC
        ) AS rn
    FROM order_items oi
    JOIN products p
    ON oi.product_id=p.product_id
    JOIN category_translation ct
    ON p.product_category_name=ct.product_category_name
    GROUP BY ct.product_category_name_english,
             oi.product_id
) t
WHERE rn=1;
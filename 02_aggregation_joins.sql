-- 02_aggregation_joins.sql

-- Task 5(a): INNER JOIN + GROUP BY + HAVING
-- Cuisine-level totals for Delivered orders only, keeping cuisines above 40000 revenue.
SELECT
    r.cuisine,
    COUNT(o.order_id)       AS order_count,
    SUM(o.amount_inr)       AS total_revenue,
    AVG(o.amount_inr)       AS avg_revenue
FROM orders o
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine
HAVING total_revenue > 40000;

-- Task 5(b): LEFT JOIN
-- Total order count per restaurant (all statuses), preserving restaurants with zero orders.
-- Note: the status filter is not needed here since this counts ALL orders, but if you
-- ever need to filter the "many" side of a LEFT JOIN, put the condition in the ON clause,
-- not WHERE -- a WHERE clause on orders columns will silently drop the unmatched (NULL) row.
SELECT
    r.restaurant_id,
    r.name,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY total_orders ASC;

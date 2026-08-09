-- 03_reporting.sql

-- Task 6(a): CASE WHEN tiering
-- Tier every restaurant by its total Delivered revenue.
SELECT
    r.restaurant_id,
    r.name,
    SUM(o.amount_inr) AS total_revenue,
    CASE
        WHEN SUM(o.amount_inr) >= 50000 THEN 'High'
        WHEN SUM(o.amount_inr) >= 20000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM restaurants r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id AND o.status = 'Delivered'
GROUP BY r.restaurant_id, r.name;

-- Task 6(b): Monthly-by-cuisine business report
-- THIS IS THE QUERY WHOSE OUTPUT BECOMES monthly_cuisine_revenue.csv.
-- Delivered orders only, grouped by cuisine AND month together.
SELECT
    r.cuisine                                AS cuisine,
    strftime('%Y-%m', o.order_date)          AS month,
    COUNT(o.order_id)                        AS order_count,
    SUM(o.amount_inr)                        AS total_revenue,
    AVG(o.amount_inr)                        AS avg_revenue
FROM orders o
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine, strftime('%Y-%m', o.order_date)
ORDER BY r.cuisine, month;

-- Task 6(c): Variance / percentage-variance vs. cuisine targets
-- Note the *100.0 BEFORE dividing -- both total_revenue and target_revenue_inr are
-- INTEGER columns, so (total_revenue - target_revenue_inr) / target_revenue_inr alone
-- truncates to a whole number first, and multiplying by 100 afterwards can't undo that.
SELECT
    cr.cuisine,
    cr.total_revenue,
    ct.target_revenue_inr,
    (ct.target_revenue_inr - cr.total_revenue) AS variance,
    ((cr.total_revenue - ct.target_revenue_inr) * 100.0) / ct.target_revenue_inr AS percentage_variance,
    CASE
        WHEN cr.total_revenue >= ct.target_revenue_inr THEN 'Above Target'
        WHEN ((ct.target_revenue_inr - cr.total_revenue) * 100.0) / ct.target_revenue_inr <= 15 THEN 'Below Target - Watch'
        ELSE 'Below Target - Critical'
    END AS status_tag
FROM (
    SELECT r.cuisine, SUM(o.amount_inr) AS total_revenue
    FROM orders o
    INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
    WHERE o.status = 'Delivered'
    GROUP BY r.cuisine
) cr
INNER JOIN cuisine_targets ct ON cr.cuisine = ct.cuisine;

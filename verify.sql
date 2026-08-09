-- verify.sql
-- Task 3: Sanity-check the generated database before building anything on top of it.
--
-- ACTUAL OUTPUT when run against swiggy_capstone.db:
--   restaurants:      15
--   customers:        50
--   orders:           420
--   cuisine_targets:  6
--
--   status breakdown on orders:
--     Delivered   358
--     Cancelled    35
--     Pending      27
--
-- These match the brief's stated acceptance criteria exactly, confirming
-- generate_data.py was run unmodified with random.seed(42) intact.

SELECT COUNT(*) AS restaurant_count FROM restaurants;

SELECT COUNT(*) AS customer_count FROM customers;

SELECT COUNT(*) AS order_count FROM orders;

SELECT COUNT(*) AS cuisine_target_count FROM cuisine_targets;

SELECT status, COUNT(*) AS status_count
FROM orders
GROUP BY status;

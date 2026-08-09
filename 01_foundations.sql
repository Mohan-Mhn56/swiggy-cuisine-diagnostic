-- 01_foundations.sql
-- Task 4: one labelled query per clause.

-- WHERE: restaurants located in Mumbai
SELECT *
FROM restaurants
WHERE city = 'Mumbai';

-- DISTINCT: every unique cuisine listed
SELECT DISTINCT cuisine
FROM restaurants;

-- ORDER BY + LIMIT: the 5 highest-value orders by amount_inr
SELECT order_id, amount_inr
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;

-- LIKE + %: restaurant name containing the keyword 'House'
SELECT *
FROM restaurants
WHERE name LIKE '%House%';

-- IN: customers from Mumbai or Delhi
SELECT *
FROM customers
WHERE city IN ('Mumbai', 'Delhi');

-- BETWEEN: orders with amount_inr between 500 and 1000 (inclusive)
SELECT order_id, amount_inr
FROM orders
WHERE amount_inr BETWEEN 500 AND 1000;

-- NOT BETWEEN: orders with amount_inr outside the 500-1000 range
SELECT order_id, amount_inr
FROM orders
WHERE amount_inr NOT BETWEEN 500 AND 1000;

-- IS NULL: orders with no rating recorded (these are the Cancelled/Pending rows)
SELECT order_id, status, rating
FROM orders
WHERE rating IS NULL;

-- ========================================
-- SQL Practice 3: GROUP BY and Aggregates
-- ========================================
-- Objective: Master GROUP BY with aggregate functions and HAVING clauses
-- Topics: GROUP BY, COUNT, SUM, AVG, MIN, MAX, HAVING, aggregate functions
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED:
--   customers (customer_id, first_name, last_name, city, state, registration_date)
--   products (product_id, product_name, category, price, stock_quantity)
--   orders (order_id, customer_id, order_date, total_amount, status)
--   order_items (order_item_id, order_id, product_id, quantity, unit_price)

-- ========================================
-- PRACTICE QUERIES WITH SOLUTIONS
-- ========================================

-- Query 1: Basic GROUP BY with COUNT
-- Count the number of orders per customer
SELECT customer_id, COUNT(*) as order_count 
FROM orders 
GROUP BY customer_id;

-- Query 2: GROUP BY with SUM
-- Total sales amount per customer
SELECT customer_id, SUM(total_amount) as total_spent 
FROM orders 
WHERE status = 'Completed'
GROUP BY customer_id;

-- Query 3: GROUP BY with multiple aggregates
-- Order statistics per customer
SELECT customer_id, 
       COUNT(*) as order_count,
       SUM(total_amount) as total_spent,
       AVG(total_amount) as avg_order_value,
       MIN(total_amount) as min_order,
       MAX(total_amount) as max_order
FROM orders 
WHERE status = 'Completed'
GROUP BY customer_id;

-- Query 4: GROUP BY with HAVING clause
-- Customers who have spent more than $500 total
SELECT customer_id, SUM(total_amount) as total_spent 
FROM orders 
WHERE status = 'Completed'
GROUP BY customer_id 
HAVING SUM(total_amount) > 500;

-- Query 5: GROUP BY with JOIN
-- Sales summary by product category
SELECT p.category, 
       COUNT(oi.order_item_id) as items_sold,
       SUM(oi.quantity * oi.unit_price) as total_revenue
FROM products p 
INNER JOIN order_items oi ON p.product_id = oi.product_id 
INNER JOIN orders o ON oi.order_id = o.order_id 
WHERE o.status = 'Completed'
GROUP BY p.category;

-- Query 6: GROUP BY with date functions
-- Monthly sales summary
SELECT strftime('%Y-%m', order_date) as month,
       COUNT(*) as order_count,
       SUM(total_amount) as monthly_revenue
FROM orders 
WHERE status = 'Completed'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY month;

-- Query 7: Complex GROUP BY with multiple tables
-- Top selling products with sales metrics
SELECT p.product_name, p.category,
       COUNT(oi.order_item_id) as times_ordered,
       SUM(oi.quantity) as total_quantity_sold,
       SUM(oi.quantity * oi.unit_price) as total_revenue,
       AVG(oi.unit_price) as avg_selling_price
FROM products p 
INNER JOIN order_items oi ON p.product_id = oi.product_id 
INNER JOIN orders o ON oi.order_id = o.order_id 
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;

-- Query 8: GROUP BY with HAVING and ORDER BY
-- Customers with multiple orders, ordered by total spent
SELECT c.first_name, c.last_name, 
       COUNT(o.order_id) as order_count,
       SUM(o.total_amount) as total_spent
FROM customers c 
INNER JOIN orders o ON c.customer_id = o.customer_id 
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name 
HAVING COUNT(o.order_id) >= 2 
ORDER BY total_spent DESC;

-- Query 9: GROUP BY by state
-- Sales performance by state
SELECT c.state, 
       COUNT(DISTINCT c.customer_id) as customer_count,
       COUNT(o.order_id) as total_orders,
       SUM(o.total_amount) as total_revenue,
       AVG(o.total_amount) as avg_order_value
FROM customers c 
INNER JOIN orders o ON c.customer_id = o.customer_id 
WHERE o.status = 'Completed'
GROUP BY c.state 
ORDER BY total_revenue DESC;

-- Query 10: GROUP BY with CASE statement
-- Order size categorization
SELECT 
    CASE 
        WHEN total_amount < 100 THEN 'Small'
        WHEN total_amount < 500 THEN 'Medium'
        WHEN total_amount < 1000 THEN 'Large'
        ELSE 'Extra Large'
    END as order_size,
    COUNT(*) as order_count,
    AVG(total_amount) as avg_amount
FROM orders 
WHERE status = 'Completed'
GROUP BY 
    CASE 
        WHEN total_amount < 100 THEN 'Small'
        WHEN total_amount < 500 THEN 'Medium'
        WHEN total_amount < 1000 THEN 'Large'
        ELSE 'Extra Large'
    END
ORDER BY avg_amount;

-- Query 11: GROUP BY with percentage calculation
-- Product category contribution to total sales
SELECT p.category, 
       SUM(oi.quantity * oi.unit_price) as category_revenue,
       ROUND(
           (SUM(oi.quantity * oi.unit_price) * 100.0) / 
           (SELECT SUM(oi2.quantity * oi2.unit_price) 
            FROM order_items oi2 
            INNER JOIN orders o2 ON oi2.order_id = o2.order_id 
            WHERE o2.status = 'Completed'), 2
       ) as percentage_of_total
FROM products p 
INNER JOIN order_items oi ON p.product_id = oi.product_id 
INNER JOIN orders o ON oi.order_id = o.order_id 
WHERE o.status = 'Completed'
GROUP BY p.category 
ORDER BY category_revenue DESC; 
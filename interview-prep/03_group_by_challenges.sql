-- ========================================
-- SQL Practice 3: GROUP BY and Aggregates Challenges
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
-- CHALLENGES
-- ========================================

-- Query 1: Basic GROUP BY with COUNT
-- Count the number of orders per customer


-- Query 2: GROUP BY with SUM
-- Calculate total sales amount per customer (only completed orders)


-- Query 3: GROUP BY with multiple aggregates
-- Show order statistics per customer: count, total spent, average order value, min order, max order (completed orders only)


-- Query 4: GROUP BY with HAVING clause
-- Find customers who have spent more than $500 total (completed orders only)


-- Query 5: GROUP BY with JOIN
-- Show sales summary by product category: items sold and total revenue (completed orders only)


-- Query 6: GROUP BY with date functions
-- Create monthly sales summary showing order count and monthly revenue (completed orders only)


-- Query 7: Complex GROUP BY with multiple tables
-- Show top selling products with sales metrics: times ordered, total quantity sold, total revenue, average selling price (completed orders only)


-- Query 8: GROUP BY with HAVING and ORDER BY
-- Find customers with multiple orders, show their order count and total spent, ordered by total spent descending (completed orders only)


-- Query 9: GROUP BY by state
-- Show sales performance by state: customer count, total orders, total revenue, average order value (completed orders only)


-- Query 10: GROUP BY with CASE statement
-- Categorize orders by size (Small: <$100, Medium: $100-$499, Large: $500-$999, Extra Large: $1000+) and show count and average amount per category (completed orders only)


-- Query 11: GROUP BY with percentage calculation
-- Show each product category's contribution to total sales as a percentage (completed orders only) 
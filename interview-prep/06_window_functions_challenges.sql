-- ========================================
-- SQL Practice 6: Window Functions Challenges
-- ========================================
-- Objective: Master window functions for advanced analytics and ranking
-- Topics: ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, FIRST_VALUE, LAST_VALUE, windowed aggregations
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED:
--   customers (customer_id, first_name, last_name, city, state, registration_date)
--   orders (order_id, customer_id, order_date, total_amount, status)
--   order_items (order_item_id, order_id, product_id, quantity, unit_price)
--   products (product_id, product_name, category, price, stock_quantity)
--   employees (employee_id, first_name, last_name, salary, department_id, hire_date)

-- ========================================
-- CHALLENGES
-- ========================================

-- Query 1: Basic ROW_NUMBER()
-- Order customers by total spending and show each customer's spending rank


-- Query 2: RANK() vs DENSE_RANK()
-- Compare RANK and DENSE_RANK for products by total sales (include both ranking types)


-- Query 3: PARTITION BY
-- Rank products by sales within each category (show category rank and row number)


-- Query 4: LAG() and LEAD()
-- Show each customer's order with previous and next order amounts, plus the change from previous order


-- Query 5: FIRST_VALUE() and LAST_VALUE()
-- Show each order with the customer's first and latest order amounts


-- Query 6: SUM() OVER - Running totals
-- Calculate running total of sales by date


-- Query 7: AVG() OVER with moving window
-- Calculate 3-day moving average of daily sales


-- Query 8: NTILE()
-- Divide customers into quartiles by total spending and assign customer segments


-- Query 9: Complex window with multiple functions
-- Customer analysis showing rank, percentile, comparison to average, and customer tier assignment


-- Query 10: State-level window functions
-- Show customer ranking within each state and their share of state spending


-- Query 11: Employee salary analysis
-- Show salary rankings and comparisons within departments (rank, vs dept avg, vs company avg, dept min/max)


-- Query 12: Product performance tracking over time
-- Show monthly product sales with month-over-month change and percentage change


-- Query 13: Rolling calculations with custom frames
-- Calculate 30-day rolling average for order volumes


-- Query 14: Business Intelligence Dashboard Query
-- Comprehensive customer segmentation with rankings, comparisons, segments, and recency analysis 
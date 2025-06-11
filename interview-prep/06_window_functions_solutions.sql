-- ========================================
-- SQL Practice 6: Window Functions Solutions
-- ========================================
-- This file contains solutions to the window functions challenges

-- Query 1: Basic ROW_NUMBER()
SELECT c.first_name, c.last_name, 
       SUM(o.total_amount) as total_spent,
       ROW_NUMBER() OVER (ORDER BY SUM(o.total_amount) DESC) as spending_rank
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- Query 2: RANK() vs DENSE_RANK()
SELECT p.product_name, p.category,
       SUM(oi.quantity * oi.unit_price) as total_sales,
       RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) as sales_rank,
       DENSE_RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) as dense_sales_rank
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_sales DESC;

-- Query 3: PARTITION BY
SELECT p.product_name, p.category,
       SUM(oi.quantity * oi.unit_price) as total_sales,
       RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.unit_price) DESC) as category_rank,
       ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.unit_price) DESC) as category_row_num
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY p.category, total_sales DESC;

-- Query 4: LAG() and LEAD()
SELECT c.first_name, c.last_name, o.order_date, o.total_amount,
       LAG(o.total_amount) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) as previous_order_amount,
       LEAD(o.total_amount) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) as next_order_amount,
       o.total_amount - LAG(o.total_amount) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) as amount_change
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
ORDER BY c.customer_id, o.order_date;

-- Query 5: FIRST_VALUE() and LAST_VALUE()
SELECT c.first_name, c.last_name, o.order_date, o.total_amount,
       FIRST_VALUE(o.total_amount) OVER (PARTITION BY c.customer_id ORDER BY o.order_date 
                                         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as first_order_amount,
       LAST_VALUE(o.total_amount) OVER (PARTITION BY c.customer_id ORDER BY o.order_date 
                                        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as latest_order_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
ORDER BY c.customer_id, o.order_date;

-- Query 6: SUM() OVER - Running totals
SELECT o.order_date, 
       SUM(o.total_amount) as daily_sales,
       SUM(SUM(o.total_amount)) OVER (ORDER BY o.order_date ROWS UNBOUNDED PRECEDING) as running_total
FROM orders o
WHERE o.status = 'Completed'
GROUP BY o.order_date
ORDER BY o.order_date;

-- Query 7: AVG() OVER with moving window
SELECT o.order_date,
       SUM(o.total_amount) as daily_sales,
       AVG(SUM(o.total_amount)) OVER (ORDER BY o.order_date ROWS 2 PRECEDING) as three_day_moving_avg
FROM orders o
WHERE o.status = 'Completed'
GROUP BY o.order_date
ORDER BY o.order_date;

-- Query 8: NTILE()
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           SUM(o.total_amount) as total_spent
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT first_name, last_name, total_spent,
       NTILE(4) OVER (ORDER BY total_spent DESC) as spending_quartile,
       CASE NTILE(4) OVER (ORDER BY total_spent DESC)
           WHEN 1 THEN 'Top 25% (VIP)'
           WHEN 2 THEN 'High Value'
           WHEN 3 THEN 'Medium Value'
           WHEN 4 THEN 'Low Value'
       END as customer_segment
FROM customer_spending
ORDER BY total_spent DESC;

-- Query 9: Complex window with multiple functions
WITH customer_metrics AS (
    SELECT c.customer_id, c.first_name, c.last_name, c.state,
           COUNT(o.order_id) as order_count,
           SUM(o.total_amount) as total_spent,
           AVG(o.total_amount) as avg_order_value
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name, c.state
)
SELECT first_name, last_name, state, total_spent, avg_order_value,
       RANK() OVER (ORDER BY total_spent DESC) as spending_rank,
       PERCENT_RANK() OVER (ORDER BY total_spent) as spending_percentile,
       total_spent - AVG(total_spent) OVER () as vs_avg_spending,
       CASE 
           WHEN total_spent > AVG(total_spent) OVER () * 1.5 THEN 'Premium'
           WHEN total_spent > AVG(total_spent) OVER () THEN 'Above Average'
           ELSE 'Standard'
       END as customer_tier
FROM customer_metrics
ORDER BY total_spent DESC;

-- Query 10: State-level window functions
SELECT c.first_name, c.last_name, c.state,
       SUM(o.total_amount) as total_spent,
       RANK() OVER (PARTITION BY c.state ORDER BY SUM(o.total_amount) DESC) as state_rank,
       COUNT(*) OVER (PARTITION BY c.state) as customers_in_state,
       SUM(o.total_amount) / SUM(SUM(o.total_amount)) OVER (PARTITION BY c.state) as state_spending_share
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name, c.state
ORDER BY c.state, total_spent DESC;

-- Query 11: Employee salary analysis
SELECT e.first_name, e.last_name, d.department_name, e.salary,
       RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as dept_salary_rank,
       e.salary - AVG(e.salary) OVER (PARTITION BY e.department_id) as vs_dept_avg,
       e.salary - AVG(e.salary) OVER () as vs_company_avg,
       MAX(e.salary) OVER (PARTITION BY e.department_id) as dept_max_salary,
       MIN(e.salary) OVER (PARTITION BY e.department_id) as dept_min_salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE e.is_active = 1
ORDER BY d.department_name, e.salary DESC;

-- Query 12: Product performance tracking over time
WITH monthly_product_sales AS (
    SELECT p.product_name, p.category,
           strftime('%Y-%m', o.order_date) as month,
           SUM(oi.quantity * oi.unit_price) as monthly_sales
    FROM products p
    INNER JOIN order_items oi ON p.product_id = oi.product_id
    INNER JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'
    GROUP BY p.product_id, p.product_name, p.category, strftime('%Y-%m', o.order_date)
)
SELECT product_name, category, month, monthly_sales,
       LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month) as prev_month_sales,
       monthly_sales - LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month) as month_over_month_change,
       CASE 
           WHEN LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month) IS NULL THEN NULL
           ELSE ROUND((monthly_sales - LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month)) * 100.0 / 
                     LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month), 2)
       END as month_over_month_pct_change
FROM monthly_product_sales
ORDER BY product_name, month;

-- Query 13: Rolling calculations with custom frames
SELECT o.order_date,
       COUNT(o.order_id) as daily_orders,
       AVG(COUNT(o.order_id)) OVER (ORDER BY o.order_date RANGE BETWEEN INTERVAL 30 DAY PRECEDING AND CURRENT ROW) as rolling_30_day_avg_orders
FROM orders o
WHERE o.status = 'Completed'
GROUP BY o.order_date
ORDER BY o.order_date;

-- Query 14: Business Intelligence Dashboard Query
WITH customer_analysis AS (
    SELECT c.customer_id, c.first_name, c.last_name, c.state, c.registration_date,
           COUNT(o.order_id) as total_orders,
           SUM(o.total_amount) as total_spent,
           AVG(o.total_amount) as avg_order_value,
           MAX(o.order_date) as last_order_date,
           MIN(o.order_date) as first_order_date
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name, c.state, c.registration_date
)
SELECT first_name, last_name, state, total_orders, total_spent, avg_order_value,
       RANK() OVER (ORDER BY total_spent DESC) as overall_value_rank,
       NTILE(5) OVER (ORDER BY total_spent DESC) as value_quintile,
       total_spent - AVG(total_spent) OVER () as vs_avg_customer_value,
       avg_order_value - AVG(avg_order_value) OVER () as vs_avg_order_value,
       CASE 
           WHEN NTILE(5) OVER (ORDER BY total_spent DESC) = 1 THEN 'VIP (Top 20%)'
           WHEN NTILE(5) OVER (ORDER BY total_spent DESC) = 2 THEN 'High Value'
           WHEN NTILE(5) OVER (ORDER BY total_spent DESC) = 3 THEN 'Medium Value'
           WHEN NTILE(5) OVER (ORDER BY total_spent DESC) = 4 THEN 'Low Value'
           ELSE 'At Risk (Bottom 20%)'
       END as customer_segment,
       julianday('2023-12-31') - julianday(last_order_date) as days_since_last_order,
       CASE 
           WHEN julianday('2023-12-31') - julianday(last_order_date) <= 30 THEN 'Active'
           WHEN julianday('2023-12-31') - julianday(last_order_date) <= 90 THEN 'At Risk'
           ELSE 'Inactive'
       END as recency_status
FROM customer_analysis
ORDER BY total_spent DESC; 
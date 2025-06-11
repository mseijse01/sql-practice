-- ========================================
-- SQL Practice 3: GROUP BY and Aggregates Solutions
-- ========================================
-- Reference solutions for 03_group_by_challenges.sql

-- Query 1: Basic GROUP BY with COUNT
SELECT customer_id, COUNT(*) as order_count 
FROM orders 
GROUP BY customer_id;

-- Query 2: GROUP BY with SUM
SELECT customer_id, SUM(total_amount) as total_spent 
FROM orders 
WHERE status = 'Completed'
GROUP BY customer_id;

-- Query 3: GROUP BY with multiple aggregates
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
SELECT customer_id, SUM(total_amount) as total_spent 
FROM orders 
WHERE status = 'Completed'
GROUP BY customer_id 
HAVING SUM(total_amount) > 500;

-- Query 5: GROUP BY with JOIN
SELECT p.category, 
       COUNT(oi.order_item_id) as items_sold,
       SUM(oi.quantity * oi.unit_price) as total_revenue
FROM products p 
INNER JOIN order_items oi ON p.product_id = oi.product_id 
INNER JOIN orders o ON oi.order_id = o.order_id 
WHERE o.status = 'Completed'
GROUP BY p.category;

-- Query 6: GROUP BY with date functions
SELECT DATE_FORMAT(order_date, '%Y-%m') as month,
       COUNT(*) as order_count,
       SUM(total_amount) as monthly_revenue
FROM orders 
WHERE status = 'Completed'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Query 7: Complex GROUP BY with multiple tables
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
SELECT p.category,
       SUM(oi.quantity * oi.unit_price) as category_revenue,
       ROUND(
           SUM(oi.quantity * oi.unit_price) * 100.0 / 
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
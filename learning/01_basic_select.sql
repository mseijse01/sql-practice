-- ========================================
-- SQL Practice 1: Basic SELECT Operations
-- ========================================
-- Objective: Master fundamental SELECT queries with filtering and sorting
-- Topics: SELECT, WHERE, ORDER BY, LIMIT, comparison operators, logical operators
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED: 
--   employees (employee_id, first_name, last_name, email, salary, department_id, hire_date, is_active, manager_id)
--   departments (department_id, department_name, manager_name, budget)

-- ========================================
-- PRACTICE QUERIES WITH SOLUTIONS
-- ========================================

-- Query 1: Select all employees
-- Basic SELECT to retrieve all data
SELECT * FROM employees;

-- Query 2: Select specific columns
-- Choose only relevant columns for a report
SELECT first_name, last_name, department, salary FROM employees;

-- Query 3: Filter by department
-- Find all employees in Engineering (using department_id)
SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id = 1;

-- Query 4: Filter by salary range
-- Find employees earning between 60K and 75K
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary >= 60000 AND salary <= 75000;

-- Query 5: Filter with OR condition
-- Find employees in Marketing or Sales (using department_id)
SELECT first_name, last_name, department_id 
FROM employees 
WHERE department_id = 2 OR department_id = 3;

-- Query 6: Filter by hire date
-- Find employees hired after 2022
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE hire_date > '2022-01-01';

-- Query 7: Order by salary (ascending)
-- Sort employees by salary from lowest to highest
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary ASC;

-- Query 8: Order by salary (descending)
-- Sort employees by salary from highest to lowest
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC;

-- Query 9: Order by multiple columns
-- Sort by department first, then by salary within each department
SELECT first_name, last_name, department_id, salary 
FROM employees 
ORDER BY department_id, salary DESC;

-- Query 10: Combine WHERE and ORDER BY
-- Find Engineering employees ordered by hire date
SELECT first_name, last_name, hire_date, salary 
FROM employees 
WHERE department_id = 1 
ORDER BY hire_date;

-- Query 11: Use LIMIT
-- Get the top 3 highest paid employees
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 3;

-- Query 12: Pattern matching with LIKE
-- Find employees whose first name starts with 'J'
SELECT first_name, last_name, department 
FROM employees 
WHERE first_name LIKE 'J%';

-- Query 13: Filter active employees
-- Find all currently active employees
SELECT first_name, last_name, department_id 
FROM employees 
WHERE is_active = TRUE;

-- Query 14: Complex filtering
-- Find active Engineering employees earning more than 60K, ordered by salary
SELECT first_name, last_name, salary, hire_date 
FROM employees 
WHERE department_id = 1 
  AND salary > 60000 
  AND is_active = TRUE 
ORDER BY salary DESC;

-- Query 12: Using CASE statements for feature engineering (creating new columns)
-- Business context: Create order size categories for analysis
SELECT customer_id, 
       total_amount,
       CASE 
           WHEN total_amount >= 500 THEN 'Large Order'
           WHEN total_amount BETWEEN 100 AND 499 THEN 'Medium Order'
           WHEN total_amount BETWEEN 50 AND 99 THEN 'Small Order'
           ELSE 'Micro Order'
       END as order_category,
       CASE 
           WHEN total_amount > 300 THEN 'High Value'
           ELSE 'Standard'
       END as customer_segment
FROM orders
WHERE status = 'Completed'
ORDER BY total_amount DESC
LIMIT 10;

-- Query 13: CASE with NULL handling for data quality
SELECT customer_id,
       first_name,
       email,
       CASE 
           WHEN email IS NULL THEN 'No Email'
           WHEN email LIKE '%@gmail.com' THEN 'Gmail User'
           WHEN email LIKE '%@yahoo.com' THEN 'Yahoo User'
           ELSE 'Other Email Provider'
       END as email_category
FROM customers
ORDER BY customer_id
LIMIT 10; 
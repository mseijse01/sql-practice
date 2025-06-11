-- ========================================
-- SQL Practice 1: Basic SELECT Challenges
-- ========================================
-- Objective: Master fundamental SELECT queries with filtering and sorting
-- Topics: SELECT, WHERE, ORDER BY, LIMIT, comparison operators, logical operators
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED: 
--   employees (employee_id, first_name, last_name, email, salary, department_id, hire_date, is_active, manager_id)
--   departments (department_id, department_name, manager_name, budget)

-- ========================================
-- CHALLENGES
-- ========================================

-- Query 1: Select all employees


-- Query 2: Select specific columns
-- Choose only relevant columns for a report: first_name, last_name, department_id, salary


-- Query 3: Filter by department
-- Find all employees in Engineering (department_id = 1)


-- Query 4: Filter by salary range
-- Find employees earning between 60K and 75K


-- Query 5: Filter with OR condition
-- Find employees in Marketing (department_id = 2) or Sales (department_id = 3)


-- Query 6: Filter by hire date
-- Find employees hired after 2022


-- Query 7: Order by salary (ascending)
-- Sort employees by salary from lowest to highest


-- Query 8: Order by salary (descending)
-- Sort employees by salary from highest to lowest


-- Query 9: Order by multiple columns
-- Sort by department_id first, then by salary within each department (descending)


-- Query 10: Combine WHERE and ORDER BY
-- Find Engineering employees (department_id = 1) ordered by hire date


-- Query 11: Use LIMIT
-- Get the top 3 highest paid employees


-- Query 12: Pattern matching with LIKE
-- Find employees whose first name starts with 'J'


-- Query 13: Filter active employees
-- Find all currently active employees


-- Query 14: Complex filtering
-- Find active Engineering employees earning more than 60K, ordered by salary (descending)
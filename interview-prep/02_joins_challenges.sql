-- ========================================
-- SQL Practice 2: JOIN Challenges
-- ========================================
-- Objective: Master different types of JOINs to combine data from multiple tables
-- Topics: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, self-joins
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED: 
--   departments (department_id, department_name, manager_name, budget)
--   employees (employee_id, first_name, last_name, department_id, salary, manager_id)
--   projects (project_id, project_name, department_id, budget, start_date)

-- ========================================
-- CHALLENGES
-- ========================================

-- Query 1: INNER JOIN - Employees with their departments
-- Show only employees who have a department assigned


-- Query 2: LEFT JOIN - All employees with their departments (if any)
-- Show all employees, including those without a department


-- Query 3: RIGHT JOIN - All departments with their employees (if any)
-- Show all departments, including those without employees


-- Query 4: Multiple table JOIN
-- Get employee details with department and project information


-- Query 5: JOIN with WHERE clause
-- Find Engineering employees and their projects


-- Query 6: JOIN with aggregation
-- Count employees per department


-- Query 7: Self JOIN - Employees with their managers
-- Show employee-manager relationships


-- Query 8: JOIN with salary comparison
-- Find employees earning more than their department's average salary


-- Query 9: Complex JOIN with multiple conditions
-- Show projects with their department budget comparison, categorizing projects as 'High Budget', 'Medium Budget', or 'Low Budget' based on percentage of department budget


-- Query 10: LEFT JOIN to find missing relationships
-- Find departments without any projects


-- Query 11: JOIN with ordering and limiting
-- Get the top 3 highest paid employees with their department info


-- Query 12: Multiple LEFT JOINs
-- Show complete employee profile with department and manager information 
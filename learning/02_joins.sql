-- ========================================
-- SQL Practice 2: JOIN Operations
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
-- PRACTICE QUERIES WITH SOLUTIONS
-- ========================================

-- Query 1: INNER JOIN - Employees with their departments
-- Shows only employees who have a department assigned
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id;

-- Query 2: LEFT JOIN - All employees with their departments (if any)
-- Shows all employees, including those without a department
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id;

-- Query 3: RIGHT JOIN - All departments with their employees (if any)
-- Shows all departments, including those without employees
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e 
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- Query 4: Multiple table JOIN
-- Get employee details with department and project information
SELECT e.first_name, e.last_name, d.department_name, p.project_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
INNER JOIN projects p ON d.department_id = p.department_id;

-- Query 5: JOIN with WHERE clause
-- Find Engineering employees and their projects
SELECT e.first_name, e.last_name, p.project_name, p.budget 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
INNER JOIN projects p ON d.department_id = p.department_id 
WHERE d.department_name = 'Engineering';

-- Query 6: JOIN with aggregation
-- Count employees per department
SELECT d.department_name, COUNT(e.employee_id) as employee_count 
FROM departments d 
LEFT JOIN employees e ON d.department_id = e.department_id 
GROUP BY d.department_name;

-- Query 7: Self JOIN - Employees with their managers
-- Shows employee-manager relationships
SELECT e.first_name + ' ' + e.last_name as employee_name,
       m.first_name + ' ' + m.last_name as manager_name 
FROM employees e 
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- Query 8: JOIN with salary comparison
-- Employees earning more than their department's average
SELECT e.first_name, e.last_name, e.salary, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
WHERE e.salary > (
    SELECT AVG(e2.salary) 
    FROM employees e2 
    WHERE e2.department_id = e.department_id
);

-- Query 9: Complex JOIN with multiple conditions
-- Active projects with their department budget comparison
SELECT p.project_name, p.budget as project_budget, 
       d.department_name, d.budget as department_budget,
       CASE 
           WHEN p.budget > d.budget * 0.3 THEN 'High Budget Project'
           WHEN p.budget > d.budget * 0.1 THEN 'Medium Budget Project'
           ELSE 'Low Budget Project'
       END as budget_category
FROM projects p 
INNER JOIN departments d ON p.department_id = d.department_id;

-- Query 10: LEFT JOIN to find missing relationships
-- Departments without any projects
SELECT d.department_name 
FROM departments d 
LEFT JOIN projects p ON d.department_id = p.department_id 
WHERE p.project_id IS NULL;

-- Query 11: JOIN with ordering and limiting
-- Top 3 highest paid employees with their department info
SELECT e.first_name, e.last_name, e.salary, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
ORDER BY e.salary DESC 
LIMIT 3;

-- Query 12: Multiple LEFT JOINs
-- Complete employee profile with department and manager info
SELECT e.first_name, e.last_name, e.salary,
       d.department_name,
       m.first_name + ' ' + m.last_name as manager_name
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id 
LEFT JOIN employees m ON e.manager_id = m.employee_id; 
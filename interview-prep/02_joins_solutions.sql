-- ========================================
-- SQL Practice 2: JOIN Solutions
-- ========================================
-- Reference solutions for 02_joins_challenges.sql

-- Query 1: INNER JOIN - Employees with their departments
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id;

-- Query 2: LEFT JOIN - All employees with their departments (if any)
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id;

-- Query 3: RIGHT JOIN - All departments with their employees (if any)
SELECT e.first_name, e.last_name, d.department_name 
FROM employees e 
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- Query 4: Multiple table JOIN
SELECT e.first_name, e.last_name, d.department_name, p.project_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
INNER JOIN projects p ON d.department_id = p.department_id;

-- Query 5: JOIN with WHERE clause
SELECT e.first_name, e.last_name, p.project_name, p.budget 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
INNER JOIN projects p ON d.department_id = p.department_id 
WHERE d.department_name = 'Engineering';

-- Query 6: JOIN with aggregation
SELECT d.department_name, COUNT(e.employee_id) as employee_count 
FROM departments d 
LEFT JOIN employees e ON d.department_id = e.department_id 
GROUP BY d.department_name;

-- Query 7: Self JOIN - Employees with their managers
SELECT e.first_name + ' ' + e.last_name as employee_name,
       m.first_name + ' ' + m.last_name as manager_name 
FROM employees e 
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- Query 8: JOIN with salary comparison
SELECT e.first_name, e.last_name, e.salary, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
WHERE e.salary > (
    SELECT AVG(e2.salary) 
    FROM employees e2 
    WHERE e2.department_id = e.department_id
);

-- Query 9: Complex JOIN with multiple conditions
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
SELECT d.department_name 
FROM departments d 
LEFT JOIN projects p ON d.department_id = p.department_id 
WHERE p.project_id IS NULL;

-- Query 11: JOIN with ordering and limiting
SELECT e.first_name, e.last_name, e.salary, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id 
ORDER BY e.salary DESC 
LIMIT 3;

-- Query 12: Multiple LEFT JOINs
SELECT e.first_name, e.last_name, e.salary,
       d.department_name,
       m.first_name + ' ' + m.last_name as manager_name
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id 
LEFT JOIN employees m ON e.manager_id = m.employee_id; 
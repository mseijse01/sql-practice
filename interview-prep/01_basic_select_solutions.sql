-- ========================================
-- SQL Practice 1: Basic SELECT Solutions
-- ========================================
-- Reference solutions for 01_basic_select_challenges.sql

-- Query 1: Select all employees
SELECT * FROM employees;

-- Query 2: Select specific columns
SELECT first_name, last_name, department, salary FROM employees;

-- Query 3: Filter by department
SELECT first_name, last_name, salary 
FROM employees 
WHERE department = 'Engineering';

-- Query 4: Filter by salary range
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary >= 60000 AND salary <= 75000;

-- Query 5: Filter with OR condition
SELECT first_name, last_name, department 
FROM employees 
WHERE department = 'Marketing' OR department = 'Sales';

-- Query 6: Filter by hire date
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE hire_date > '2022-01-01';

-- Query 7: Order by salary (ascending)
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary ASC;

-- Query 8: Order by salary (descending)
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC;

-- Query 9: Order by multiple columns
SELECT first_name, last_name, department, salary 
FROM employees 
ORDER BY department, salary DESC;

-- Query 10: Combine WHERE and ORDER BY
SELECT first_name, last_name, hire_date, salary 
FROM employees 
WHERE department = 'Engineering' 
ORDER BY hire_date;

-- Query 11: Use LIMIT
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 3;

-- Query 12: Pattern matching with LIKE
SELECT first_name, last_name, department 
FROM employees 
WHERE first_name LIKE 'J%';

-- Query 13: Filter active employees
SELECT first_name, last_name, department 
FROM employees 
WHERE is_active = TRUE;

-- Query 14: Complex filtering
SELECT first_name, last_name, salary, hire_date 
FROM employees 
WHERE department = 'Engineering' 
  AND salary > 60000 
  AND is_active = TRUE 
ORDER BY salary DESC; 
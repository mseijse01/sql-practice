# SQL Common Mistakes Guide

Learn from the most common SQL errors and avoid these pitfalls. This guide shows what goes wrong, why it happens, and how to fix it.

## How to Use This Guide
- See the mistake to recognize the pattern
- Understand why it's wrong to avoid similar errors
- Learn the correct approach with explanations
- Practice the fix until it becomes natural

---

## Module 1: Basic SELECT Mistakes

### Mistake 1.1: Forgetting Quotes Around Text Values

**Wrong:**
```sql
SELECT * FROM employees WHERE first_name = John;
```

**Error:** `Error: no such column: John`

**Why it's wrong:** SQL treats `John` as a column name, not a text value.

**Correct:**
```sql
SELECT * FROM employees WHERE first_name = 'John';
```

**Key Learning:** Always use single quotes around text/string values, double quotes are for column names.

---

### Mistake 1.2: Using = Instead of LIKE for Pattern Matching

**Wrong:**
```sql
SELECT * FROM employees WHERE first_name = 'J%';
```

**Problem:** This looks for someone literally named "J%" (including the % symbol).

**Correct:**
```sql
SELECT * FROM employees WHERE first_name LIKE 'J%';
```

**Key Learning:** Use `LIKE` for pattern matching with wildcards (`%`, `_`), use `=` for exact matches.

---

### Mistake 1.3: Confusing AND/OR Logic

**Wrong:**
```sql
-- Trying to find employees in Sales OR Marketing with salary > 50000
SELECT * FROM employees 
WHERE department = 'Sales' OR department = 'Marketing' AND salary > 50000;
```

**Problem:** Due to operator precedence, this finds:
- ALL Sales employees (regardless of salary)
- Marketing employees with salary > 50000

**Correct:**
```sql
SELECT * FROM employees 
WHERE (department = 'Sales' OR department = 'Marketing') AND salary > 50000;
```

**Key Learning:** Use parentheses to control logic order. AND has higher precedence than OR.

---

### Mistake 1.4: Wrong ORDER BY with LIMIT

**Wrong:**
```sql
-- Trying to get top 5 highest-paid employees
SELECT * FROM employees ORDER BY salary LIMIT 5;
```

**Problem:** This gets the 5 LOWEST-paid employees (ascending order is default).

**Correct:**
```sql
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;
```

**Key Learning:** Use `DESC` for highest-to-lowest ordering. Default is `ASC` (ascending).

---

## Module 2: JOIN Mistakes

### Mistake 2.1: Missing JOIN Condition

**Wrong:**
```sql
SELECT e.first_name, d.department_name
FROM employees e, departments d;
```

**Problem:** Creates a Cartesian product - every employee paired with every department.

**Correct:**
```sql
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;
```

**Key Learning:** Always specify JOIN conditions to avoid accidental Cartesian products.

---

### Mistake 2.2: Using Wrong JOIN Type

**Wrong:**
```sql
-- Trying to show all employees and their departments (including employees without departments)
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;
```

**Problem:** INNER JOIN excludes employees without departments.

**Correct:**
```sql
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
```

**Key Learning:** Use LEFT JOIN to preserve all records from the left table.

---

### Mistake 2.3: Ambiguous Column Names

**Wrong:**
```sql
SELECT employee_id, first_name, department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;
```

**Error:** `Error: ambiguous column name: employee_id` (if both tables have this column)

**Correct:**
```sql
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;
```

**Key Learning:** Prefix column names with table aliases when joining tables.

---

### Mistake 2.4: Self-Join Without Proper Aliases

**Wrong:**
```sql
-- Trying to show employees and their managers
SELECT first_name, manager_name
FROM employees e1
INNER JOIN employees e2 ON e1.manager_id = e2.employee_id;
```

**Error:** `Error: ambiguous column name: first_name`

**Correct:**
```sql
SELECT e1.first_name as employee, e2.first_name as manager
FROM employees e1
INNER JOIN employees e2 ON e1.manager_id = e2.employee_id;
```

**Key Learning:** Use clear aliases and column naming in self-joins.

---

## Module 3: GROUP BY Mistakes

### Mistake 3.1: Non-Aggregate Column Not in GROUP BY

**Wrong:**
```sql
SELECT department, first_name, COUNT(*)
FROM employees
GROUP BY department;
```

**Error:** `first_name` must appear in GROUP BY or be an aggregate function.

**Why it's wrong:** SQL doesn't know which `first_name` to show for each department.

**Correct Option 1 (Remove non-aggregate column):**
```sql
SELECT department, COUNT(*)
FROM employees
GROUP BY department;
```

**Correct Option 2 (Add to GROUP BY):**
```sql
SELECT department, first_name, COUNT(*)
FROM employees
GROUP BY department, first_name;
```

**Key Learning:** Every non-aggregate column in SELECT must be in GROUP BY.

---

### Mistake 3.2: Using WHERE Instead of HAVING with Aggregates

**Wrong:**
```sql
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department
WHERE COUNT(*) > 5;
```

**Error:** Cannot use aggregate functions in WHERE clause.

**Correct:**
```sql
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
```

**Key Learning:** Use WHERE for row filtering (before grouping), HAVING for group filtering (after grouping).

---

### Mistake 3.3: Wrong Order of Clauses

**Wrong:**
```sql
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department
WHERE salary > 50000
HAVING COUNT(*) > 2;
```

**Error:** WHERE must come before GROUP BY.

**Correct:**
```sql
SELECT department, COUNT(*) as employee_count
FROM employees
WHERE salary > 50000
GROUP BY department
HAVING COUNT(*) > 2;
```

**Key Learning:** Clause order: SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT.

---

### Mistake 3.4: Misunderstanding COUNT() vs COUNT(*)

**Wrong assumption:**
```sql
-- Thinking these are the same
SELECT COUNT(manager_id) FROM employees;  -- Result: 5
SELECT COUNT(*) FROM employees;           -- Result: 8
```

**Problem:** `COUNT(column)` ignores NULL values, `COUNT(*)` counts all rows.

**When to use each:**
```sql
-- Count all employees (including those without managers)
SELECT COUNT(*) FROM employees;

-- Count employees who have managers
SELECT COUNT(manager_id) FROM employees;

-- Count non-NULL salaries
SELECT COUNT(salary) FROM employees;
```

**Key Learning:** `COUNT(*)` = all rows, `COUNT(column)` = non-NULL values only.

---

## Module 4: Subquery Mistakes

### Mistake 4.1: Using = Instead of IN with Multiple Results

**Wrong:**
```sql
SELECT * FROM employees
WHERE department_id = (
    SELECT department_id FROM departments 
    WHERE department_name LIKE '%Sales%'
);
```

**Error:** Subquery returns more than one row (if multiple Sales departments exist).

**Correct:**
```sql
SELECT * FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments 
    WHERE department_name LIKE '%Sales%'
);
```

**Key Learning:** Use `IN` when subquery might return multiple values, `=` only for single values.

---

### Mistake 4.2: Correlated Subquery Performance Issues

**Inefficient:**
```sql
SELECT * FROM employees e
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees e2 
    WHERE e2.department_id = e.department_id
);
```

**Problem:** Subquery runs once for each employee row (very slow).

**More Efficient (using window functions):**
```sql
SELECT employee_id, first_name, salary, department_id
FROM (
    SELECT employee_id, first_name, salary, department_id,
           AVG(salary) OVER (PARTITION BY department_id) as dept_avg
    FROM employees
) t
WHERE salary > dept_avg;
```

**Key Learning:** Consider window functions as alternatives to correlated subqueries.

---

### Mistake 4.3: NOT IN with NULL Values

**Wrong:**
```sql
SELECT * FROM employees
WHERE department_id NOT IN (
    SELECT department_id FROM departments WHERE budget < 100000
);
```

**Problem:** If any department has NULL budget, NOT IN returns no results.

**Correct:**
```sql
SELECT * FROM employees
WHERE department_id NOT IN (
    SELECT department_id FROM departments 
    WHERE budget < 100000 AND department_id IS NOT NULL
);
```

**Or better, use NOT EXISTS:**
```sql
SELECT * FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM departments d 
    WHERE d.department_id = e.department_id AND d.budget < 100000
);
```

**Key Learning:** NOT IN fails with NULLs. Use NOT EXISTS or filter out NULLs.

---

## Module 5: NULL Handling Mistakes

### Mistake 5.1: Using = NULL Instead of IS NULL

**Wrong:**
```sql
SELECT * FROM employees WHERE manager_id = NULL;
```

**Problem:** Returns no results. `= NULL` always evaluates to unknown, not true.

**Correct:**
```sql
SELECT * FROM employees WHERE manager_id IS NULL;
```

**Key Learning:** Use `IS NULL` and `IS NOT NULL` for NULL comparisons.

---

### Mistake 5.2: Forgetting NULL Impact on Calculations

**Wrong assumption:**
```sql
-- Expecting this to give meaningful results when some salaries are NULL
SELECT employee_id, salary, salary * 1.1 as new_salary
FROM employees;
```

**Problem:** Any calculation with NULL results in NULL.

**Correct:**
```sql
SELECT employee_id, salary, 
       CASE 
           WHEN salary IS NOT NULL THEN salary * 1.1 
           ELSE NULL 
       END as new_salary
FROM employees;

-- Or using COALESCE for defaults
SELECT employee_id, salary, 
       COALESCE(salary, 0) * 1.1 as new_salary
FROM employees;
```

**Key Learning:** Plan for NULL values in calculations and provide appropriate handling.

---

### Mistake 5.3: Misunderstanding COALESCE

**Wrong:**
```sql
-- Thinking COALESCE works like IF-ELSE
SELECT COALESCE(department, 'Sales', 'Unknown') FROM employees;
```

**Problem:** COALESCE returns the first non-NULL value, not conditional logic.

**Correct understanding:**
```sql
-- COALESCE returns first non-NULL value
SELECT COALESCE(department, 'Unknown') FROM employees;

-- For conditional logic, use CASE
SELECT CASE 
    WHEN department = 'Sales' THEN 'Sales Team'
    ELSE 'Other Team'
END FROM employees;
```

**Key Learning:** COALESCE replaces NULL values, CASE does conditional logic.

---

## Module 6: Window Function Mistakes

### Mistake 6.1: Forgetting OVER() Clause

**Wrong:**
```sql
SELECT first_name, salary, RANK() as salary_rank
FROM employees;
```

**Error:** Window functions require OVER() clause.

**Correct:**
```sql
SELECT first_name, salary, RANK() OVER (ORDER BY salary DESC) as salary_rank
FROM employees;
```

**Key Learning:** All window functions need OVER() to define the window.

---

### Mistake 6.2: Confusing RANK() vs ROW_NUMBER()

**Wrong expectation:**
```sql
-- Expecting unique sequential numbers, but getting: 1, 2, 2, 4
SELECT first_name, salary, RANK() OVER (ORDER BY salary DESC) as rank_num
FROM employees;
```

**Problem:** RANK() gives same rank to tied values and skips numbers.

**Choose the right function:**
```sql
-- For unique sequential numbers (1, 2, 3, 4)
SELECT first_name, salary, ROW_NUMBER() OVER (ORDER BY salary DESC) as row_num
FROM employees;

-- For tied ranks that skip numbers (1, 2, 2, 4)
SELECT first_name, salary, RANK() OVER (ORDER BY salary DESC) as rank_num
FROM employees;

-- For tied ranks without skipping (1, 2, 2, 3)
SELECT first_name, salary, DENSE_RANK() OVER (ORDER BY salary DESC) as dense_rank
FROM employees;
```

**Key Learning:** Choose ranking function based on how you want ties handled.

---

### Mistake 6.3: Wrong PARTITION BY Usage

**Wrong:**
```sql
-- Trying to rank employees within departments, but ranking globally
SELECT first_name, department, salary, 
       RANK() OVER (ORDER BY salary DESC) as dept_rank
FROM employees;
```

**Problem:** Missing PARTITION BY, so ranking is global, not per department.

**Correct:**
```sql
SELECT first_name, department, salary, 
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dept_rank
FROM employees;
```

**Key Learning:** Use PARTITION BY to create separate windows for different groups.

---

## Module 7: CTE Mistakes

### Mistake 7.1: Trying to Reference CTE Multiple Times

**Wrong:**
```sql
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 80000
)
SELECT * FROM high_earners
UNION
SELECT * FROM high_earners WHERE department = 'Sales';
```

**Error:** Cannot reference CTE multiple times in same query level.

**Correct approach:**
```sql
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 80000
)
SELECT * FROM high_earners
UNION
SELECT * FROM employees WHERE salary > 80000 AND department = 'Sales';

-- Or restructure logic
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 80000
)
SELECT *, 
       CASE WHEN department = 'Sales' THEN 'High Sales Earner' 
            ELSE 'High Earner' END as category
FROM high_earners;
```

**Key Learning:** Restructure logic to avoid multiple CTE references.

---

### Mistake 7.2: Missing Base Case in Recursive CTE

**Wrong:**
```sql
WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, first_name, manager_id, 0 as level
    FROM employees
    WHERE manager_id IS NOT NULL  -- Wrong! This has no base case
    
    UNION ALL
    
    SELECT e.employee_id, e.first_name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy;
```

**Problem:** No base case (starting point), may cause infinite recursion.

**Correct:**
```sql
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: top-level employees
    SELECT employee_id, first_name, manager_id, 0 as level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case
    SELECT e.employee_id, e.first_name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy;
```

**Key Learning:** Recursive CTEs need a clear base case to prevent infinite loops.

---

## Performance & Best Practice Mistakes

### Mistake 8.1: Using SELECT * in Production

**Wrong:**
```sql
SELECT * FROM employees WHERE department = 'Sales';
```

**Problems:**
- Returns unnecessary data
- Breaks when table structure changes
- Poor performance with large tables

**Correct:**
```sql
SELECT employee_id, first_name, last_name, salary
FROM employees 
WHERE department = 'Sales';
```

**Key Learning:** Always specify needed columns explicitly.

---

### Mistake 8.2: No LIMIT on Exploratory Queries

**Wrong:**
```sql
-- Running on a table with millions of rows
SELECT * FROM order_history WHERE order_date > '2020-01-01';
```

**Problem:** May return millions of rows and crash your system.

**Correct:**
```sql
SELECT * FROM order_history 
WHERE order_date > '2020-01-01'
LIMIT 100;  -- Safe exploration
```

**Key Learning:** Always use LIMIT when exploring large datasets.

---

### Mistake 8.3: Using Functions in WHERE Clause

**Inefficient:**
```sql
SELECT * FROM orders WHERE YEAR(order_date) = 2023;
```

**Problem:** Function on column prevents index usage.

**More Efficient:**
```sql
SELECT * FROM orders 
WHERE order_date >= '2023-01-01' AND order_date < '2024-01-01';
```

**Key Learning:** Avoid functions on columns in WHERE clauses for better performance.

---

## Quick Reference: Error Prevention Checklist

### Before Running Any Query:
- [ ] **Text values** in single quotes
- [ ] **JOIN conditions** specified
- [ ] **Aggregate columns** in GROUP BY
- [ ] **Column aliases** for ambiguous names
- [ ] **NULL handling** considered
- [ ] **LIMIT clause** for large tables
- [ ] **Syntax order**: SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY

### Common Red Flags:
- `= NULL` instead of `IS NULL`
- `WHERE` with aggregate functions (use `HAVING`)
- Window functions without `OVER()`
- `NOT IN` with potential NULL values
- Missing quotes around text values
- `SELECT *` in production code

### When Debugging Errors:
1. **Check syntax order** - clauses must be in correct sequence
2. **Verify quotes** - single quotes for values, double for column names
3. **Confirm JOIN conditions** - avoid Cartesian products
4. **Review GROUP BY** - all non-aggregate SELECT columns must be grouped
5. **Test incrementally** - build complex queries step by step

---

## Learning from Mistakes

### Best Practices:
1. **Start simple** - build complex queries incrementally
2. **Test with small data** - use LIMIT during development
3. **Read error messages** - they often point to the exact problem
4. **Use consistent formatting** - makes errors easier to spot
5. **Comment your logic** - explain complex parts for future you

### Recovery Strategies:
- **Break down complex queries** into CTEs or subqueries
- **Run parts separately** to isolate problems
- **Use EXPLAIN** to understand performance issues
- **Validate results** with known data sets

**Remember:** Every expert was once a beginner who made these same mistakes. Learn from them and keep practicing! 
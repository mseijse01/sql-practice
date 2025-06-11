# 🧠 SQL Self-Assessment Quiz

Test your understanding of SQL concepts with this comprehensive quiz. Each module has questions ranging from beginner to advanced levels.

## How to Use This Quiz
- ✅ Answer each question honestly before checking the solution
- 📊 Track your score to identify knowledge gaps  
- 🔄 Retake sections after studying to measure improvement
- 🎯 Aim for 80%+ before moving to the next module

---

## 📊 Module 1: Basic SELECT Operations

### Question 1.1 (Beginner)
**What is the correct SQL syntax to select only the `first_name` and `last_name` columns from an `employees` table?**

A) `SELECT first_name, last_name FROM employees;`
B) `SELECT employees.first_name, employees.last_name;`
C) `GET first_name, last_name FROM employees;`
D) `SELECT (first_name, last_name) FROM employees;`

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: A**

**Explanation:** 
- Option A is the correct syntax for selecting specific columns
- Option B would work but is unnecessarily verbose when using one table
- Option C uses `GET` which is not a valid SQL command
- Option D uses incorrect parentheses syntax

**Key Learning:** Column names are separated by commas, and `SELECT` is followed by column names, then `FROM` and table name.
</details>

### Question 1.2 (Intermediate)
**Which query will return employees with salaries between 50,000 and 80,000, ordered by salary from highest to lowest?**

A) `SELECT * FROM employees WHERE salary >= 50000 AND salary <= 80000 ORDER BY salary;`
B) `SELECT * FROM employees WHERE salary BETWEEN 50000 AND 80000 ORDER BY salary DESC;`
C) `SELECT * FROM employees WHERE salary > 50000 OR salary < 80000 ORDER BY salary;`
D) `SELECT * FROM employees HAVING salary BETWEEN 50000 AND 80000 ORDER BY salary DESC;`

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- Option A is missing `DESC` for highest to lowest ordering
- Option B correctly uses `BETWEEN` (inclusive) and `DESC` for descending order
- Option C uses `OR` instead of `AND`, which would return almost all records
- Option D uses `HAVING` which is for aggregate functions, not row-level filtering

**Key Learning:** `BETWEEN` is inclusive, `ORDER BY DESC` sorts highest to lowest, and `WHERE` is used for row filtering.
</details>

### Question 1.3 (Advanced)
**What will this query return: `SELECT * FROM employees WHERE first_name LIKE 'J%' AND last_name NOT LIKE '%son' LIMIT 5;`**

A) First 5 employees whose first name starts with 'J' and last name ends with 'son'
B) First 5 employees whose first name starts with 'J' and last name doesn't end with 'son'
C) All employees with 'J' anywhere in first name and without 'son' anywhere in last name
D) Error - cannot combine LIKE with NOT LIKE

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- `first_name LIKE 'J%'` matches names starting with 'J'
- `last_name NOT LIKE '%son'` excludes names ending with 'son'
- `LIMIT 5` restricts results to first 5 matches
- Both conditions must be true due to `AND`

**Key Learning:** `%` is a wildcard for any characters, `NOT LIKE` excludes patterns, and `LIMIT` restricts result count.
</details>

---

## 🔗 Module 2: JOIN Operations

### Question 2.1 (Beginner)
**What is the main difference between INNER JOIN and LEFT JOIN?**

A) INNER JOIN is faster than LEFT JOIN
B) LEFT JOIN returns all records from the left table, INNER JOIN only returns matches
C) INNER JOIN can join more than 2 tables, LEFT JOIN cannot
D) There is no difference

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- INNER JOIN returns only records that have matches in both tables
- LEFT JOIN returns ALL records from the left table, plus matching records from the right table
- Performance depends on data and indexes, not join type
- Both can join multiple tables

**Key Learning:** Choose INNER JOIN when you only want matches, LEFT JOIN when you want all records from one table regardless of matches.
</details>

### Question 2.2 (Intermediate)
**Given tables `employees` and `departments`, which query finds employees who DON'T have a department assigned?**

A) `SELECT * FROM employees e INNER JOIN departments d ON e.department_id = d.department_id WHERE d.department_id IS NULL;`
B) `SELECT * FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id WHERE d.department_id IS NULL;`
C) `SELECT * FROM employees WHERE department_id IS NULL;`
D) Both B and C are correct

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: D**

**Explanation:**
- Option A won't work because INNER JOIN excludes unmatched records
- Option B uses LEFT JOIN to preserve unmatched employees, then filters for NULL departments
- Option C directly checks for NULL department_id in employees table
- Both B and C will find employees without departments, but C is simpler

**Key Learning:** To find unmatched records, use LEFT JOIN + IS NULL or directly check for NULL values.
</details>

### Question 2.3 (Advanced)
**What does this query accomplish: `SELECT e1.first_name as employee, e2.first_name as manager FROM employees e1 LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;`**

A) Shows all employees and their managers (self-join)
B) Shows only employees who have managers
C) Creates an error because you can't join a table to itself
D) Shows duplicate employee records

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: A**

**Explanation:**
- This is a self-join where the employees table is joined to itself
- `e1` represents employees, `e2` represents managers (who are also employees)
- LEFT JOIN ensures all employees appear, even those without managers
- Aliases (`e1`, `e2`) allow referencing the same table twice

**Key Learning:** Self-joins are powerful for hierarchical relationships within a single table.
</details>

---

## 📈 Module 3: GROUP BY and Aggregates

### Question 3.1 (Beginner)
**Which aggregate function would you use to find the total sales amount across all orders?**

A) `COUNT(total_amount)`
B) `AVG(total_amount)`
C) `SUM(total_amount)`
D) `MAX(total_amount)`

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: C**

**Explanation:**
- `SUM()` adds up all values to get a total
- `COUNT()` counts number of records, not values
- `AVG()` calculates average, not total
- `MAX()` finds highest value, not total

**Key Learning:** Use `SUM()` for totals, `COUNT()` for quantities, `AVG()` for averages, `MIN()/MAX()` for extremes.
</details>

### Question 3.2 (Intermediate)
**What's wrong with this query: `SELECT category, product_name, COUNT(*) FROM products GROUP BY category;`**

A) Nothing - it's correct
B) `product_name` should be in GROUP BY clause or removed
C) `COUNT(*)` should be `COUNT(product_name)`
D) Missing HAVING clause

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- All non-aggregate columns in SELECT must be in GROUP BY
- `product_name` is not grouped, so SQL doesn't know which product name to show for each category
- This would cause an error in most SQL databases
- Either add `product_name` to GROUP BY or remove it from SELECT

**Key Learning:** GROUP BY rule: Every non-aggregate column in SELECT must be in GROUP BY.
</details>

### Question 3.3 (Advanced)
**When would you use HAVING instead of WHERE in a query with GROUP BY?**

A) HAVING is faster than WHERE
B) HAVING filters groups after aggregation, WHERE filters rows before aggregation
C) HAVING works with text, WHERE works with numbers
D) They're interchangeable

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- WHERE filters individual rows before grouping occurs
- HAVING filters groups after aggregation calculations
- Use WHERE to filter raw data, HAVING to filter aggregated results
- Example: `WHERE salary > 50000` vs `HAVING AVG(salary) > 50000`

**Key Learning:** WHERE = row filter (before grouping), HAVING = group filter (after aggregation).
</details>

---

## 🔍 Module 4: Subqueries

### Question 4.1 (Beginner)
**What is a subquery?**

A) A query that runs faster than regular queries
B) A query nested inside another query
C) A query that uses multiple tables
D) A query with GROUP BY

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- A subquery is a query within another query, enclosed in parentheses
- Also called inner query or nested query
- Can be used in SELECT, WHERE, FROM, or HAVING clauses
- Speed depends on data and complexity, not query type

**Key Learning:** Subqueries allow complex logic by nesting one query inside another.
</details>

### Question 4.2 (Intermediate)
**Which subquery type can reference columns from the outer query?**

A) Scalar subquery
B) Correlated subquery
C) Derived table
D) EXISTS subquery

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- Correlated subqueries reference columns from the outer query
- They execute once for each row of the outer query
- Non-correlated subqueries execute once independently
- EXISTS subqueries are often correlated but not always

**Key Learning:** Correlated subqueries create dependencies between inner and outer queries.
</details>

### Question 4.3 (Advanced)
**What's the difference between EXISTS and IN with subqueries?**

A) EXISTS is faster than IN
B) EXISTS returns boolean, IN compares values
C) IN can handle NULL values better than EXISTS
D) They're identical in functionality

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- EXISTS returns TRUE/FALSE based on whether subquery returns any rows
- IN compares a value against a list of values from subquery
- EXISTS handles NULLs better than IN
- Performance depends on data distribution and indexes

**Key Learning:** Use EXISTS for "does this exist?" logic, IN for "is this value in this list?" logic.
</details>

---

## ❓ Module 5: NULL Handling

### Question 5.1 (Beginner)
**Which operator correctly checks for NULL values?**

A) `= NULL`
B) `== NULL`
C) `IS NULL`
D) `EQUALS NULL`

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: C**

**Explanation:**
- NULL represents unknown/missing data, not a specific value
- `= NULL` always returns unknown (not true or false)
- `IS NULL` and `IS NOT NULL` are the correct NULL comparison operators
- Never use `=` or `!=` with NULL

**Key Learning:** NULL is not a value - it's the absence of a value. Use `IS NULL` / `IS NOT NULL`.
</details>

### Question 5.2 (Intermediate)
**What will `COALESCE(NULL, NULL, 'default', 'backup')` return?**

A) NULL
B) 'default'
C) 'backup'
D) Error

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- COALESCE returns the first non-NULL value from left to right
- It skips the first two NULL values
- Returns 'default' as the first non-NULL value
- Stops evaluating once it finds a non-NULL value

**Key Learning:** COALESCE is perfect for providing default values when data might be NULL.
</details>

### Question 5.3 (Advanced)
**How do NULLs affect aggregate functions like COUNT() and SUM()?**

A) They cause errors
B) COUNT() includes NULLs, SUM() excludes them
C) COUNT(*) includes NULLs, COUNT(column) and SUM() exclude them
D) All aggregates treat NULLs the same way

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: C**

**Explanation:**
- `COUNT(*)` counts all rows including those with NULLs
- `COUNT(column)` counts only non-NULL values in that column
- `SUM()`, `AVG()`, `MIN()`, `MAX()` ignore NULL values
- If all values are NULL, SUM() returns NULL (not 0)

**Key Learning:** Be careful with NULLs in calculations - they're ignored by most aggregates.
</details>

---

## 📊 Module 6: Window Functions (Advanced)

### Question 6.1 (Intermediate)
**What's the main difference between GROUP BY and window functions?**

A) Window functions are faster
B) GROUP BY collapses rows, window functions preserve all rows
C) Window functions can't do aggregation
D) They're the same thing

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- GROUP BY reduces rows by grouping them into summary rows
- Window functions calculate across sets of rows but return a result for each original row
- Window functions use OVER() clause to define the "window"
- Both can do aggregation, but with different row output

**Key Learning:** Use GROUP BY to summarize data, window functions to add calculated columns.
</details>

### Question 6.2 (Advanced)
**What does `PARTITION BY` do in a window function?**

A) Sorts the data
B) Divides data into groups for separate window calculations
C) Limits the number of rows returned
D) Joins tables together

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- PARTITION BY creates separate "windows" for each group
- Window function calculations restart for each partition
- Similar to GROUP BY but doesn't collapse rows
- Without PARTITION BY, the entire result set is one window

**Key Learning:** PARTITION BY creates separate calculation windows without collapsing rows.
</details>

### Question 6.3 (Advanced)
**What's the difference between RANK() and ROW_NUMBER()?**

A) RANK() is faster than ROW_NUMBER()
B) ROW_NUMBER() gives unique sequential numbers, RANK() can have ties
C) RANK() can only rank numbers, ROW_NUMBER() works with text
D) There's no difference

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- ROW_NUMBER() assigns unique sequential numbers (1,2,3,4...)
- RANK() assigns same rank to tied values, then skips ranks (1,2,2,4...)
- DENSE_RANK() also handles ties but doesn't skip ranks (1,2,2,3...)
- Both can work with any data type for ordering

**Key Learning:** Use ROW_NUMBER() for unique numbering, RANK() when ties should have same rank.
</details>

---

## 🏗️ Module 7: Common Table Expressions (Advanced)

### Question 7.1 (Intermediate)
**What is the main benefit of using CTEs (Common Table Expressions)?**

A) They make queries run faster
B) They improve query readability and organization
C) They can only be used with SELECT statements
D) They automatically optimize queries

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- CTEs make complex queries more readable by breaking them into logical steps
- They act like temporary named result sets
- Performance is similar to subqueries (not necessarily faster)
- Can be used with SELECT, INSERT, UPDATE, DELETE

**Key Learning:** Use CTEs to organize complex queries into readable, logical steps.
</details>

### Question 7.2 (Advanced)
**When do you need the RECURSIVE keyword in a CTE?**

A) When joining multiple tables
B) When the CTE references itself
C) When using aggregate functions
D) Always - it's required for all CTEs

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- RECURSIVE is needed when the CTE references itself in its definition
- Used for hierarchical data (org charts, categories, etc.)
- Requires a base case and recursive case
- Most CTEs are not recursive and don't need this keyword

**Key Learning:** Use RECURSIVE CTEs for hierarchical or tree-structured data.
</details>

### Question 7.3 (Advanced)
**In a recursive CTE, what prevents infinite loops?**

A) The database automatically stops after 100 iterations
B) The recursive case eventually returns no new rows
C) You must include a LIMIT clause
D) Recursive CTEs can't create infinite loops

<details>
<summary>🔍 Click for Answer & Explanation</summary>

**✅ Correct Answer: B**

**Explanation:**
- Recursion stops when the recursive part returns no new rows
- Proper design ensures the recursive condition eventually becomes false
- Some databases have max recursion limits as safety nets
- Poor design can create infinite loops (avoid with proper WHERE conditions)

**Key Learning:** Design recursive CTEs so the recursive condition eventually fails to find new rows.
</details>

---

## 📊 Quiz Results Tracker

### Scoring Guide:
- **90-100%**: 🌟 Expert Level - Ready for advanced challenges!
- **80-89%**: ✅ Proficient - Minor review needed
- **70-79%**: 📚 Good Foundation - Focus on weak areas  
- **60-69%**: 🔄 Needs Practice - Review concepts and retry
- **Below 60%**: 📖 Study Required - Work through learning modules

### Track Your Progress:
```
Module 1 (Basic SELECT):     [ ] Score: ___/3  (%___)
Module 2 (JOINs):           [ ] Score: ___/3  (%___)
Module 3 (GROUP BY):        [ ] Score: ___/3  (%___)
Module 4 (Subqueries):      [ ] Score: ___/3  (%___)
Module 5 (NULL Handling):   [ ] Score: ___/3  (%___)
Module 6 (Window Functions): [ ] Score: ___/3  (%___)
Module 7 (CTEs):           [ ] Score: ___/3  (%___)

Overall Score: ___/21 (___%)
```

### Next Steps Based on Your Score:
- **High scores (80%+)**: Move to `interview-prep/` challenges
- **Medium scores (60-79%)**: Review specific topics, then retry quiz
- **Low scores (<60%)**: Study `learning/` modules thoroughly

---

## 🎯 Quick Reference: Key Concepts to Remember

### Essential SQL Rules:
1. **SELECT basics**: Column names separated by commas
2. **JOIN logic**: INNER = matches only, LEFT = all left table rows
3. **GROUP BY rule**: All non-aggregate SELECT columns must be in GROUP BY
4. **NULL handling**: Use `IS NULL`, never `= NULL`
5. **Window functions**: Use OVER() clause, preserve all rows
6. **CTEs**: Use WITH clause, improve readability

### Common Interview Topics:
- Writing efficient JOINs
- Handling NULL values properly
- Using window functions for analytics
- Optimizing queries with proper WHERE clauses
- Explaining query execution logic

**Ready to test your skills further?** Try the `interview-prep/` challenges! 
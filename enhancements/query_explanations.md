# SQL Query Explanations Guide

Deep dive into complex SQL queries with step-by-step breakdowns. This guide demystifies challenging concepts and helps you understand the logic behind advanced SQL patterns.

## How to Use This Guide
- Start with the full query to see the complete picture
- Follow the step-by-step breakdown to understand each part
- Focus on the "Why" behind each decision
- Try variations to test your understanding

---

## Complex JOIN with Self-Reference

### The Query:
```sql
SELECT e1.first_name as employee, 
       e2.first_name as manager,
       d.department_name,
       e1.salary,
       e1.salary - AVG(e1.salary) OVER (PARTITION BY d.department_id) as vs_dept_avg
FROM employees e1 
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id
INNER JOIN departments d ON e1.department_id = d.department_id
WHERE e1.is_active = 1
ORDER BY d.department_name, e1.salary DESC;
```

### Step-by-Step Breakdown:

#### Step 1: Table Aliases and Self-Join Setup
```sql
FROM employees e1 
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id
```
**What's happening:**
- `e1` represents the employee record
- `e2` represents the manager record (same table, different alias)
- **LEFT JOIN** ensures we see ALL employees, even those without managers
- **Why LEFT JOIN?** Some employees might not have a manager (CEO, vacant positions)

#### Step 2: Department Information
```sql
INNER JOIN departments d ON e1.department_id = d.department_id
```
**What's happening:**
- Links employees to their department information
- **INNER JOIN** because we only want employees who have departments
- **Why INNER?** If an employee has no department, they might be invalid data

#### Step 3: Window Function for Department Comparison
```sql
e1.salary - AVG(e1.salary) OVER (PARTITION BY d.department_id) as vs_dept_avg
```
**What's happening:**
- `AVG(e1.salary) OVER (PARTITION BY d.department_id)` calculates average salary within each department
- `PARTITION BY` creates separate calculations for each department
- The subtraction shows how much above/below department average each employee is
- **Window functions preserve all rows** while adding aggregate calculations

#### Step 4: Filtering and Sorting
```sql
WHERE e1.is_active = 1
ORDER BY d.department_name, e1.salary DESC;
```
**What's happening:**
- Only show active employees
- Sort by department first, then highest salary within each department

### Key Learning Points:
1. **Self-joins** let you relate records within the same table
2. **LEFT JOIN** preserves unmatched records (employees without managers)
3. **Window functions** add calculations without collapsing rows
4. **Alias clarity** makes complex queries readable

---

## Advanced Window Function with Multiple Rankings

### The Query:
```sql
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
       NTILE(4) OVER (ORDER BY total_spent DESC) as spending_quartile,
       total_spent - AVG(total_spent) OVER () as vs_avg_spending,
       CASE 
           WHEN total_spent > AVG(total_spent) OVER () * 1.5 THEN 'Premium'
           WHEN total_spent > AVG(total_spent) OVER () THEN 'Above Average'
           ELSE 'Standard'
       END as customer_tier
FROM customer_metrics
ORDER BY total_spent DESC;
```

### Step-by-Step Breakdown:

#### Step 1: CTE for Data Preparation
```sql
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
```
**What's happening:**
- **CTE** creates a temporary result set with customer metrics
- **GROUP BY** aggregates all orders per customer
- **INNER JOIN** only includes customers who have placed orders
- **WHERE** filters to completed orders only (ignores cancelled/pending)

#### Step 2: Multiple Ranking Functions
```sql
RANK() OVER (ORDER BY total_spent DESC) as spending_rank,
PERCENT_RANK() OVER (ORDER BY total_spent) as spending_percentile,
NTILE(4) OVER (ORDER BY total_spent DESC) as spending_quartile,
```
**What's happening:**
- **RANK()** gives spending rank (1, 2, 3, etc.) with ties handled properly
- **PERCENT_RANK()** shows what percentile each customer is in (0.0 to 1.0)
- **NTILE(4)** divides customers into 4 equal groups (quartiles)
- **All use same data** but provide different perspectives

#### Step 3: Comparative Analysis
```sql
total_spent - AVG(total_spent) OVER () as vs_avg_spending,
```
**What's happening:**
- `AVG(total_spent) OVER ()` calculates overall average (empty OVER = entire dataset)
- Subtraction shows how much above/below average each customer spends
- **Positive = above average, Negative = below average**

#### Step 4: Business Logic Categorization
```sql
CASE 
    WHEN total_spent > AVG(total_spent) OVER () * 1.5 THEN 'Premium'
    WHEN total_spent > AVG(total_spent) OVER () THEN 'Above Average'
    ELSE 'Standard'
END as customer_tier
```
**What's happening:**
- **CASE statement** creates business categories
- **1.5 * average** = Premium tier threshold
- **Above average** = good customers
- **Everyone else** = Standard tier

### Key Learning Points:
1. **CTEs** simplify complex queries by breaking them into logical steps
2. **Multiple window functions** can provide different analytical perspectives
3. **OVER ()** with no PARTITION BY means "entire dataset"
4. **Business logic** can be embedded using CASE statements

---

## Recursive CTE for Hierarchical Data

### The Query:
```sql
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: Top-level managers (no manager)
    SELECT employee_id, first_name, last_name, manager_id,
           first_name || ' ' || last_name as full_name,
           0 as level,
           CAST(first_name || ' ' || last_name AS TEXT) as hierarchy_path
    FROM employees 
    WHERE manager_id IS NULL AND is_active = 1
    
    UNION ALL
    
    -- Recursive case: Employees with managers
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id,
           e.first_name || ' ' || e.last_name as full_name,
           eh.level + 1,
           eh.hierarchy_path || ' -> ' || e.first_name || ' ' || e.last_name
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
    WHERE e.is_active = 1
)
SELECT level,
       REPEAT('  ', level) || full_name as indented_name,
       hierarchy_path,
       CASE level
           WHEN 0 THEN 'CEO/President'
           WHEN 1 THEN 'Senior Management'  
           WHEN 2 THEN 'Middle Management'
           ELSE 'Staff Level'
       END as org_level
FROM employee_hierarchy
ORDER BY hierarchy_path;
```

### Step-by-Step Breakdown:

#### Step 1: Understanding Recursive CTE Structure
```sql
WITH RECURSIVE employee_hierarchy AS (
    -- Base case
    ...
    UNION ALL
    -- Recursive case
    ...
)
```
**What's happening:**
- **RECURSIVE** keyword enables self-referencing CTE
- **Base case** defines starting point (top-level employees)
- **UNION ALL** combines base case with recursive results
- **Recursive case** references the CTE itself

#### Step 2: Base Case - Starting Point
```sql
SELECT employee_id, first_name, last_name, manager_id,
       first_name || ' ' || last_name as full_name,
       0 as level,
       CAST(first_name || ' ' || last_name AS TEXT) as hierarchy_path
FROM employees 
WHERE manager_id IS NULL AND is_active = 1
```
**What's happening:**
- **manager_id IS NULL** finds top-level employees (CEO, Presidents)
- **level = 0** marks these as the top level
- **hierarchy_path** starts with just their name
- **CAST** ensures text concatenation works properly

#### Step 3: Recursive Case - Building the Hierarchy
```sql
SELECT e.employee_id, e.first_name, e.last_name, e.manager_id,
       e.first_name || ' ' || e.last_name as full_name,
       eh.level + 1,
       eh.hierarchy_path || ' -> ' || e.first_name || ' ' || e.last_name
FROM employees e
INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
WHERE e.is_active = 1
```
**What's happening:**
- **Joins employees to the CTE itself** (employees to their managers already found)
- **eh.level + 1** increments the hierarchy level
- **Concatenates hierarchy path** showing the chain of command
- **INNER JOIN** ensures we only get employees whose managers we've already processed

#### Step 4: How Recursion Works
1. **First iteration:** Finds all top-level managers (level 0)
2. **Second iteration:** Finds all employees reporting to level 0 managers (level 1)
3. **Third iteration:** Finds all employees reporting to level 1 managers (level 2)
4. **Continues until:** No more employees found (everyone is processed)

#### Step 5: Final Output Formatting
```sql
SELECT level,
       REPEAT('  ', level) || full_name as indented_name,
       hierarchy_path,
       CASE level
           WHEN 0 THEN 'CEO/President'
           WHEN 1 THEN 'Senior Management'
           WHEN 2 THEN 'Middle Management'
           ELSE 'Staff Level'
       END as org_level
FROM employee_hierarchy
ORDER BY hierarchy_path;
```
**What's happening:**
- **REPEAT('  ', level)** adds indentation based on hierarchy level
- **hierarchy_path** shows full chain of command
- **CASE statement** provides business-friendly level names
- **ORDER BY hierarchy_path** keeps related employees together

### Key Learning Points:
1. **Recursive CTEs** handle hierarchical data (org charts, categories, etc.)
2. **Base case** prevents infinite loops by defining starting point
3. **Level tracking** helps understand depth in hierarchy
4. **Path building** creates audit trails and visual representations

---

## Complex Date Analysis with Window Functions

### The Query:
```sql
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
```

### Step-by-Step Breakdown:

#### Step 1: Monthly Aggregation Setup
```sql
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
```
**What's happening:**
- **strftime('%Y-%m', o.order_date)** converts dates to YYYY-MM format
- **SUM(oi.quantity * oi.unit_price)** calculates total sales value
- **GROUP BY** aggregates sales by product and month
- **Result:** One row per product per month with total sales

#### Step 2: LAG Function for Previous Period
```sql
LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month) as prev_month_sales,
```
**What's happening:**
- **LAG()** looks at the previous row's value
- **PARTITION BY product_name** keeps each product's data separate
- **ORDER BY month** ensures chronological ordering
- **Result:** Each row shows current month and previous month sales

#### Step 3: Calculating Absolute Change
```sql
monthly_sales - LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month) as month_over_month_change,
```
**What's happening:**
- **Simple subtraction** shows dollar amount change
- **Positive = growth, Negative = decline**
- **First month for each product** will be NULL (no previous month)

#### Step 4: Percentage Change Calculation
```sql
CASE 
    WHEN LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month) IS NULL THEN NULL
    ELSE ROUND((monthly_sales - LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month)) * 100.0 / 
               LAG(monthly_sales) OVER (PARTITION BY product_name ORDER BY month), 2)
END as month_over_month_pct_change
```
**What's happening:**
- **CASE handles NULL** values (first month has no previous month)
- **Percentage formula:** (New - Old) / Old * 100
- **ROUND()** keeps results to 2 decimal places
- **100.0** ensures decimal division

### Key Learning Points:
1. **Date functions** like strftime() enable time-based grouping
2. **LAG/LEAD** functions compare current row with previous/next row
3. **PARTITION BY** keeps related data together for window calculations
4. **Percentage calculations** require careful NULL handling

---

## Query Pattern Recognition

### When to Use Each Pattern:

#### **Self-Joins** 
Use for: Employee-manager relationships, product categories, any hierarchical data in one table
Key technique: Same table with different aliases

#### **Window Functions**
Use for: Rankings, running totals, period-over-period comparisons, analytics
Key technique: OVER() clause with optional PARTITION BY and ORDER BY

#### **Recursive CTEs**
Use for: Organizational charts, bill of materials, category trees, path finding
Key technique: Base case + recursive case with UNION ALL

#### **LAG/LEAD Functions**
Use for: Trend analysis, comparing with previous/next periods
Key technique: PARTITION BY for grouping, ORDER BY for sequence

---

## Practice Recommendations

### After Reading These Explanations:

1. **Modify the Queries**
   - Change the window function partitions
   - Add different ranking functions
   - Experiment with date ranges

2. **Apply to Your Data**
   - Try similar patterns on your own datasets
   - Adapt the business logic to your use cases

3. **Build Complexity Gradually**
   - Start with simple window functions
   - Add CTEs for organization
   - Combine multiple advanced features

4. **Focus on Business Value**
   - Always ask "What business question does this answer?"
   - Ensure your queries solve real problems

**Ready for more challenges?** Head to the `interview-prep/` folders to test these concepts! 
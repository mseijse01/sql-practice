# SQL Practice Repository

A comprehensive collection of SQL exercises I've created for continuous learning and technical interview preparation. This repository demonstrates practical SQL skills through realistic business scenarios and progressively challenging exercises.

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Topics Covered](#topics-covered)
- [Learning Workflow](#learning-workflow)
- [Running the SQL Files](#running-the-sql-files)
- [Study Recommendations](#study-recommendations)
- [Additional Resources](#additional-resources)

## Overview

This repository contains **5 structured SQL practice files** with realistic business scenarios and progressively challenging exercises. Each file focuses on specific SQL concepts commonly tested in technical interviews, from basic SELECT statements to complex subqueries and NULL handling.

**Designed for:**
- Continuous SQL skill development
- Technical interview preparation
- Database fundamentals reinforcement
- Practical SQL application learning

## Repository Structure

```
sql-practice/
├── learning/                         # Beginner-friendly examples with solutions
│   ├── 01_basic_select.sql          # Complete examples with explanations
│   ├── 02_joins.sql                 # Pattern learning with solutions
│   ├── 03_group_by_aggregates.sql   # Worked examples and explanations
│   ├── 04_subqueries.sql            # Step-by-step subquery examples
│   └── 05_null_handling.sql         # NULL handling with context
├── interview-prep/                   # Challenge-focused for practice
│   ├── 01_basic_select_challenges.sql    # Problems only
│   ├── 01_basic_select_solutions.sql     # Reference solutions
│   ├── 02_joins_challenges.sql
│   ├── 02_joins_solutions.sql
│   ├── 03_group_by_challenges.sql
│   ├── 03_group_by_solutions.sql
│   ├── 04_subqueries_challenges.sql
│   ├── 04_subqueries_solutions.sql
│   ├── 05_null_handling_challenges.sql
│   └── 05_null_handling_solutions.sql
└── README.md                         # This file
```

## Topics Covered

### 1. Basic SELECT Operations (`01_basic_select.sql`)
- **Scenario:** Employee management system
- **Key Topics:**
  - SELECT with specific columns
  - WHERE clause filtering (ranges, conditions, logical operators)
  - ORDER BY sorting (single and multiple columns)
  - LIMIT for result pagination
  - Pattern matching with LIKE
  - Boolean filtering

### 2. JOIN Operations (`02_joins.sql`)
- **Scenario:** Company database with departments, employees, and projects
- **Key Topics:**
  - INNER JOIN for matching records
  - LEFT/RIGHT JOIN for preserving records
  - Multiple table JOINs
  - Self-JOINs for hierarchical data
  - JOINs with WHERE clauses and aggregations
  - Finding missing relationships

### 3. GROUP BY and Aggregates (`03_group_by_aggregates.sql`)
- **Scenario:** E-commerce sales database
- **Key Topics:**
  - GROUP BY with COUNT, SUM, AVG, MIN, MAX
  - HAVING clause for filtering groups
  - GROUP BY with JOINs
  - Date-based grouping
  - Percentage calculations
  - Complex business metrics

### 4. Subqueries (`04_subqueries.sql`)
- **Scenario:** University student enrollment system
- **Key Topics:**
  - Subqueries in WHERE clause
  - Correlated subqueries
  - EXISTS and NOT EXISTS
  - Subqueries in SELECT clause
  - Derived tables (subqueries in FROM)
  - ALL, ANY, SOME operators
  - Complex nested queries

### 5. NULL Handling (`05_null_handling.sql`)
- **Scenario:** Customer service and support system
- **Key Topics:**
  - IS NULL and IS NOT NULL filtering
  - COALESCE for default values
  - NULLIF function
  - NULL behavior in aggregations
  - NULL-safe comparisons
  - Complex NULL logic with CASE statements

### 6. Window Functions (`06_window_functions.sql`) **ADVANCED**
- **Scenario:** Sales performance analytics and business intelligence
- **Key Topics:**
  - ROW_NUMBER, RANK, DENSE_RANK for ranking
  - NTILE for quantile analysis and customer segmentation
  - LAG, LEAD for period-over-period comparisons
  - FIRST_VALUE, LAST_VALUE for boundary analysis
  - Windowed aggregations (SUM, AVG, COUNT OVER)
  - PARTITION BY for grouped analysis
  - Moving averages and rolling calculations
  - Complex business intelligence queries

### 7. Common Table Expressions (CTEs) (`07_ctes.sql`) **ADVANCED**
- **Scenario:** Multi-level business reporting and hierarchical data analysis
- **Key Topics:**
  - Basic CTEs for query organization
  - Multiple CTEs for complex data pipelines
  - Recursive CTEs for hierarchical data
  - CTEs with window functions
  - Date series generation
  - Organizational chart traversal
  - Academic progression tracking
  - Complex business logic decomposition

## Learning Workflow

This repository offers two distinct learning paths:

### Learning Path: `/learning` folder
**Best for:** Understanding concepts, pattern recognition, and building fundamentals

1. **Study complete examples:** Each file contains schema + data + worked solutions with explanations
2. **Learn by example:** See how professionals structure queries for different business problems
3. **Understand patterns:** Analyze query structure and business logic
4. **Experiment freely:** Modify existing queries to explore variations

### Interview Prep Path: `/interview-prep` folder  
**Best for:** Testing skills, interview simulation, and independent problem-solving

1. **Pure challenge mode:** Challenge files contain only schema, data, and problem statements
2. **No hints or solutions visible:** Clean environment for independent thinking
3. **Realistic interview experience:** Solve problems under time pressure
4. **Reference solutions available:** Compare your approach after attempting the problems

### Recommended Learning Progression:

**Beginner (2-3 weeks):**
1. Week 1: Study `learning/01_basic_select.sql` and `learning/02_joins.sql`
2. Week 2: Work through `learning/03_group_by_aggregates.sql`  
3. Week 3: Tackle `learning/04_subqueries.sql` and `learning/05_null_handling.sql`

**Intermediate to Advanced (2-4 weeks):**
1. **Foundation Check:** Complete all beginner modules first
2. Week 1-2: Master `learning/06_window_functions.sql` - Critical for modern SQL roles
3. Week 3-4: Conquer `learning/07_ctes.sql` - Essential for complex query organization
4. **Interview Ready:** Practice with `interview-prep/` challenges 06-07

**Advanced Interview Preparation:**
1. **Test your knowledge:** Jump straight to `interview-prep/` challenges
2. **Build confidence:** Start with basic challenges (01-05), progress to advanced (06-07)
3. **Interview simulation:** Time yourself on complete challenge files
4. **Solution comparison:** Only check solutions after your attempts

## Running the SQL Files

### Option 1: Using VS Code or Similar IDE (Recommended)
1. Open VS Code (or your preferred IDE)
2. Install a SQL extension:
   - **SQLite**: "SQLite" extension by alexcvzz
   - **MySQL**: "MySQL" extension by cweijan  
   - **PostgreSQL**: "PostgreSQL" extension by ckolkman
3. Open any `.sql` file
4. Select your database connection/engine
5. Execute queries by selecting text and running SQL commands
6. Use the integrated terminal for command-line database tools

### Option 2: Database-Specific Tools

#### SQLite (Lightweight, no installation required)
```bash
# Install SQLite (if not already available)
# macOS: brew install sqlite
# Windows: Download from sqlite.org
# Linux: apt-get install sqlite3

# Run queries
sqlite3 practice.db < 01_basic_select.sql
```

#### MySQL
```bash
# Connect to MySQL
mysql -u username -p

# Run in MySQL prompt
source /path/to/01_basic_select.sql;
```

#### PostgreSQL
```bash
# Connect to PostgreSQL
psql -U username -d database_name

# Run in psql prompt
\i /path/to/01_basic_select.sql
```

### Option 3: Online SQL Environments
- **DB Fiddle** (db-fiddle.com)
- **SQLite Online** (sqliteonline.com)
- **W3Schools SQL Tryit** (w3schools.com/sql/trysql.asp)

## Practical Execution Guide

### Quick Start with SQLite (Recommended - 2 Minutes Setup)

**Step 1: Set up your database with ALL practice data**
```bash
# One command sets up everything
sqlite3 practice.db < setup_database.sql
```

**Step 2: Verify setup**
```bash
sqlite3 practice.db
```

In the SQLite shell, you should see a summary of all tables:
```sql
sqlite> .tables
-- You should see: agents, course_assignments, courses, customers, departments, 
-- employees, enrollments, order_items, orders, products, professors, 
-- projects, students, support_tickets

-- Test with a sample query
sqlite> SELECT * FROM employees LIMIT 3;
```

**Step 3: Start practicing!**
Now you can practice with any challenge file without setup hassles:
```sql
-- Basic queries
SELECT * FROM employees WHERE salary > 70000;

-- JOINs
SELECT d.department_name, COUNT(e.employee_id) as employee_count 
FROM departments d 
LEFT JOIN employees e ON e.department = d.department_name 
GROUP BY d.department_name;

-- Or open any challenge file and start solving!
```

### Alternative: Manual Setup (Advanced users)
If you prefer to set up tables individually:

```bash
# Create a new database manually
sqlite3 practice.db
```

In the SQLite shell:
```sql
-- Copy and paste the CREATE TABLE statements from any .sql file
-- Then copy and paste the INSERT statements
-- Finally, try the practice queries one by one

-- Example from learning/01_basic_select.sql:
.read learning/01_basic_select.sql  -- (if you save it as a file)
-- OR paste sections manually for better control
```

### Step-by-Step Learning Process
1. **Start with schema setup**: Copy CREATE TABLE statements into your database
2. **Load sample data**: Copy INSERT statements to populate tables  
3. **Practice queries incrementally**: 
   - Read each query comment/objective
   - Write your solution before looking at the provided one
   - Execute both and compare results
   - Modify and experiment with variations

### File Organization for Learning
Consider creating separate files for practice:
```
your-practice/
├── 01_schema.sql          # Just CREATE and INSERT statements
├── 01_practice.sql        # Your attempts at the queries
├── 01_solutions.sql       # Copy of provided solutions for reference
└── 01_experiments.sql     # Your variations and experiments
```

## Study Recommendations

### Beginner Path (2-3 weeks):
1. **Week 1:** Master `01_basic_select.sql` and `02_joins.sql`
2. **Week 2:** Focus on `03_group_by_aggregates.sql`
3. **Week 3:** Tackle `04_subqueries.sql` and `05_null_handling.sql`

### Interview Prep Path (1 week intensive):
1. **Day 1-2:** Quick review of all basic concepts (Files 01-02)
2. **Day 3-4:** Advanced querying (Files 03-04)
3. **Day 5-6:** Edge cases and NULL handling (File 05)
4. **Day 7:** Mock interview practice with random queries

### Key Success Metrics:
- Can write queries without syntax errors
- Understand execution order and performance implications
- Can explain query logic clearly
- Comfortable with complex multi-table scenarios
- Handle edge cases (NULLs, empty results, etc.)

## Interview Tips

**Common SQL Interview Patterns:**
1. **Data retrieval:** Basic SELECT with filtering
2. **Relationship analysis:** JOINs between related tables
3. **Aggregation problems:** GROUP BY with business metrics
4. **Complex filtering:** Subqueries for advanced conditions
5. **Data quality:** NULL handling and edge cases

**What Interviewers Look For:**
- Correct syntax and query structure
- Efficient query design
- Handling of edge cases
- Clear explanation of approach
- Understanding of performance implications

## Learning Enhancements

Take your SQL learning to the next level with these interactive tools and guides:

### [`enhancements/`](enhancements/) - Learning Support Tools

#### **Self-Assessment Quiz** ([`self_assessment_quiz.md`](enhancements/self_assessment_quiz.md))
- Interactive multiple-choice questions for all 7 modules
- Detailed explanations for each answer
- Progressive difficulty levels (beginner → advanced)
- Score tracking and performance guidance
- Perfect for testing your understanding before moving forward

#### **Query Explanations Guide** ([`query_explanations.md`](enhancements/query_explanations.md))
- Step-by-step breakdowns of complex SQL queries
- Deep dives into window functions, CTEs, and advanced patterns
- "Why" behind each query decision
- Pattern recognition for different use cases
- Perfect for understanding the logic behind advanced SQL

#### **Common Mistakes Guide** ([`common_mistakes.md`](enhancements/common_mistakes.md))
- Learn from typical SQL errors and pitfalls
- Wrong vs. right approaches with explanations
- Organized by topic and difficulty level
- Quick reference checklist for error prevention
- Perfect for avoiding common interview mistakes

#### **Progress Tracker** ([`progress_tracker.md`](enhancements/progress_tracker.md))
- Gamified learning system with achievements and milestones
- Skill checkpoints for each module
- Interview readiness assessment
- Personal goal setting and progress visualization
- Perfect for staying motivated and tracking your growth

### How to Use the Enhancements
1. **Start with the Progress Tracker** to set your learning goals
2. **Use Self-Assessment Quizzes** to test your knowledge after each module
3. **Reference Common Mistakes** when debugging queries or before interviews
4. **Deep dive with Query Explanations** for complex concepts you want to master

---

## Additional Resources

### SQL Learning Platforms:
- **HackerRank SQL** - Additional practice problems
- **LeetCode Database** - Interview-focused SQL challenges
- **SQLBolt** - Interactive SQL tutorial
- **Mode Analytics SQL Tutorial** - Real-world scenarios

### Advanced Topics (Next Steps):
- Window functions and analytics
- Query optimization and indexing
- Stored procedures and functions
- Database design and normalization
- NoSQL and modern data warehousing

---

## Contributing

Found an error or have suggestions for improvement? Feel free to:
- Open an issue for bugs or unclear explanations
- Suggest additional practice scenarios
- Propose new query patterns commonly seen in interviews

## License

This repository is open source and available under the MIT License. Use it freely for your learning and interview preparation!

---

**Happy querying!** Remember: The key to SQL mastery is consistent practice with real-world scenarios. Good luck with your interviews! 
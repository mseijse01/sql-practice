-- ========================================
-- SQL Practice 7: CTEs Challenges
-- ========================================
-- Objective: Master CTEs for complex queries, recursive operations, and code organization
-- Topics: Basic CTEs, Multiple CTEs, Recursive CTEs, CTEs with window functions, hierarchical data
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED:
--   students (student_id, first_name, last_name, email, major, enrollment_year, gpa)
--   courses (course_id, course_code, course_name, department, credits, max_enrollment)
--   enrollments (enrollment_id, student_id, course_id, semester, grade, enrollment_date)
--   professors (professor_id, first_name, last_name, department, salary, hire_date)
--   employees (employee_id, first_name, last_name, salary, department_id, manager_id)
--   departments (department_id, department_name, manager_name, budget)

-- ========================================
-- CHALLENGES
-- ========================================

-- Query 1: Basic CTE
-- Find students with above-average GPA and show their course count


-- Query 2: Multiple CTEs
-- Student performance analysis with multiple metrics - compare each student to their major averages and categorize performance


-- Query 3: CTE with window functions
-- Department budget analysis with rankings, comparisons, and budget utilization status


-- Query 4: Recursive CTE - Employee hierarchy
-- Build organizational chart showing management levels and hierarchy paths


-- Query 5: Recursive CTE - Course prerequisites
-- Create a course prerequisite system and trace learning paths (use the simulated prerequisite data provided)


-- Query 6: CTE for data transformation
-- Transform grade data, calculate GPA, and show academic status with major rankings


-- Query 7: Complex business logic with CTEs
-- Course capacity analysis - analyze enrollment vs capacity with department summaries


-- Query 8: Recursive CTE - Date series generation
-- Generate a date series and show daily enrollment statistics with cumulative totals


-- Query 9: CTE with complex joins
-- Professor workload analysis - analyze teaching loads, student counts, and cost per student


-- Query 10: Advanced recursive CTE
-- Academic progression tracking - track student progression through academic levels and assess progress status 
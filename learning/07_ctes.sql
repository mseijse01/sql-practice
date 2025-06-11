-- ========================================
-- SQL Practice 7: Common Table Expressions (CTEs)
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
-- PRACTICE QUERIES
-- ========================================

-- Query 1: Basic CTE - Simplifying complex subqueries
-- Find students with above-average GPA and their course count
WITH above_avg_students AS (
    SELECT student_id, first_name, last_name, major, gpa
    FROM students 
    WHERE gpa > (SELECT AVG(gpa) FROM students)
)
SELECT aas.first_name, aas.last_name, aas.major, aas.gpa,
       COUNT(e.enrollment_id) as course_count
FROM above_avg_students aas
LEFT JOIN enrollments e ON aas.student_id = e.student_id
GROUP BY aas.student_id, aas.first_name, aas.last_name, aas.major, aas.gpa
ORDER BY aas.gpa DESC;

-- Query 2: Multiple CTEs - Breaking down complex analysis
-- Student performance analysis with multiple metrics
WITH student_stats AS (
    SELECT s.student_id, s.first_name, s.last_name, s.major, s.gpa,
           COUNT(e.enrollment_id) as total_courses
    FROM students s
    LEFT JOIN enrollments e ON s.student_id = e.student_id
    GROUP BY s.student_id, s.first_name, s.last_name, s.major, s.gpa
),
major_averages AS (
    SELECT major, 
           AVG(gpa) as avg_major_gpa,
           AVG(total_courses) as avg_major_courses
    FROM student_stats
    GROUP BY major
),
performance_categories AS (
    SELECT ss.*, ma.avg_major_gpa, ma.avg_major_courses,
           CASE 
               WHEN ss.gpa > ma.avg_major_gpa AND ss.total_courses > ma.avg_major_courses THEN 'High Performer'
               WHEN ss.gpa > ma.avg_major_gpa THEN 'High GPA'
               WHEN ss.total_courses > ma.avg_major_courses THEN 'Course Active'
               ELSE 'Standard'
           END as performance_category
    FROM student_stats ss
    INNER JOIN major_averages ma ON ss.major = ma.major
)
SELECT first_name, last_name, major, gpa, total_courses, 
       ROUND(avg_major_gpa, 2) as major_avg_gpa,
       ROUND(avg_major_courses, 1) as major_avg_courses,
       performance_category
FROM performance_categories
ORDER BY major, gpa DESC;

-- Query 3: CTE with window functions - Advanced analytics
-- Department budget analysis with rankings and comparisons
WITH dept_metrics AS (
    SELECT d.department_id, d.department_name, d.budget,
           COUNT(e.employee_id) as employee_count,
           AVG(e.salary) as avg_salary,
           SUM(e.salary) as total_payroll
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id AND e.is_active = 1
    GROUP BY d.department_id, d.department_name, d.budget
),
dept_analysis AS (
    SELECT *,
           budget - total_payroll as budget_remaining,
           ROUND(total_payroll * 100.0 / budget, 2) as budget_utilization_pct,
           RANK() OVER (ORDER BY budget DESC) as budget_rank,
           RANK() OVER (ORDER BY employee_count DESC) as size_rank,
           RANK() OVER (ORDER BY avg_salary DESC) as avg_salary_rank
    FROM dept_metrics
)
SELECT department_name, budget, employee_count, 
       ROUND(avg_salary, 2) as avg_salary,
       ROUND(total_payroll, 2) as total_payroll,
       ROUND(budget_remaining, 2) as budget_remaining,
       budget_utilization_pct,
       budget_rank, size_rank, avg_salary_rank,
       CASE 
           WHEN budget_utilization_pct > 90 THEN 'Over Budget Risk'
           WHEN budget_utilization_pct > 75 THEN 'High Utilization'
           WHEN budget_utilization_pct > 50 THEN 'Moderate Utilization'
           ELSE 'Low Utilization'
       END as budget_status
FROM dept_analysis
ORDER BY budget_utilization_pct DESC;

-- Query 4: Recursive CTE - Employee hierarchy
-- Build organizational chart showing management levels
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: Top-level managers (no manager_id)
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
       full_name,
       hierarchy_path,
       CASE level
           WHEN 0 THEN 'CEO/President'
           WHEN 1 THEN 'Senior Management'
           WHEN 2 THEN 'Middle Management'
           ELSE 'Staff Level'
       END as org_level
FROM employee_hierarchy
ORDER BY hierarchy_path;

-- Query 5: Recursive CTE - Course prerequisites (simulated)
-- Create a mock prerequisite system and trace learning paths
WITH course_prerequisites AS (
    -- Simulate prerequisite relationships
    SELECT 'CS101' as course_code, NULL as prerequisite_code
    UNION ALL SELECT 'CS102', 'CS101'
    UNION ALL SELECT 'CS201', 'CS102'
    UNION ALL SELECT 'CS301', 'CS201'
    UNION ALL SELECT 'MATH101', NULL
    UNION ALL SELECT 'MATH201', 'MATH101'
    UNION ALL SELECT 'PHYS101', 'MATH101'
),
RECURSIVE learning_path AS (
    -- Base case: Courses with no prerequisites
    SELECT course_code, prerequisite_code, 
           1 as sequence_level,
           course_code as path
    FROM course_prerequisites
    WHERE prerequisite_code IS NULL
    
    UNION ALL
    
    -- Recursive case: Courses with prerequisites
    SELECT cp.course_code, cp.prerequisite_code,
           lp.sequence_level + 1,
           lp.path || ' -> ' || cp.course_code
    FROM course_prerequisites cp
    INNER JOIN learning_path lp ON cp.prerequisite_code = lp.course_code
)
SELECT course_code, sequence_level, path as learning_sequence
FROM learning_path
ORDER BY sequence_level, course_code;

-- Query 6: CTE for data transformation - Grade analysis
-- Transform grade data and calculate comprehensive statistics
WITH grade_points AS (
    SELECT e.*, s.first_name, s.last_name, s.major, c.course_name, c.credits,
           CASE e.grade
               WHEN 'A' THEN 4.0
               WHEN 'B' THEN 3.0
               WHEN 'C' THEN 2.0
               WHEN 'D' THEN 1.0
               WHEN 'F' THEN 0.0
               ELSE NULL
           END as grade_points
    FROM enrollments e
    INNER JOIN students s ON e.student_id = s.student_id
    INNER JOIN courses c ON e.course_id = c.course_id
    WHERE e.grade IS NOT NULL
),
student_gpa_calc AS (
    SELECT student_id, first_name, last_name, major,
           COUNT(*) as courses_completed,
           SUM(grade_points * credits) as total_quality_points,
           SUM(credits) as total_credits,
           ROUND(SUM(grade_points * credits) / SUM(credits), 2) as calculated_gpa
    FROM grade_points
    GROUP BY student_id, first_name, last_name, major
)
SELECT first_name, last_name, major, courses_completed, total_credits,
       calculated_gpa,
       CASE 
           WHEN calculated_gpa >= 3.5 THEN 'Dean\'s List'
           WHEN calculated_gpa >= 3.0 THEN 'Good Standing'
           WHEN calculated_gpa >= 2.0 THEN 'Satisfactory'
           ELSE 'Academic Probation'
       END as academic_status,
       RANK() OVER (PARTITION BY major ORDER BY calculated_gpa DESC) as major_rank
FROM student_gpa_calc
ORDER BY major, calculated_gpa DESC;

-- Query 7: Complex business logic with CTEs - Course capacity analysis
-- Analyze course enrollment vs capacity with waiting lists
WITH course_enrollment_stats AS (
    SELECT c.course_id, c.course_code, c.course_name, c.department, 
           c.max_enrollment, c.credits,
           COUNT(e.enrollment_id) as current_enrollment,
           c.max_enrollment - COUNT(e.enrollment_id) as available_spots
    FROM courses c
    LEFT JOIN enrollments e ON c.course_id = e.course_id
    GROUP BY c.course_id, c.course_code, c.course_name, c.department, c.max_enrollment, c.credits
),
enrollment_categories AS (
    SELECT *,
           ROUND(current_enrollment * 100.0 / max_enrollment, 1) as fill_rate_pct,
           CASE 
               WHEN current_enrollment >= max_enrollment THEN 'Full'
               WHEN current_enrollment >= max_enrollment * 0.9 THEN 'Nearly Full'
               WHEN current_enrollment >= max_enrollment * 0.5 THEN 'Moderate'
               WHEN current_enrollment > 0 THEN 'Low Enrollment'
               ELSE 'No Enrollment'
           END as enrollment_status
    FROM course_enrollment_stats
),
department_summary AS (
    SELECT department,
           COUNT(*) as total_courses,
           SUM(current_enrollment) as total_students,
           AVG(fill_rate_pct) as avg_fill_rate,
           SUM(CASE WHEN enrollment_status = 'Full' THEN 1 ELSE 0 END) as full_courses
    FROM enrollment_categories
    GROUP BY department
)
SELECT ec.course_code, ec.course_name, ec.department,
       ec.current_enrollment, ec.max_enrollment, ec.available_spots,
       ec.fill_rate_pct, ec.enrollment_status,
       ds.avg_fill_rate as dept_avg_fill_rate,
       ds.full_courses as dept_full_courses,
       ds.total_courses as dept_total_courses
FROM enrollment_categories ec
INNER JOIN department_summary ds ON ec.department = ds.department
ORDER BY ec.department, ec.fill_rate_pct DESC;

-- Query 8: Recursive CTE - Number series generation
-- Generate a series for date-based analysis
WITH RECURSIVE date_series AS (
    SELECT DATE('2023-01-01') as date_value
    UNION ALL
    SELECT DATE(date_value, '+1 day')
    FROM date_series
    WHERE date_value < DATE('2023-12-31')
),
daily_enrollment_stats AS (
    SELECT ds.date_value,
           COUNT(e.enrollment_id) as enrollments_on_date
    FROM date_series ds
    LEFT JOIN enrollments e ON DATE(e.enrollment_date) = ds.date_value
    GROUP BY ds.date_value
)
SELECT date_value, enrollments_on_date,
       SUM(enrollments_on_date) OVER (ORDER BY date_value ROWS UNBOUNDED PRECEDING) as cumulative_enrollments
FROM daily_enrollment_stats
WHERE enrollments_on_date > 0  -- Only show days with actual enrollments
ORDER BY date_value
LIMIT 20;  -- Limit for readability

-- Query 9: CTE with complex joins - Professor workload analysis
-- Analyze professor teaching loads and course distributions
WITH professor_courses AS (
    SELECT p.professor_id, p.first_name, p.last_name, p.department, p.salary,
           ca.course_id, ca.semester, c.course_name, c.credits,
           COUNT(e.enrollment_id) as students_enrolled
    FROM professors p
    INNER JOIN course_assignments ca ON p.professor_id = ca.professor_id
    INNER JOIN courses c ON ca.course_id = c.course_id
    LEFT JOIN enrollments e ON c.course_id = e.course_id AND e.semester = ca.semester
    GROUP BY p.professor_id, p.first_name, p.last_name, p.department, p.salary,
             ca.course_id, ca.semester, c.course_name, c.credits
),
professor_workload AS (
    SELECT professor_id, first_name, last_name, department, salary,
           COUNT(DISTINCT course_id) as courses_taught,
           SUM(credits) as total_credits,
           SUM(students_enrolled) as total_students,
           ROUND(AVG(students_enrolled), 1) as avg_class_size
    FROM professor_courses
    GROUP BY professor_id, first_name, last_name, department, salary
),
workload_analysis AS (
    SELECT *,
           CASE 
               WHEN total_credits >= 12 THEN 'Full Load'
               WHEN total_credits >= 9 THEN 'Standard Load'
               WHEN total_credits >= 6 THEN 'Reduced Load'
               ELSE 'Minimal Load'
           END as workload_category,
           RANK() OVER (PARTITION BY department ORDER BY total_students DESC) as dept_student_rank,
           ROUND(salary / NULLIF(total_students, 0), 2) as cost_per_student
    FROM professor_workload
)
SELECT first_name, last_name, department, courses_taught, total_credits, 
       total_students, avg_class_size, workload_category,
       dept_student_rank, cost_per_student,
       ROUND(salary, 2) as salary
FROM workload_analysis
ORDER BY department, total_students DESC;

-- Query 10: Advanced recursive CTE - Academic progression tracking
-- Track student progression through different academic levels
WITH RECURSIVE academic_progression AS (
    -- Base: First-year students
    SELECT student_id, first_name, last_name, enrollment_year,
           1 as academic_level,
           'Freshman' as level_name,
           enrollment_year as year_in_level
    FROM students
    WHERE enrollment_year = (SELECT MIN(enrollment_year) FROM students)
    
    UNION ALL
    
    -- Recursive: Advance students through levels
    SELECT ap.student_id, ap.first_name, ap.last_name, ap.enrollment_year,
           ap.academic_level + 1,
           CASE ap.academic_level + 1
               WHEN 2 THEN 'Sophomore'
               WHEN 3 THEN 'Junior'
               WHEN 4 THEN 'Senior'
               ELSE 'Graduate'
           END,
           ap.year_in_level + 1
    FROM academic_progression ap
    WHERE ap.academic_level < 4
      AND ap.year_in_level <= 2023
),
student_progression_summary AS (
    SELECT student_id, first_name, last_name, enrollment_year,
           MAX(academic_level) as current_level,
           CASE MAX(academic_level)
               WHEN 1 THEN 'Freshman'
               WHEN 2 THEN 'Sophomore' 
               WHEN 3 THEN 'Junior'
               WHEN 4 THEN 'Senior'
               ELSE 'Graduate'
           END as current_level_name,
           2023 - enrollment_year + 1 as years_enrolled
    FROM academic_progression
    GROUP BY student_id, first_name, last_name, enrollment_year
)
SELECT sps.first_name, sps.last_name, sps.current_level_name, sps.years_enrolled,
       s.major, s.gpa,
       COUNT(e.enrollment_id) as total_courses_taken,
       CASE 
           WHEN sps.years_enrolled <= sps.current_level THEN 'On Track'
           WHEN sps.years_enrolled = sps.current_level + 1 THEN 'Slightly Behind'
           ELSE 'Significantly Behind'
       END as progress_status
FROM student_progression_summary sps
INNER JOIN students s ON sps.student_id = s.student_id
LEFT JOIN enrollments e ON sps.student_id = e.student_id
GROUP BY sps.student_id, sps.first_name, sps.last_name, sps.current_level_name, 
         sps.years_enrolled, s.major, s.gpa
ORDER BY sps.current_level_name, s.gpa DESC; 
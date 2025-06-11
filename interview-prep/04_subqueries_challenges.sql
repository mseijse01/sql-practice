-- ========================================
-- SQL Practice 4: Subqueries Challenges
-- ========================================
-- Objective: Master subqueries in SELECT, WHERE, FROM, and with EXISTS
-- Topics: Scalar subqueries, correlated subqueries, EXISTS, IN, subqueries in different clauses
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED:
--   students (student_id, first_name, last_name, email, major, enrollment_year, gpa)
--   courses (course_id, course_code, course_name, department, credits, max_enrollment)
--   enrollments (enrollment_id, student_id, course_id, semester, grade, enrollment_date)
--   professors (professor_id, first_name, last_name, department, salary, hire_date)
--   course_assignments (assignment_id, course_id, professor_id, semester)

-- ========================================
-- CHALLENGES
-- ========================================

-- Query 1: Simple subquery in WHERE clause
-- Find students with GPA higher than the overall average


-- Query 2: Subquery with IN operator
-- Find students enrolled in Computer Science courses


-- Query 3: Correlated subquery
-- Find students whose GPA is above average for their major


-- Query 4: EXISTS subquery
-- Find students who have enrolled in at least one course


-- Query 5: NOT EXISTS subquery
-- Find students who haven't enrolled in any courses


-- Query 6: Subquery in SELECT clause
-- Show each student with their enrollment count


-- Query 7: Multiple correlated subqueries
-- Show students with their course count and categorize their GPA as 'Above Average' or 'Below Average' compared to overall average


-- Query 8: Subquery with MAX/MIN
-- Find the course with the highest enrollment


-- Query 9: Subquery in FROM clause (derived table)
-- Show average GPA by major, but only for majors with average GPA > 3.5


-- Query 10: Complex nested subquery
-- Find Computer Science students who are taking more courses than the average Computer Science student


-- Query 11: Subquery with ALL operator
-- Find students with GPA higher than all Physics majors


-- Query 12: Subquery with ANY/SOME operator
-- Find courses that have higher enrollment than any Mathematics course


-- Query 13: Subquery for ranking
-- Find the top 3 students by GPA and show their rank


-- Query 14: Complex business logic with subqueries
-- Find professors teaching courses where the average student GPA is above 3.7 
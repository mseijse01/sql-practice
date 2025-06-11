-- ========================================
-- SQL Practice 4: Subqueries
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
-- PRACTICE QUERIES
-- ========================================

-- Query 1: Simple subquery in WHERE clause
-- Find students with GPA higher than the overall average
SELECT first_name, last_name, gpa 
FROM students 
WHERE gpa > (SELECT AVG(gpa) FROM students);

-- Query 2: Subquery with IN operator
-- Find students enrolled in Computer Science courses
SELECT first_name, last_name, major 
FROM students 
WHERE student_id IN (
    SELECT DISTINCT e.student_id 
    FROM enrollments e 
    INNER JOIN courses c ON e.course_id = c.course_id 
    WHERE c.department = 'Computer Science'
);

-- Query 3: Correlated subquery
-- Find students whose GPA is above average for their major
SELECT s.first_name, s.last_name, s.major, s.gpa 
FROM students s 
WHERE s.gpa > (
    SELECT AVG(s2.gpa) 
    FROM students s2 
    WHERE s2.major = s.major
);

-- Query 4: EXISTS subquery
-- Find students who have enrolled in at least one course
SELECT first_name, last_name 
FROM students s 
WHERE EXISTS (
    SELECT 1 
    FROM enrollments e 
    WHERE e.student_id = s.student_id
);

-- Query 5: NOT EXISTS subquery
-- Find students who haven't enrolled in any courses
SELECT first_name, last_name, major 
FROM students s 
WHERE NOT EXISTS (
    SELECT 1 
    FROM enrollments e 
    WHERE e.student_id = s.student_id
);

-- Query 6: Subquery in SELECT clause
-- Show each student with their enrollment count
SELECT first_name, last_name,
       (SELECT COUNT(*) 
        FROM enrollments e 
        WHERE e.student_id = s.student_id) as enrollment_count
FROM students s;

-- Query 7: Multiple correlated subqueries
-- Students with their course count and average grade comparison
SELECT s.first_name, s.last_name, s.gpa,
       (SELECT COUNT(*) 
        FROM enrollments e 
        WHERE e.student_id = s.student_id) as courses_taken,
       CASE 
           WHEN s.gpa > (SELECT AVG(gpa) FROM students) 
           THEN 'Above Average'
           ELSE 'Below Average'
       END as gpa_category
FROM students s;

-- Query 8: Subquery with MAX/MIN
-- Find the course with the highest enrollment
SELECT course_code, course_name 
FROM courses 
WHERE course_id = (
    SELECT course_id 
    FROM enrollments 
    GROUP BY course_id 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);

-- Query 9: Subquery in FROM clause (derived table)
-- Average GPA by major, showing only majors with GPA > 3.5
SELECT major, avg_gpa 
FROM (
    SELECT major, AVG(gpa) as avg_gpa 
    FROM students 
    GROUP BY major
) as major_stats 
WHERE avg_gpa > 3.5;

-- Query 10: Complex nested subquery
-- Find Computer Science students who are taking more courses than the average CS student
SELECT s.first_name, s.last_name,
       (SELECT COUNT(*) 
        FROM enrollments e 
        WHERE e.student_id = s.student_id) as course_count
FROM students s 
WHERE s.major = 'Computer Science'
  AND (SELECT COUNT(*) 
       FROM enrollments e 
       WHERE e.student_id = s.student_id) > (
           SELECT AVG(course_count) 
           FROM (
               SELECT COUNT(*) as course_count 
               FROM students s2 
               INNER JOIN enrollments e2 ON s2.student_id = e2.student_id 
               WHERE s2.major = 'Computer Science' 
               GROUP BY s2.student_id
           ) as cs_enrollments
       );

-- Query 11: Subquery with ALL operator
-- Find students with GPA higher than all Physics majors
SELECT first_name, last_name, major, gpa 
FROM students 
WHERE gpa > ALL (
    SELECT gpa 
    FROM students 
    WHERE major = 'Physics'
);

-- Query 12: Subquery with ANY/SOME operator
-- Find courses that have higher enrollment than any Mathematics course
SELECT c.course_code, c.course_name, c.department,
       (SELECT COUNT(*) 
        FROM enrollments e 
        WHERE e.course_id = c.course_id) as enrollment_count
FROM courses c 
WHERE (SELECT COUNT(*) 
       FROM enrollments e 
       WHERE e.course_id = c.course_id) > ANY (
           SELECT COUNT(*) 
           FROM enrollments e2 
           INNER JOIN courses c2 ON e2.course_id = c2.course_id 
           WHERE c2.department = 'Mathematics' 
           GROUP BY c2.course_id
       );

-- Query 13: Subquery for ranking
-- Find the top 3 students by GPA and show their rank
SELECT first_name, last_name, gpa,
       (SELECT COUNT(*) + 1 
        FROM students s2 
        WHERE s2.gpa > s.gpa) as gpa_rank
FROM students s 
ORDER BY gpa DESC 
LIMIT 3;

-- Query 14: Complex business logic with subqueries
-- Find professors teaching courses where the average student GPA is above 3.7
SELECT p.first_name, p.last_name, p.department 
FROM professors p 
WHERE p.professor_id IN (
    SELECT ca.professor_id 
    FROM course_assignments ca 
    WHERE ca.course_id IN (
        SELECT e.course_id 
        FROM enrollments e 
        INNER JOIN students s ON e.student_id = s.student_id 
        GROUP BY e.course_id 
        HAVING AVG(s.gpa) > 3.7
    )
); 
-- ========================================
-- SQL Practice 4: Subqueries Solutions
-- ========================================
-- Reference solutions for 04_subqueries_challenges.sql

-- Query 1: Simple subquery in WHERE clause
SELECT first_name, last_name, gpa 
FROM students 
WHERE gpa > (SELECT AVG(gpa) FROM students);

-- Query 2: Subquery with IN operator
SELECT first_name, last_name, major 
FROM students 
WHERE student_id IN (
    SELECT DISTINCT e.student_id 
    FROM enrollments e 
    INNER JOIN courses c ON e.course_id = c.course_id 
    WHERE c.department = 'Computer Science'
);

-- Query 3: Correlated subquery
SELECT s.first_name, s.last_name, s.major, s.gpa 
FROM students s 
WHERE s.gpa > (
    SELECT AVG(s2.gpa) 
    FROM students s2 
    WHERE s2.major = s.major
);

-- Query 4: EXISTS subquery
SELECT first_name, last_name 
FROM students s 
WHERE EXISTS (
    SELECT 1 
    FROM enrollments e 
    WHERE e.student_id = s.student_id
);

-- Query 5: NOT EXISTS subquery
SELECT first_name, last_name, major 
FROM students s 
WHERE NOT EXISTS (
    SELECT 1 
    FROM enrollments e 
    WHERE e.student_id = s.student_id
);

-- Query 6: Subquery in SELECT clause
SELECT first_name, last_name,
       (SELECT COUNT(*) 
        FROM enrollments e 
        WHERE e.student_id = s.student_id) as enrollment_count
FROM students s;

-- Query 7: Multiple correlated subqueries
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
SELECT major, avg_gpa 
FROM (
    SELECT major, AVG(gpa) as avg_gpa 
    FROM students 
    GROUP BY major
) as major_stats 
WHERE avg_gpa > 3.5;

-- Query 10: Complex nested subquery
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
SELECT first_name, last_name, major, gpa 
FROM students 
WHERE gpa > ALL (
    SELECT gpa 
    FROM students 
    WHERE major = 'Physics'
);

-- Query 12: Subquery with ANY/SOME operator
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
SELECT first_name, last_name, gpa,
       (SELECT COUNT(*) + 1 
        FROM students s2 
        WHERE s2.gpa > s.gpa) as gpa_rank
FROM students s 
ORDER BY gpa DESC 
LIMIT 3;

-- Query 14: Complex business logic with subqueries
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
-- ========================================
-- SQL Practice 5: NULL Handling Solutions
-- ========================================
-- Reference solutions for 05_null_handling_challenges.sql

-- Query 1: Basic NULL filtering
SELECT first_name, last_name, email 
FROM customers 
WHERE phone IS NULL;

-- Query 2: NOT NULL filtering
SELECT first_name, last_name, email, phone 
FROM customers 
WHERE phone IS NOT NULL AND email IS NOT NULL;

-- Query 3: Multiple NULL checks
SELECT customer_id, first_name, last_name, email, phone 
FROM customers 
WHERE email IS NULL OR phone IS NULL;

-- Query 4: COALESCE function
SELECT first_name, last_name,
       COALESCE(email, 'No email provided') as contact_email,
       COALESCE(phone, 'No phone provided') as contact_phone
FROM customers;

-- Query 5: COALESCE with multiple columns
SELECT first_name, last_name,
       COALESCE(address + ', ' + city + ', ' + state + ' ' + zip_code,
                city + ', ' + state,
                state,
                'Address incomplete') as full_address
FROM customers;

-- Query 6: NULL in aggregations
SELECT 
    COUNT(*) as total_customers,
    COUNT(last_login_date) as customers_with_login,
    COUNT(*) - COUNT(last_login_date) as customers_without_login
FROM customers;

-- Query 7: NULL-safe comparisons with COALESCE
SELECT first_name, last_name, 
       COALESCE(last_login_date, '1900-01-01') as last_login,
       CASE 
           WHEN last_login_date IS NULL THEN 'Never logged in'
           WHEN last_login_date < '2023-11-01' THEN 'Inactive'
           ELSE 'Recent activity'
       END as activity_status
FROM customers;

-- Query 8: NULL handling in JOINs
SELECT t.ticket_id, t.issue_category, t.status,
       COALESCE(a.first_name + ' ' + a.last_name, 'Unassigned') as agent_name
FROM support_tickets t 
LEFT JOIN agents a ON t.assigned_agent_id = a.agent_id;

-- Query 9: NULLIF function
SELECT agent_id,
       NULLIF(email, '') as clean_email, -- Convert empty string to NULL
       COALESCE(supervisor_id, 0) as supervisor_with_default
FROM agents;

-- Query 10: Complex NULL handling in aggregations
SELECT 
    COUNT(*) as total_tickets,
    COUNT(assigned_agent_id) as assigned_tickets,
    COUNT(resolved_date) as resolved_tickets,
    COUNT(customer_satisfaction_rating) as rated_tickets,
    AVG(customer_satisfaction_rating) as avg_rating,
    AVG(COALESCE(customer_satisfaction_rating, 3)) as avg_rating_with_default
FROM support_tickets;

-- Query 11: NULL in WHERE with AND/OR logic
SELECT customer_id, first_name, last_name,
       CASE 
           WHEN email IS NULL AND phone IS NULL THEN 'No contact info'
           WHEN email IS NULL THEN 'Missing email'
           WHEN phone IS NULL THEN 'Missing phone'
           ELSE 'Complete contact'
       END as contact_status
FROM customers 
WHERE (email IS NULL OR phone IS NULL) 
  AND (last_login_date IS NULL OR last_login_date < '2023-10-01');

-- Query 12: NULL handling in subqueries
SELECT c.first_name, c.last_name, c.email,
       COUNT(t.ticket_id) as open_tickets
FROM customers c 
INNER JOIN support_tickets t ON c.customer_id = t.customer_id 
WHERE t.resolved_date IS NULL 
GROUP BY c.customer_id, c.first_name, c.last_name, c.email 
ORDER BY open_tickets DESC;

-- Query 13: Advanced NULL handling with CASE
SELECT customer_id, first_name, last_name,
       (CASE WHEN email IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN phone IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN address IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN city IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN state IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN zip_code IS NOT NULL THEN 1 ELSE 0 END) as completeness_score,
       CASE 
           WHEN (CASE WHEN email IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN phone IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN address IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN city IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN state IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN zip_code IS NOT NULL THEN 1 ELSE 0 END) >= 5 THEN 'Complete'
           WHEN (CASE WHEN email IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN phone IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN address IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN city IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN state IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN zip_code IS NOT NULL THEN 1 ELSE 0 END) >= 3 THEN 'Partial'
           ELSE 'Incomplete'
       END as profile_status
FROM customers 
ORDER BY completeness_score DESC; 
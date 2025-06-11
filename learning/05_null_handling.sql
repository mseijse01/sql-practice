-- ========================================
-- SQL Practice 5: NULL Handling
-- ========================================
-- Objective: Master NULL value handling, COALESCE, NULLIF, and NULL-safe operations
-- Topics: IS NULL, IS NOT NULL, COALESCE, NULLIF, ISNULL, NULL-safe comparisons
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED:
--   agents (agent_id, first_name, last_name, email, department, hire_date, supervisor_id)
--   support_tickets (ticket_id, customer_id, issue_category, priority, status, created_date, assigned_agent_id, resolved_date, customer_satisfaction_rating)

-- ========================================
-- PRACTICE QUERIES
-- ========================================

-- Query 1: Basic NULL filtering
-- Find customers without phone numbers
SELECT first_name, last_name, email 
FROM customers 
WHERE phone IS NULL;

-- Query 2: NOT NULL filtering
-- Find customers with complete contact information
SELECT first_name, last_name, email, phone 
FROM customers 
WHERE phone IS NOT NULL AND email IS NOT NULL;

-- Query 3: Multiple NULL checks
-- Find customers missing critical information (email OR phone)
SELECT customer_id, first_name, last_name, email, phone 
FROM customers 
WHERE email IS NULL OR phone IS NULL;

-- Query 4: COALESCE function
-- Display customer contact with fallback values
SELECT first_name, last_name,
       COALESCE(email, 'No email provided') as contact_email,
       COALESCE(phone, 'No phone provided') as contact_phone
FROM customers;

-- Query 5: COALESCE with multiple columns
-- Create a complete address using available fields
SELECT first_name, last_name,
       COALESCE(address + ', ' + city + ', ' + state + ' ' + zip_code,
                city + ', ' + state,
                state,
                'Address incomplete') as full_address
FROM customers;

-- Query 6: NULL in aggregations
-- Count customers with and without last login (NULLs are ignored in COUNT)
SELECT 
    COUNT(*) as total_customers,
    COUNT(last_login_date) as customers_with_login,
    COUNT(*) - COUNT(last_login_date) as customers_without_login
FROM customers;

-- Query 7: NULL-safe comparisons with ISNULL/COALESCE
-- Find customers who haven't logged in recently (or ever)
SELECT first_name, last_name, 
       COALESCE(last_login_date, '1900-01-01') as last_login,
       CASE 
           WHEN last_login_date IS NULL THEN 'Never logged in'
           WHEN last_login_date < '2023-11-01' THEN 'Inactive'
           ELSE 'Recent activity'
       END as activity_status
FROM customers;

-- Query 8: NULL handling in JOINs
-- Show all tickets with agent information (handle unassigned tickets)
SELECT t.ticket_id, t.issue_category, t.status,
       COALESCE(a.first_name + ' ' + a.last_name, 'Unassigned') as agent_name
FROM support_tickets t 
LEFT JOIN agents a ON t.assigned_agent_id = a.agent_id;

-- Query 9: NULLIF function
-- Convert empty strings to NULL and handle division by zero
SELECT agent_id,
       NULLIF(email, '') as clean_email, -- Convert empty string to NULL
       COALESCE(supervisor_id, 0) as supervisor_with_default
FROM agents;

-- Query 10: Complex NULL handling in aggregations
-- Ticket statistics with NULL handling
SELECT 
    COUNT(*) as total_tickets,
    COUNT(assigned_agent_id) as assigned_tickets,
    COUNT(resolved_date) as resolved_tickets,
    COUNT(customer_satisfaction_rating) as rated_tickets,
    AVG(customer_satisfaction_rating) as avg_rating,
    AVG(COALESCE(customer_satisfaction_rating, 3)) as avg_rating_with_default
FROM support_tickets;

-- Query 11: NULL in WHERE with AND/OR logic
-- Find problematic customers (missing contact info AND no recent login)
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
-- Customers with unresolved tickets (including unassigned ones)
SELECT c.first_name, c.last_name, c.email,
       COUNT(t.ticket_id) as open_tickets
FROM customers c 
INNER JOIN support_tickets t ON c.customer_id = t.customer_id 
WHERE t.resolved_date IS NULL 
GROUP BY c.customer_id, c.first_name, c.last_name, c.email 
ORDER BY open_tickets DESC;

-- Query 13: Advanced NULL handling with CASE
-- Customer profile completeness score
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
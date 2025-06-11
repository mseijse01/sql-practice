-- ========================================
-- SQL Practice 5: NULL Handling Challenges
-- ========================================
-- Objective: Master NULL value handling, COALESCE, NULLIF, and NULL-safe operations
-- Topics: IS NULL, IS NOT NULL, COALESCE, NULLIF, ISNULL, NULL-safe comparisons
-- 
-- PREREQUISITES: Run setup_database.sql first to create all tables and data
-- TABLES USED:
--   agents (agent_id, first_name, last_name, email, department, hire_date, supervisor_id)
--   support_tickets (ticket_id, customer_id, issue_category, priority, status, created_date, assigned_agent_id, resolved_date, customer_satisfaction_rating)

-- ========================================
-- CHALLENGES
-- ========================================

-- Query 1: Basic NULL filtering
-- Find agents without email addresses


-- Query 2: NOT NULL filtering
-- Find support tickets with assigned agents


-- Query 3: Multiple NULL checks
-- Find tickets missing critical information (either no assigned agent OR no resolution date for resolved tickets)


-- Query 4: COALESCE function
-- Display agent contact with fallback values: show 'No email provided' for NULL emails


-- Query 5: COALESCE with multiple columns
-- Create a complete agent hierarchy showing agent name and their supervisor name, with fallbacks for missing supervisors


-- Query 6: NULL in aggregations
-- Count total tickets, tickets with ratings, and tickets without ratings


-- Query 7: NULL-safe comparisons with COALESCE
-- Find tickets that haven't been rated, categorizing them by resolution status


-- Query 8: NULL handling in JOINs
-- Show all tickets with agent information, displaying 'Unassigned' for tickets without agents


-- Query 9: NULLIF function
-- Clean up agent data: convert empty emails to NULL and show agent activity status


-- Query 10: Complex NULL handling in aggregations
-- Show ticket statistics by priority including counts and averages, handling NULL ratings appropriately


-- Query 11: NULL in WHERE with AND/OR logic
-- Find problematic tickets (unassigned AND high priority) OR (resolved but no rating)


-- Query 12: NULL handling in subqueries
-- Find agents who have unresolved assigned tickets (including tickets with no resolution date)


-- Query 13: Advanced NULL handling with CASE
-- Calculate ticket completeness score (0-5) based on how many key fields are not NULL (assigned_agent_id, resolved_date, customer_satisfaction_rating, etc.) 
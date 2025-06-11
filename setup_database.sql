-- ========================================
-- SQL Practice Database Setup
-- ========================================
-- 🎯 QUICK START: Run this ONCE to set up everything
--    sqlite3 practice.db < setup_database.sql
-- 
-- ✅ This creates ALL tables and data for all 5 challenge topics
-- ✅ After running this, you can practice with any challenge file 
-- ✅ No more setup conflicts or copy-pasting schemas!

-- Drop existing tables if they exist (clean slate)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS course_assignments;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS professors;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS support_tickets;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- ========================================
-- BASIC SELECT PRACTICE (Topic 1)
-- ========================================

-- Create departments table first (needed for foreign key)
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    manager_name VARCHAR(100),
    budget DECIMAL(12, 2)
);

-- Insert sample data into departments
INSERT INTO departments VALUES
(1, 'Engineering', 'Alice Cooper', 500000.00),
(2, 'Marketing', 'Bob Smith', 200000.00),
(3, 'Sales', 'Carol Johnson', 300000.00),
(4, 'HR', 'David Wilson', 150000.00),
(5, 'Finance', 'Eve Brown', 250000.00);

-- Create the employees table (unified schema for both basic SELECT and JOIN practice)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    is_active BOOLEAN,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Insert sample data for employees (with department_id foreign keys)
INSERT INTO employees VALUES
(1, 'John', 'Doe', 'john.doe@company.com', 75000.00, 1, '2022-01-15', 1, NULL),
(2, 'Jane', 'Smith', 'jane.smith@company.com', 68000.00, 1, '2021-03-22', 1, 1),
(3, 'Mike', 'Johnson', 'mike.johnson@company.com', 55000.00, 2, '2023-06-10', 1, NULL),
(4, 'Sarah', 'Williams', 'sarah.williams@company.com', 62000.00, 3, '2020-11-05', 0, NULL),
(5, 'Tom', 'Brown', 'tom.brown@company.com', 71000.00, 1, '2022-08-30', 1, 1),
(6, 'Lisa', 'Davis', 'lisa.davis@company.com', 58000.00, 2, '2021-12-18', 1, 3),
(7, 'Chris', 'Wilson', 'chris.wilson@company.com', 48000.00, 4, '2023-02-14', 1, NULL),
(8, 'Amy', 'Garcia', 'amy.garcia@company.com', 45000.00, NULL, '2022-05-07', 1, NULL); -- Employee without department

-- ========================================
-- JOIN PRACTICE (Topic 2)
-- ========================================

-- Create the projects table for JOIN practice (departments already created above)
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT,
    budget DECIMAL(10, 2),
    start_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert sample data into projects
INSERT INTO projects VALUES
(1, 'Website Redesign', 1, 75000.00, '2023-01-15'),
(2, 'Mobile App Development', 1, 120000.00, '2023-03-01'),
(3, 'Marketing Campaign Q2', 2, 35000.00, '2023-04-01'),
(4, 'Sales Training Program', 3, 25000.00, '2023-02-15'),
(5, 'HR Management System', 4, 60000.00, '2023-05-01'),
(6, 'Data Analytics Platform', NULL, 90000.00, '2023-06-01'); -- Project without department

-- ========================================
-- GROUP BY PRACTICE (Topic 3)
-- ========================================

-- Create the customers table for GROUP BY practice
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    registration_date DATE
);

-- Create the products table for GROUP BY practice
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Create the orders table for GROUP BY practice
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create the order_items table for GROUP BY practice
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into customers
INSERT INTO customers VALUES
(1, 'Alice', 'Johnson', 'New York', 'NY', '2022-01-15'),
(2, 'Bob', 'Smith', 'Los Angeles', 'CA', '2022-02-20'),
(3, 'Carol', 'Davis', 'Chicago', 'IL', '2022-03-10'),
(4, 'David', 'Wilson', 'Houston', 'TX', '2022-04-05'),
(5, 'Emma', 'Brown', 'Phoenix', 'AZ', '2022-05-12'),
(6, 'Frank', 'Garcia', 'Philadelphia', 'PA', '2022-06-18'),
(7, 'Grace', 'Miller', 'San Antonio', 'TX', '2022-07-22'),
(8, 'Henry', 'Martinez', 'San Diego', 'CA', '2022-08-30');

-- Insert sample data into products
INSERT INTO products VALUES
(1, 'Laptop Pro', 'Electronics', 1299.99, 50),
(2, 'Wireless Mouse', 'Electronics', 29.99, 200),
(3, 'Office Chair', 'Furniture', 199.99, 75),
(4, 'Smartphone', 'Electronics', 799.99, 100),
(5, 'Desk Lamp', 'Furniture', 49.99, 150),
(6, 'Bluetooth Speaker', 'Electronics', 89.99, 80),
(7, 'Standing Desk', 'Furniture', 399.99, 30),
(8, 'Tablet', 'Electronics', 329.99, 60);

-- Insert sample data into orders
INSERT INTO orders VALUES
(1, 1, '2023-01-15', 1329.98, 'Completed'),
(2, 2, '2023-01-20', 199.99, 'Completed'),
(3, 1, '2023-02-05', 89.99, 'Completed'),
(4, 3, '2023-02-10', 1459.97, 'Completed'),
(5, 4, '2023-02-15', 379.98, 'Completed'),
(6, 2, '2023-03-01', 829.98, 'Pending'),
(7, 5, '2023-03-05', 249.98, 'Completed'),
(8, 6, '2023-03-10', 1699.97, 'Completed'),
(9, 3, '2023-03-15', 49.99, 'Cancelled'),
(10, 7, '2023-03-20', 399.99, 'Completed');

-- Insert sample data into order_items
INSERT INTO order_items VALUES
(1, 1, 1, 1, 1299.99),  -- Laptop Pro
(2, 1, 2, 1, 29.99),    -- Wireless Mouse
(3, 2, 3, 1, 199.99),   -- Office Chair
(4, 3, 6, 1, 89.99),    -- Bluetooth Speaker
(5, 4, 1, 1, 1299.99),  -- Laptop Pro
(6, 4, 5, 2, 49.99),    -- 2x Desk Lamp
(7, 4, 2, 2, 29.99),    -- 2x Wireless Mouse
(8, 5, 4, 1, 799.99),   -- Smartphone
(9, 5, 6, 2, 89.99),    -- 2x Bluetooth Speaker
(10, 6, 4, 1, 799.99),  -- Smartphone
(11, 6, 2, 1, 29.99),   -- Wireless Mouse
(12, 7, 3, 1, 199.99),  -- Office Chair
(13, 7, 5, 1, 49.99),   -- Desk Lamp
(14, 8, 1, 1, 1299.99), -- Laptop Pro
(15, 8, 7, 1, 399.99),  -- Standing Desk
(16, 9, 5, 1, 49.99),   -- Desk Lamp (Cancelled order)
(17, 10, 7, 1, 399.99); -- Standing Desk

-- ========================================
-- SUBQUERY PRACTICE (Topic 4)
-- ========================================

-- Create the students table for subquery practice
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    major VARCHAR(50),
    enrollment_year INT,
    gpa DECIMAL(3, 2)
);

-- Create the courses table for subquery practice
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(10),
    course_name VARCHAR(100),
    department VARCHAR(50),
    credits INT,
    max_enrollment INT
);

-- Create the enrollments table for subquery practice
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    grade VARCHAR(2),
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create the professors table for subquery practice
CREATE TABLE professors (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- Create the course_assignments table for subquery practice
CREATE TABLE course_assignments (
    assignment_id INT PRIMARY KEY,
    course_id INT,
    professor_id INT,
    semester VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

-- Insert sample data into students
INSERT INTO students VALUES
(1, 'John', 'Smith', 'john.smith@university.edu', 'Computer Science', 2022, 3.75),
(2, 'Emma', 'Johnson', 'emma.johnson@university.edu', 'Mathematics', 2021, 3.92),
(3, 'Michael', 'Brown', 'michael.brown@university.edu', 'Physics', 2023, 3.45),
(4, 'Sarah', 'Davis', 'sarah.davis@university.edu', 'Computer Science', 2022, 3.88),
(5, 'David', 'Wilson', 'david.wilson@university.edu', 'Chemistry', 2021, 3.23),
(6, 'Lisa', 'Garcia', 'lisa.garcia@university.edu', 'Mathematics', 2023, 3.67),
(7, 'James', 'Martinez', 'james.martinez@university.edu', 'Physics', 2022, 3.12),
(8, 'Anna', 'Anderson', 'anna.anderson@university.edu', 'Computer Science', 2021, 3.95);

-- Insert sample data into courses
INSERT INTO courses VALUES
(1, 'CS101', 'Introduction to Programming', 'Computer Science', 3, 30),
(2, 'CS201', 'Data Structures', 'Computer Science', 4, 25),
(3, 'MATH101', 'Calculus I', 'Mathematics', 4, 40),
(4, 'MATH201', 'Linear Algebra', 'Mathematics', 3, 30),
(5, 'PHYS101', 'General Physics I', 'Physics', 4, 35),
(6, 'CHEM101', 'General Chemistry', 'Chemistry', 4, 32),
(7, 'CS301', 'Database Systems', 'Computer Science', 3, 20),
(8, 'MATH301', 'Advanced Calculus', 'Mathematics', 4, 15);

-- Insert sample data into professors
INSERT INTO professors VALUES
(1, 'Robert', 'Johnson', 'Computer Science', 95000.00, '2015-08-15'),
(2, 'Mary', 'Williams', 'Mathematics', 88000.00, '2012-01-20'),
(3, 'Thomas', 'Brown', 'Physics', 92000.00, '2018-09-01'),
(4, 'Jennifer', 'Davis', 'Chemistry', 89000.00, '2016-03-10'),
(5, 'William', 'Miller', 'Computer Science', 102000.00, '2010-05-12');

-- Insert sample data into enrollments
INSERT INTO enrollments VALUES
(1, 1, 1, 'Fall 2023', 'A-', '2023-08-25'),
(2, 1, 3, 'Fall 2023', 'B+', '2023-08-25'),
(3, 2, 3, 'Fall 2023', 'A', '2023-08-25'),
(4, 2, 4, 'Fall 2023', 'A-', '2023-08-25'),
(5, 3, 5, 'Fall 2023', 'B', '2023-08-25'),
(6, 4, 1, 'Fall 2023', 'A', '2023-08-25'),
(7, 4, 2, 'Fall 2023', 'A-', '2023-08-25'),
(8, 5, 6, 'Fall 2023', 'C+', '2023-08-25'),
(9, 6, 3, 'Fall 2023', 'B+', '2023-08-25'),
(10, 7, 5, 'Fall 2023', 'C', '2023-08-25'),
(11, 8, 2, 'Fall 2023', 'A', '2023-08-25'),
(12, 8, 7, 'Fall 2023', 'A-', '2023-08-25'),
(13, 1, 2, 'Spring 2024', 'B+', '2024-01-15'),
(14, 4, 7, 'Spring 2024', 'A', '2024-01-15'),
(15, 2, 8, 'Spring 2024', 'A-', '2024-01-15');

-- Insert sample data into course_assignments
INSERT INTO course_assignments VALUES
(1, 1, 1, 'Fall 2023'),
(2, 2, 1, 'Fall 2023'),
(3, 3, 2, 'Fall 2023'),
(4, 4, 2, 'Fall 2023'),
(5, 5, 3, 'Fall 2023'),
(6, 6, 4, 'Fall 2023'),
(7, 7, 5, 'Fall 2023'),
(8, 8, 2, 'Spring 2024'),
(9, 2, 5, 'Spring 2024'),
(10, 7, 1, 'Spring 2024');

-- ========================================
-- NULL HANDLING PRACTICE (Topic 5)
-- ========================================

-- Create the agents table for NULL handling practice
CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50),
    hire_date DATE,
    supervisor_id INT
);

-- Create the support_tickets table for NULL handling practice
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    issue_category VARCHAR(50),
    priority VARCHAR(10),
    status VARCHAR(20),
    created_date DATE,
    assigned_agent_id INT,
    resolved_date DATE,
    customer_satisfaction_rating INT -- 1-5 scale, can be NULL if not rated
);

-- Insert sample data into agents
INSERT INTO agents VALUES
(1, 'Alice', 'Cooper', 'alice.cooper@company.com', 'Technical Support', '2022-01-15', NULL),
(2, 'Bob', 'Taylor', 'bob.taylor@company.com', 'Billing', '2022-03-20', 1),
(3, 'Carol', 'Anderson', 'carol.anderson@company.com', 'Technical Support', '2022-06-10', 1),
(4, 'Dan', 'Miller', 'dan.miller@company.com', 'General Support', '2022-09-05', NULL),
(5, 'Eve', 'Wilson', NULL, 'Technical Support', '2023-01-12', 1); -- Missing email

-- Insert sample data into support_tickets (with NULL values)
INSERT INTO support_tickets VALUES
(1, 1, 'Technical', 'High', 'Resolved', '2023-11-01', 1, '2023-11-02', 5),
(2, 2, 'Billing', 'Medium', 'Resolved', '2023-11-05', 2, '2023-11-07', NULL), -- No rating
(3, 3, 'Technical', 'Low', 'Open', '2023-11-10', NULL, NULL, NULL), -- Unassigned
(4, 4, 'General', 'Medium', 'In Progress', '2023-11-15', 4, NULL, NULL),
(5, 1, 'Billing', 'High', 'Resolved', '2023-11-20', 2, '2023-11-21', 4),
(6, 5, 'Technical', 'Low', 'Resolved', '2023-11-25', 3, '2023-11-28', NULL), -- No rating
(7, 6, 'General', 'Medium', 'Open', '2023-12-01', NULL, NULL, NULL), -- Unassigned
(8, 2, 'Technical', 'High', 'Resolved', '2023-12-05', 1, '2023-12-06', 3),
(9, 8, 'Billing', 'Low', 'Cancelled', '2023-12-08', NULL, NULL, NULL), -- Unassigned, cancelled
(10, 7, 'General', 'Medium', 'Open', '2023-12-10', 4, NULL, NULL);

-- ========================================
-- SETUP COMPLETE
-- ========================================

-- Verify setup by showing table counts
SELECT 'employees' as table_name, COUNT(*) as row_count FROM employees
UNION ALL
SELECT 'departments', COUNT(*) FROM departments
UNION ALL
SELECT 'projects', COUNT(*) FROM projects
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'students', COUNT(*) FROM students
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments
UNION ALL
SELECT 'professors', COUNT(*) FROM professors
UNION ALL
SELECT 'course_assignments', COUNT(*) FROM course_assignments
UNION ALL
SELECT 'agents', COUNT(*) FROM agents
UNION ALL
SELECT 'support_tickets', COUNT(*) FROM support_tickets;

-- Database setup complete! You can now practice with any challenge file. 
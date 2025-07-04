-- 1. CREATE DATABASE
CREATE DATABASE studentdb;

-- 2. CONNECT TO THE DATABASE
\c studentdb;

-- 3. CREATE departments TABLE
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL
);

-- 4. INSERT INTO departments
INSERT INTO departments (dept_name) VALUES
('Computer Science'),
('Electronics'),
('IT'),
('Mechanical');

-- 5. CREATE students TABLE
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,                       -- Using SERIAL ID (no UUID)
    name VARCHAR(100) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),         -- CHECK constraint
    age INT CHECK (age >= 17),                           -- CHECK constraint
    email VARCHAR(100) UNIQUE,                           -- UNIQUE constraint
    percentage NUMERIC(5,2),
    profile JSON,                                        -- JSON data type
    active BOOLEAN DEFAULT true,                         -- BOOLEAN type
    dept_id INT REFERENCES departments(dept_id)          -- FOREIGN KEY constraint
);

-- 6. INSERT sample student records
INSERT INTO students (name, gender, age, email, percentage, profile, dept_id)
VALUES
('Sneha Manani', 'F', 19, 'sneha@gmail.com', 85.60,
 '{"linkedin": "snehamanani", "skills": "SQL, Python"}', 1),
('Raj Patel', 'M', 20, 'rajpatel@gmail.com', 78.20,
 '{"linkedin": "rajp", "skills": "C, Arduino"}', 2),
('Nirali Shah', 'F', 21, 'nirali@gmail.com', 92.10,
 '{"linkedin": "nshah", "skills": "HTML, CSS"}', 3),
('Aman Joshi', 'M', 22, 'amanj@gmail.com', 65.00,
 '{"linkedin": "aman22"}', 4);

-- 7. SELECT with ALIAS
SELECT name AS student_name, percentage AS score FROM students;

-- 8. ORDER BY age descending
SELECT * FROM students ORDER BY age DESC;

-- 9. DISTINCT department IDs
SELECT DISTINCT dept_id FROM students;

-- 10. WHERE with LIKE
SELECT * FROM students WHERE email LIKE '%gmail.com';

-- 11. BETWEEN, IN, IS NOT NULL
SELECT name, percentage FROM students
WHERE percentage BETWEEN 70 AND 90
AND dept_id IN (1, 2)
AND email IS NOT NULL;

-- 12. LIMIT & FETCH
SELECT * FROM students LIMIT 2;
SELECT * FROM students FETCH FIRST 2 ROWS ONLY;

-- 13. JOIN students with departments
SELECT s.name, d.dept_name FROM students s
JOIN departments d ON s.dept_id = d.dept_id;

-- 14. GROUP BY and HAVING
SELECT d.dept_name, COUNT(*) AS total_students
FROM students s
JOIN departments d ON s.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING COUNT(*) > 0;

-- 15. SUBQUERY with EXISTS
SELECT name FROM students s
WHERE EXISTS (
    SELECT 1 FROM departments d
    WHERE d.dept_id = s.dept_id AND d.dept_name = 'Computer Science'
);

-- 16. SUBQUERY with ANY
SELECT name FROM students
WHERE percentage > ANY (
    SELECT percentage FROM students WHERE dept_id = 2
);

-- 17. SUBQUERY with ALL
SELECT name FROM students
WHERE percentage > ALL (
    SELECT percentage FROM students WHERE dept_id = 4
);


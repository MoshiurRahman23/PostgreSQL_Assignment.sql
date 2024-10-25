-- Active: 1729092933305@@127.0.0.1@5432@university_bd
CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INTEGER,
    email VARCHAR(100) NOT NULL,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);
SELECT * FROM students;

CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);
SELECT * FROM courses;

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students (student_id),
    course_id INT REFERENCES courses (course_id)
);
SELECT * FROM enrollment;


---Value insert into table 

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, 'Null'),
('Zoya', 23, 'zoya@example.com', 52, 58, 'Null'),
('Nabil', 22, 'nabil@example.com', 37, 46, 'Null'),
('Rafi', 24, 'rafi@example.com', 41, 40, 'Null'),
('Sophia', 22, 'sophia@example.com', 50, 52, 'Null'),
('Hasan', 23, 'hasan@example.com', 43, 39, 'Null');


INSERT INTO courses(course_name, credits)
VALUES
('Next.js',3),
('React.js',4),
('Database',3),
('Prisma',3);


INSERT INTO enrollment(student_id, course_id)
VALUES
(1,1),
(1,2),
(2,1),
(3,2);

SELECT * FROM enrollment;
--Insert a new student record with the following details
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
('Moshiur',25,'mdmoshiur.set@gmail.com',45,50,'Null');

DROP TABLE students;
DROP TABLE courses;
DROP TABLE enrollment;


--Retrieve the names of all students who are enrolled in the course titled 'Next.js'

SELECT * FROM students
CROSS JOIN courses;
SELECT * FROM students
NATURAL JOIN courses;

SELECT students.student_name
FROM students 
JOIN enrollment ON students.student_id = enrollment.student_id
JOIN courses  ON enrollment.course_id = courses.course_id
WHERE courses.course_name = 'Next.js';


--Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);


--Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM enrollment
);

 --Retrieve the names of students using a limit of 2, starting from the 3rd student.


SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;


--Retrieve the course names and the number of students enrolled in each course.

SELECT courses.course_name, COUNT(enrollment.student_id) AS student_count
FROM courses
LEFT JOIN enrollment ON courses.course_id =enrollment.course_id
GROUP BY courses.course_id, courses.course_name;


--Calculate and display the average age of all students.
SELECT AVG(age) AS student_avg_age
FROM students;

---Retrieve the names of students whose email addresses contain 'example.com'
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';



-- What is PostgreSQL?
--Ans: PostgreSQL is an open-source, advanced relational database management system (RDBMS) 
-- that emphasizes extensibility, scalability, and standards compliance. It was originally 
-- developed at the University of California,
--  Berkeley, and has grown to become one of the most popular databases in the world.



-- What is the purpose of a database schema in PostgreSQL?
--Ans:-In PostgreSQL, a database schema serves as a logical organization or structure within a database. It defines how data is organized, stored, and managed, and it can be thought of as a namespace that holds database objects such as tables, views, indexes, functions, and sequences. The purpose of a schema is to allow for better organization, security, and management of database objects.--


--Question-> Explain the primary key and foreign key concepts in PostgreSQL.
--Answer->In PostgreSQL, primary keys and foreign keys are essential components used to enforce data integrity and establish relationships between tables. Both are types of constraints that ensure the correctness and consistency of the data stored in a relational database./--
--primary key
--A primary key is a column that uniquely identifies each row in a table. It maintain two important rules of database and that is
--1.Uniqueness 2.not null

--Foreign key
--A foreign key is a column on a table that refers to another table column as primary key.It's also maintain to rules .1 reference integrity 2.cascading options


--Q. What is the difference between the VARCHAR and CHAR data types?
--Answer   -> The VARCHAR and CHAR data types in PostgreSQL (and most relational databases) are both used to store character strings, but they differ in terms of storage behavior, flexibility, and performance.

-- Use VARCHAR when the length of the data varies.
-- Use CHAR when the length is consistent for every entry in the column.


-- Q. Explain the purpose of the WHERE clause in a SELECT statement.
--Answer-> The WHERE clause in a SELECT statement filters records by applying conditions. It retrieves only rows that meet the specified criteria, allowing you to refine query results. It supports operators like =, >, <, LIKE, and can combine conditions using AND, OR, and NOT. This helps in extracting relevant data efficiently from a table.


-- What are the LIMIT and OFFSET clauses used for?
--Answer ->
-- The LIMIT and OFFSET clauses are used in SQL to control the number of rows returned by a query and where the retrieval should start.
-- LIMIT: Specifies the maximum number of rows to retrieve. It’s useful for paging or restricting the output.
-- OFFSET: Specifies the starting position (number of rows to skip) before beginning to retrieve rows. Often used with LIMIT to implement pagination.



-- How can you perform data modification using UPDATE statements?
--Answer ->I can modify existing data in a table using the UPDATE statement in PostgresSQL. The UPDATE statement allows to change the values in specified columns for rows that match a given condition.



-- What is the significance of the JOIN operation, and how does it work in PostgreSQL?
--Answer ->The JOIN operation in PostgreSQL combines rows from multiple tables based on related columns, enabling retrieval of related data in one query. It supports various types—INNER JOIN (matches in both tables), LEFT JOIN (all left table rows, matching right), RIGHT JOIN (all right table rows, matching left), and FULL JOIN (all rows from both tables, filling unmatched with NULL). This is essential for leveraging relationships between tables efficiently.



-- Explain the GROUP BY clause and its role in aggregation operations.
--Answer ->The GROUP BY clause groups rows that have the same values in specified columns, allowing aggregate functions ( MAX(),MIN(),SUM(), COUNT(), AVG(), etc.) to perform calculations on each group separately. It’s essential for summarizing data, such as calculating totals or averages for each category in a dataset.



-- How can you calculate aggregate functions like COUNT, SUM, and AVG in PostgreSQL?
--Answer->In PostgreSQL, we can calculate aggregate functions like COUNT(), SUM(), and AVG() by using them in a SELECT query, often with a GROUP BY clause to apply these functions to groups of rows.
-- SELECT COUNT(*) FROM students;
-- SELECT SUM( frontend_mark) FROM students;
-- SELECT AVG( frontend_mark) FROM students;


-- What is the purpose of an index in PostgreSQL, and how does it optimize query performance?
--Answer->An index in PostgreSQL is a database structure that improves the speed of data retrieval operations on a table at the cost of additional storage space and maintenance overhead. It acts like a reference or a lookup table that allows the database engine to find rows more quickly without scanning the entire table.


-- Explain the concept of a PostgreSQL view and how it differs from a table.
--Answer ->A view in PostgreSQL is a virtual table that is based on the result of a SELECT query. It doesn't store data itself but provides a way to represent and interact with data from one or more tables in a simplified or customized manner.
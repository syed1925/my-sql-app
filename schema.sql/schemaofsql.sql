CREATE DATABASE student_management;
USE student_management;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    dob DATE
);

INSERT INTO students (id, name, email, dob) VALUES
(1, 'Ayaan Khan', 'ayaan.khan@example.com', '2003-04-15'),
(2, 'Meera Patel', 'meera.patel@example.com', '2002-11-21'),
(3, 'John Smith', 'john.smith@example.com', '2004-02-10'),
(4, 'Sara Lee', 'sara.lee@example.com', '2003-08-30'),
(5, 'Vikram Reddy', 'vikram.reddy@example.com', '2002-12-12'),
(6, 'Lina Gupta', 'lina.gupta@example.com', '2001-07-05'),
(7, 'Ali Hassan', 'ali.hassan@example.com', '2003-01-19'),
(8, 'Emily Clark', 'emily.clark@example.com', '2002-03-22'),
(9, 'Ravi Verma', 'ravi.verma@example.com', '2004-05-11'),
(10, 'Zara Sheikh', 'zara.sheikh@example.com', '2003-06-18');

CREATE TABLE teachers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO teachers (id, name, email) VALUES
(1, 'Dr. Ramesh Sharma', 'ramesh.sharma@example.com'),
(2, 'Ms. Nita Desai', 'nita.desai@example.com'),
(3, 'Prof. Alan Brown', 'alan.brown@example.com'),
(4, 'Mr. Imran Qureshi', 'imran.qureshi@example.com'),
(5, 'Mrs. Kavita Mehta', 'kavita.mehta@example.com');

CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

INSERT INTO courses (id, name, teacher_id) VALUES
(1, 'Database Systems', 1),
(2, 'Web Development', 2),
(3, 'Data Structures', 3),
(4, 'Computer Networks', 4),
(5, 'Software Engineering', 5);

CREATE TABLE enrollments (
    id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO enrollments (id, student_id, course_id, enroll_date) VALUES
(1, 1, 1, '2023-08-01'),
(2, 1, 2, '2023-08-01'),
(3, 2, 1, '2023-08-02'),
(4, 2, 3, '2023-08-02'),
(5, 3, 1, '2023-08-03'),
(6, 3, 4, '2023-08-03'),
(7, 4, 2, '2023-08-04'),
(8, 4, 5, '2023-08-04'),
(9, 5, 3, '2023-08-05'),
(10, 5, 4, '2023-08-05'),
(11, 6, 1, '2023-08-06'),
(12, 6, 2, '2023-08-06'),
(13, 7, 5, '2023-08-07'),
(14, 7, 3, '2023-08-07'),
(15, 8, 2, '2023-08-08'),
(16, 8, 4, '2023-08-08'),
(17, 9, 1, '2023-08-09'),
(18, 9, 5, '2023-08-09'),
(19, 10, 2, '2023-08-10'),
(20, 10, 3, '2023-08-10');

CREATE TABLE results (
    id INT PRIMARY KEY,
    enrollment_id INT,
    score DECIMAL(5,2),
    grade VARCHAR(2),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(id)
);


INSERT INTO results (id, enrollment_id, score, grade) VALUES
(1, 1, 85.5, 'A'),
(2, 2, 78.0, 'B'),
(3, 3, 92.0, 'A'),
(4, 4, 69.5, 'C'),
(5, 5, 88.0, 'A'),
(6, 6, 75.5, 'B'),
(7, 7, 81.0, 'B'),
(8, 8, 90.0, 'A'),
(9, 9, 66.0, 'C'),
(10, 10, 72.5, 'B'),
(11, 11, 94.0, 'A'),
(12, 12, 85.0, 'A'),
(13, 13, 79.0, 'B'),
(14, 14, 88.5, 'A'),
(15, 15, 61.0, 'D'),
(16, 16, 70.0, 'C'),
(17, 17, 80.0, 'B'),
(18, 18, 86.5, 'A'),
(19, 19, 65.0, 'C'),
(20, 20, 77.0, 'B');

select * from students;
select * from courses;
select * from teachers;
select * from enrollments;
select * from results;  

-- 1.List all students born after January 1, 2003.
select name,id from students
where dob > 2003/1/1;

-- 2. Show the names of all courses taught by Dr. Ramesh Sharma.
select c.name , T.name
 from courses as c
 inner join teachers as T
on c.id = T.id
where T.name="Dr. Ramesh Sharma";


-- 3 Retrieve all student names and their enrolled course names.

select s.name , c.name
from enrollments as e
inner join students as s on e.student_id= s.id
inner join courses as c on  e.course_id =c.id ;



-- 4. Display all student names along with course names and the marks they scored.
  select s.name , c.name, r.score
from enrollments as e
inner join students as s on e.student_id= s.id
inner join courses as c on  e.course_id =c.id 
inner join results as r on e.id= r.id;

-- 5.Show the average score for each student.

select s.name , avg(r.score) as avg, c.name
from enrollments as e
inner join students as s on e.student_id= s.id
inner join results as r on e.id= r.enrollment_id
inner join courses as c on  e.course_id =c.id 
group by e.id;

select * from students;
select * from courses;
select * from teachers;
select * from enrollments;
select * from results; 
-- 6 Count how many students are enrolled in each course.


select count(s.name) as total_students , c.name
from enrollments as e
inner join students as s on e.student_id= s.id
inner join courses as c on  e.course_id =c.id
group by name ;

-- 7 List courses that have more than 3 students enrolled.
select count(s.name) as total_students , c.name

from enrollments as e
inner join students as s on e.student_id= s.id
inner join courses as c on  e.course_id =c.id
group by c.name
HAVING COUNT(s.name) > 3; 

-- 8 Find the total number of students enrolled in “Database Systems”.
-- 1 total number of students enrolled in their respective courses
select count(s.name) as student_names, c.name as course_name
from enrollments as e
inner join students as s on s.id= e.student_id
inner join courses as c on c.id= e.course_id
group by c.name ;
-- 2 print only those students who are enrolled in DATA BASE SYSTEMS 
select count(s.name) as student_names, c.name as course_name
from enrollments as e
inner join students as s on s.id= e.student_id
inner join courses as c on c.id= e.course_id
group by c.name 
having c.name= "Database Systems";

-- 9 Find the name of the top-performing student by average score.

select s.name as student_name, avg(r.score)
from enrollments e
inner join students as s on s.id= e.student_id
inner join results as r on enrollment_id=e.id
group by s.name
order by avg(r.score) desc
limit 1;

-- 10.List students who have scored above average in any course.
-- 1 print the average first
select avg(score) from results;
-- students above avgerage
select s.name as studentname, avg(r.score) as average_score
from enrollments e 
inner join students as s on s.id=e.student_id
inner join results as r on enrollment_id=e.id
group by s.name
having average_score> 79;


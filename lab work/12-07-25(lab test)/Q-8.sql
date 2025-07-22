use lab_test_12_07_25

CREATE TABLE student_info_Q_8 (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Age INT,
    Gender NVARCHAR(10),
    Class NVARCHAR(10),
    Section NVARCHAR(10),
    Address NVARCHAR(100),
    Phone NVARCHAR(20),
    Email NVARCHAR(50),
    DOB DATE
);

CREATE TABLE student_personal_Q8 (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Age INT,
    Gender NVARCHAR(10),
    DOB DATE
);

CREATE TABLE student_contact_Q8 (
    StudentID INT PRIMARY KEY,
    Address NVARCHAR(100),
    Phone NVARCHAR(20),
    Email NVARCHAR(50)
);

CREATE TABLE student_academic_Q8 (
    StudentID INT PRIMARY KEY,
    Class NVARCHAR(10),
    Section NVARCHAR(10)
);


CREATE TRIGGER trg_student_insert_Q8
ON student_info_Q_8
AFTER INSERT
AS
BEGIN
   -- SET NOCOUNT ON;

    -- Insert into personal info table
    INSERT INTO student_personal_Q8 (StudentID, Name, Age, Gender, DOB)
    SELECT StudentID, Name, Age, Gender, DOB
    FROM inserted;

    -- Insert into contact info table
    INSERT INTO student_contact_Q8 (StudentID, Address, Phone, Email)
    SELECT StudentID, Address, Phone, Email
    FROM inserted;

    -- Insert into academic info table
    INSERT INTO student_academic_Q8 (StudentID, Class, Section)
    SELECT StudentID, Class, Section
    FROM inserted;
END;


INSERT INTO student_info_Q_8
(StudentID, Name, Age, Gender, Class, Section, Address,          Phone,              Email,              DOB)
VALUES
       (1, 'Asik', 25, 'Male',  '10',   'A',   'Tangail-delduar', '0123456789', 'asik13579@gmail.com', '2000-01-01');


select * from student_info_Q_8;
select * from student_personal_Q8;
select * from student_academic_Q8;
select * from student_contact_Q8;

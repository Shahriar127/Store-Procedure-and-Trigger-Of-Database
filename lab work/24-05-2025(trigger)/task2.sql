create database lab_24_5_25_trigger


-- Main student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    dept VARCHAR(50),
    mob_no VARCHAR(15),
    district VARCHAR(50),
    balance DECIMAL(10, 2)
);

-- Student info table 1: basic details
CREATE TABLE studentinfo1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    dept VARCHAR(50)
);

-- Student info table 2: contact and financial info
CREATE TABLE studentinfo2 (
    id INT PRIMARY KEY,
    mob_no VARCHAR(15),
    district VARCHAR(50),
    balance DECIMAL(10, 2)
);






CREATE TRIGGER trg_InsertStudent
ON student
AFTER INSERT
AS
BEGIN
     
    INSERT INTO studentinfo1 (id, name, dept)
    SELECT id, name, dept
    FROM inserted;
 
    INSERT INTO studentinfo2 (id, mob_no, district, balance)
    SELECT id, mob_no, district, balance
    FROM inserted;
END;



select * from student;
select * from studentinfo1;
select * from studentinfo2;

 
INSERT INTO student (id, name, dept, mob_no, district, balance)
VALUES (1, 'Tanvir Hossain', 'CSE', '01711112222', 'Dhaka', 1500.00);


-- Insert second student
INSERT INTO student (id, name, dept, mob_no, district, balance)
VALUES (2, 'Farhana Akter', 'EEE', '01888889999', 'Chittagong', 2200.50);

-- Insert third student
INSERT INTO student (id, name, dept, mob_no, district, balance)
VALUES (3, 'Rahim Uddin', 'BBA', '01912345678', 'Sylhet', 1800.75);

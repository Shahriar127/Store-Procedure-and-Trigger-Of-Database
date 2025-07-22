CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    department VARCHAR(50),
    year INT,
    gpa NUMERIC(3,2),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT
);


CREATE TABLE student_basic_info (
    student_id INT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE student_academic_info (
    student_id INT,
    department VARCHAR(50),
    year INT,
    gpa NUMERIC(3,2)
);

CREATE TABLE student_contact_info (
    student_id INT,
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT
);


CREATE OR REPLACE FUNCTION insert_student_to_3_tables()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert into basic info table
    INSERT INTO student_basic_info (student_id, name, age, gender)
    VALUES (NEW.student_id, NEW.name, NEW.age, NEW.gender);

    -- Insert into academic info table
    INSERT INTO student_academic_info (student_id, department, year, gpa)
    VALUES (NEW.student_id, NEW.department, NEW.year, NEW.gpa);

    -- Insert into contact info table
    INSERT INTO student_contact_info (student_id, phone, email, address)
    VALUES (NEW.student_id, NEW.phone, NEW.email, NEW.address);

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_student_insert
AFTER INSERT ON student
FOR EACH ROW
EXECUTE FUNCTION insert_student_to_3_tables();


INSERT INTO student (name, age, gender, department, year, gpa, phone, email, address)
VALUES ('Shahriar', 22, 'Male', 'CSE', 4, 3.75, '01700000000', 'shahriar@example.com', 'Dhaka');

SELECT * FROM student_basic_info;
SELECT * FROM student_academic_info;
SELECT * FROM student_contact_info;


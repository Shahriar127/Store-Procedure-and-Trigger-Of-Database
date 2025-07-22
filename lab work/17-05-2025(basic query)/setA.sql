create database lab_17_5_25_basic_query

-- =============================
-- SET-A: Hospital Database
-- =============================

-- 1. Creating necessary tables
CREATE TABLE Patient (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    SurName VARCHAR(50),
    Admission_Date DATE,
    Dr_ID INT,
    Ward_No INT
);

CREATE TABLE Ailment (
    Ailment_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Patient_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(ID)
);

CREATE TABLE Ward (
    Ward_No INT PRIMARY KEY,
    Ward_Name VARCHAR(50)
);

CREATE TABLE Doctor (
    ID INT PRIMARY KEY,
    SurName VARCHAR(50),
    FirstName VARCHAR(50),
    No_of_Patient INT,
    Ailment_ID INT
);

-- 2. Inserting sample data
INSERT INTO Doctor VALUES
(1, 'Jones', 'Robert', 15, 101),
(2, 'Thomas', 'Sarah', 12, 102),
(3, 'Ali', 'Imran', 18, 103),
(4, 'Khan', 'Fahim', 20, 104),
(5, 'Chowdhury', 'Nusrat', 14, 105);

INSERT INTO Ward VALUES
(1, 'General'), (2, 'Surgery'), (3, 'ICU');

INSERT INTO Patient VALUES
(1, 'Amina', 'Begum', '2024-01-01', 1, 1),
(2, 'Rahim', 'Thomas', '2024-01-02', 2, 2),
(3, 'Karim', 'Mia', '2024-01-03', 3, 2),
(4, 'Nusrat', 'Jahan', '2024-01-04', 2, 1),
(5, 'Zara', 'Ali', '2024-01-05', 4, 3);

INSERT INTO Ailment VALUES
(101, 'Fever', 1), (102, 'Diabetes', 2), (103, 'Flu', 3), (104, 'Asthma', 4), (105, 'Fracture', 5);

-- 3. Performing Queries
-- i. List the surnames of all patients of 'Dr. Jones'
SELECT SurName FROM Patient WHERE Dr_ID = (
    SELECT ID FROM Doctor WHERE SurName = 'Jones'
);

-- ii. List all the doctors who specialize in the ailment suffered by the patient whose surname is 'Thomas'
SELECT * FROM Doctor WHERE Ailment_ID IN (
    SELECT Ailment_ID FROM Ailment WHERE Patient_ID IN (
        SELECT ID FROM Patient WHERE SurName = 'Thomas')
);

-- iii. List the ward number and ward name of the wards which have the most patients
SELECT Ward_No, Ward_Name FROM Ward WHERE Ward_No IN (
    SELECT TOP 1 Ward_No FROM Patient
    GROUP BY Ward_No
    ORDER BY COUNT(*) DESC
);

-- iv. Provide a list of all patients who have not suffered any ailment
SELECT * FROM Patient WHERE ID NOT IN (
    SELECT Patient_ID FROM Ailment
);

-- v. Show the Doctor's name who have the third highest no of patient
SELECT TOP 1 FirstName + ' ' + SurName AS DoctorName FROM (
    SELECT TOP 3 * FROM Doctor ORDER BY No_of_Patient DESC
) AS temp ORDER BY No_of_Patient ASC;

 
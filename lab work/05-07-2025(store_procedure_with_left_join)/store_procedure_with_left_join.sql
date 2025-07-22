create database lab_05_07_25_store_procedure_with_variable
use lab_05_07_25_store_procedure_with_variable

CREATE TABLE info_1 (
    id INT PRIMARY KEY,
    name NVARCHAR(50),
    dept NVARCHAR(50),
    brand_of_laptop NVARCHAR(50)
);

CREATE TABLE info_2 (
    id INT PRIMARY KEY,
    district NVARCHAR(50),
    balance DECIMAL(10,2),
    cgpa FLOAT
);

 INSERT INTO info_1 VALUES
(1, 'Asif', 'CSE', 'Dell'),
(2, 'Rahim', 'EEE', 'HP'),
(3, 'Karim', 'CSE', 'Lenovo'),
(4, 'Shakil', 'ME', 'Asus'),
(5, 'Mamun', 'CSE', 'Acer'),
(6, 'Jahid', 'EEE', 'Dell'),
(7, 'Sabbir', 'ME', 'HP'),
(8, 'Nayeem', 'CSE', 'Lenovo'),
(9, 'Hasan', 'EEE', 'Asus'),
(10, 'Rafi', 'ME', 'Acer');


INSERT INTO info_2 VALUES
(2, 'Chittagong', 12000.50, 3.50),
(4, 'Khulna', 14000.00, 3.60),
(6, 'Barisal', 13000.75, 3.40),
(8, 'Sylhet', 16000.20, 3.80),
(10, 'Rangpur', 15500.90, 3.70);


  create  PROCEDURE GetStudentInfo
    @id INT = NULL,
    @dept NVARCHAR(50) = NULL,
    @district NVARCHAR(50) = NULL,
    @brand NVARCHAR(50) = NULL,
    @minBalance DECIMAL(10,2) = NULL,
    @maxBalance DECIMAL(10,2) = NULL,
    @minCgpa FLOAT = NULL,
    @maxCgpa FLOAT = NULL
AS
BEGIN
    SELECT 
        i1.id,
        i1.name,
        i1.dept,
        i1.brand_of_laptop,
        i2.district,
        i2.balance,
        i2.cgpa
    FROM info_1 i1
    LEFT JOIN info_2 i2 ON i1.id = i2.id
    WHERE 
        (@id IS NULL OR i1.id = @id) AND
        (@dept IS NULL OR i1.dept = @dept) AND
        (@district IS NULL OR i2.district = @district) AND
        (@brand IS NULL OR i1.brand_of_laptop = @brand) AND
        (@minBalance IS NULL OR i2.balance >= @minBalance) AND
        (@maxBalance IS NULL OR i2.balance <= @maxBalance) AND
        (@minCgpa IS NULL OR i2.cgpa >= @minCgpa) AND
        (@maxCgpa IS NULL OR i2.cgpa <= @maxCgpa)
END

EXEC GetStudentInfo @id = NULL, @dept = NULL, @district = NULL;


EXEC GetStudentInfo @dept = 'CSE';

EXEC GetStudentInfo @dept = 'EEE', @district = 'Barisal';

EXEC GetStudentInfo @minBalance = 12000, @maxBalance = 18000;

EXEC GetStudentInfo 
    @dept = 'CSE', 
    @brand = 'Dell',
    @minCgpa = 3.7;

CREATE DATABASE lab_21_6_25_inset_wihout_store_procedure 

GO

USE  lab_21_6_25_inset_wihout_store_procedure ;
GO

   CREATE TABLE Studentinfo (
    StudentID INT PRIMARY KEY ,
    Name NVARCHAR(100),
    Age INT,
    Department NVARCHAR(100),
    District NVARCHAR(100),
    Phone NVARCHAR(20)
);


select * from  StudentInfo 

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME ='Studentinfo'

DELETE FROM StudentInfo;
 
 

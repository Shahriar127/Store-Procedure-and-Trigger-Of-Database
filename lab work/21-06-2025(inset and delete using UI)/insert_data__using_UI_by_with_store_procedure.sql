 CREATE TABLE Studentinfo_1 (
    StudentID INT PRIMARY KEY ,
    Name NVARCHAR(100),
    Age INT,
    Department NVARCHAR(100),
    District NVARCHAR(100),
    Phone NVARCHAR(20)
);

drop table Studentinfo_1


CREATE OR ALTER PROCEDURE InsertStudent
    @StudentID INT,
    @Name NVARCHAR(100),
    @Age INT,
    @Department NVARCHAR(100),
    @District NVARCHAR(100),
    @Phone NVARCHAR(20)
AS
BEGIN
    INSERT INTO Studentinfo_1 (StudentID, Name, Age, Department, District, Phone)
    VALUES (@StudentID, @Name, @Age, @Department, @District, @Phone)
END


drop procedure InsertStudent


select * from Studentinfo_1 

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME ='Studentinfo_1'

   SELECT name 
FROM sys.tables;

 CREATE OR ALTER PROCEDURE DeleteStudent
    @StudentID INT
AS
BEGIN
    DELETE FROM Studentinfo_1 WHERE StudentID = @StudentID
END








  CREATE TABLE Studentinfo_UI_changeable(
    StudentID INT PRIMARY KEY ,
    Name NVARCHAR(100),
    Age INT,
    Department NVARCHAR(100),
    District NVARCHAR(100),
    Phone NVARCHAR(20)
);

select * from Studentinfo_UI_changeable

ALTER TABLE Studentinfo_UI_changeable  ADD gender NVARCHAR(10);

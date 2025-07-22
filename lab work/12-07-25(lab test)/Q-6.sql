
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(50),
    District NVARCHAR(50)
);

CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY,
    SubjectName NVARCHAR(50)
);


CREATE TABLE Marks (
    MarkID INT PRIMARY KEY,
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
    Score INT
);



INSERT INTO Students (StudentID, Name, District) VALUES
(1, 'Rafiul Islam', 'Dhaka'),
(2, 'Shamima Akter', 'Chittagong'),
(3, 'Nahid Hasan', 'Rajshahi'),
(4, 'Tasnim Jahan', 'Sylhet'),
(5, 'Mehedi Hossain', 'Barisal');

select * from Students

INSERT INTO Subjects (SubjectID, SubjectName) VALUES
(1, 'Mathematics'),
(2, 'English'),
(3, 'Physics'),
(4, 'Chemistry'),
(5, 'Bangla');


INSERT INTO Marks (MarkID, StudentID, SubjectID, Score) VALUES
(1, 1, 1, 88),   -- Rafiul - Mathematics
(2, 2, 2, 76),   -- Shamima - English
(3, 3, 3, 92),   -- Nahid - Physics
(4, 4, 4, 81),   -- Tasnim - Chemistry
(5, 5, 5, 85);   -- Mehedi - Bangla



select * from Students;
select * from Subjects;
select * from Marks;



CREATE OR ALTER PROCEDURE GetStudentPerformance
    @StudentID INT = NULL,
    @Name NVARCHAR(50) = NULL,
    @District NVARCHAR(50) = NULL,
    @SubjectName NVARCHAR(50) = NULL,
    @MinScore INT = NULL
AS
BEGIN
    SELECT s.StudentID, s.Name, s.District, sub.SubjectName, m.Score
    FROM Students s
    JOIN Marks m ON s.StudentID = m.StudentID
    JOIN Subjects sub ON m.SubjectID = sub.SubjectID
    WHERE 
        (@StudentID IS NULL OR s.StudentID = @StudentID)
        AND (@Name IS NULL OR s.Name LIKE '%' + @Name + '%')
        AND (@District IS NULL OR s.District = @District)
        AND (@SubjectName IS NULL OR sub.SubjectName = @SubjectName)
        AND (@MinScore IS NULL OR m.Score >= @MinScore)
END



CREATE OR ALTER PROCEDURE GetStudentPerformance
    @StudentID INT = NULL,
    @Name NVARCHAR(50) = NULL,
    @SubjectName NVARCHAR(50) = NULL,
    @MinScore INT = NULL
AS
BEGIN
    SELECT s.StudentID, s.Name, sub.SubjectName, m.Score
    FROM Students s
    JOIN Marks m ON s.StudentID = m.StudentID
    JOIN Subjects sub ON m.SubjectID = sub.SubjectID
    WHERE 
        (@StudentID IS NULL OR s.StudentID = @StudentID)
        AND (@Name IS NULL OR s.Name LIKE '%' + @Name + '%')
        AND (@SubjectName IS NULL OR sub.SubjectName = @SubjectName)
        AND (@MinScore IS NULL OR m.Score >= @MinScore)
END



use lab_test_12_07_25

CREATE TABLE Students_Q_5 (
    regno INT PRIMARY KEY,
    mark1 INT,
    mark2 INT,
    total INT
);

INSERT INTO Students_Q_5 (regno,mark1,mark2)
VALUES (1,50 ,60);
select * from Students_Q_5



CREATE PROCEDURE Calculate_Total_Q_5
    @regno INT,
    @mark1 INT,
    @mark2 INT
AS
BEGIN
    DECLARE @total INT;

    -- Calculate total
    SET @total = @mark1 + @mark2;

    -- Update table with marks and total
    UPDATE Students_Q_5
    SET  total = @total
    WHERE regno = @regno;

    -- Print result
    PRINT 'Reg No: ' + CAST(@regno AS VARCHAR) 
          + ', Mark1: ' + CAST(@mark1 AS VARCHAR)
          + ', Mark2: ' + CAST(@mark2 AS VARCHAR)
          + ', Total: ' + CAST(@total AS VARCHAR);
END;

EXEC Calculate_Total_Q_5 1, 50, 60;

select * from Students_Q_5
 
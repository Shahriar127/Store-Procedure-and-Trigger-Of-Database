use lab_test_12_07_25


CREATE TABLE EMPLOYEE_Q_3 (
    EmpNo INT PRIMARY KEY,       -- Employee number
    Name NVARCHAR(50),           -- Employee name
    Salary DECIMAL(10,2)         -- Employee salary
);

INSERT INTO EMPLOYEE_Q_3  
VALUES (1, 'Asik', 5000.00);

select * from EMPLOYEE_Q_3;


CREATE PROCEDURE raise_sal
    @EmpNo INT,                  -- Employee number
    @SalIncrease DECIMAL(10,2)   -- Amount to increase salary
AS
BEGIN
    -- Update EMPLOYEE_Q_3 to increase salary
    UPDATE EMPLOYEE_Q_3
    SET Salary = Salary + @SalIncrease
    WHERE EmpNo = @EmpNo;

    -- Optional: print a message
    PRINT 'Salary increased successfully for employee.';
END;

EXEC raise_sal @EmpNo = 1, @SalIncrease = 1000.00;

select * from EMPLOYEE_Q_3;
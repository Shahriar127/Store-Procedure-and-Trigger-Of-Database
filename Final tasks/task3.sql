CREATE TABLE EMPLOYEE3 (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    salary NUMERIC(10,2)
);


INSERT INTO EMPLOYEE3 (emp_name, salary) VALUES
('Shahriar', 50000),
('Mim', 60000),
('Tanvir', 55000);


CREATE OR REPLACE PROCEDURE raise_sal(emp_number INT, increase_amt NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE EMPLOYEE3
    SET salary = salary + increase_amt
    WHERE emp_id = emp_number;

    IF NOT FOUND THEN
        RAISE NOTICE 'Employee with ID % not found.', emp_number;
    ELSE
        RAISE NOTICE 'Salary updated successfully for employee ID %', emp_number;
    END IF;
END;
$$;

CALL raise_sal(1, 5000);


SELECT * FROM EMPLOYEE3 WHERE emp_id = 1;

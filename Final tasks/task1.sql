CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50)
);


INSERT INTO Employees (emp_name, department) VALUES
('Shahriar', 'Engineering'),
('Mim', 'HR'),
('Tanvir', 'Marketing');

SELECT * FROM Employees;


CREATE OR REPLACE FUNCTION prevent_modifications()
RETURNS trigger AS $$
BEGIN
    RAISE EXCEPTION 'Insert, Update, and Delete operations are not allowed on the Employees table.';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER block_all_changes
BEFORE INSERT OR UPDATE OR DELETE ON Employees
FOR EACH ROW
EXECUTE FUNCTION prevent_modifications();



INSERT INTO Employees (emp_name, department) VALUES ('Nadim', 'Finance');




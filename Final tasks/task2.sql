CREATE TABLE Employees2 (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO Employees2 (emp_name, department) VALUES
('Shahriar', 'Engineering'),
('Mim', 'HR'),
('Tanvir', 'Marketing');



CREATE OR REPLACE FUNCTION prevent_insert_update()
RETURNS trigger AS $$
BEGIN
    RAISE EXCEPTION 'Insert and Update operations are not allowed on this table.';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER block_insert_update
BEFORE INSERT OR UPDATE ON Employees2
FOR EACH ROW
EXECUTE FUNCTION prevent_insert_update();

INSERT INTO Employees2 (emp_name, department) VALUES ('Nadim', 'Finance');
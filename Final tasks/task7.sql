CREATE TABLE employees4 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    salary NUMERIC(10, 2)
);

drop table employees4

CREATE TABLE employees_audit (
    audit_id SERIAL PRIMARY KEY,
    action_type VARCHAR(10),
    old_id INT,
    old_name VARCHAR(100),
    old_salary NUMERIC(10, 2),
    new_id INT,
    new_name VARCHAR(100),
    new_salary NUMERIC(10, 2),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE OR REPLACE FUNCTION log_employee_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO employees_audit (
            action_type, new_id, new_name, new_salary
        ) VALUES (
            'INSERT', NEW.id, NEW.name, NEW.salary
        );

    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO employees_audit (
            action_type, old_id, old_name, old_salary,
            new_id, new_name, new_salary
        ) VALUES (
            'UPDATE',
            OLD.id, OLD.name, OLD.salary,
            NEW.id, NEW.name, NEW.salary
        );

    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO employees_audit (
            action_type, old_id, old_name, old_salary
        ) VALUES (
            'DELETE', OLD.id, OLD.name, OLD.salary
        );
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_employees_change
AFTER INSERT OR UPDATE OR DELETE ON employees4
FOR EACH ROW
EXECUTE FUNCTION log_employee_changes();

select * from employees4 

INSERT INTO employees4 (name, salary) VALUES ('Shahriar', 40000);

UPDATE employees4 SET salary = 45000 WHERE id = 1;

select * from employees_audit
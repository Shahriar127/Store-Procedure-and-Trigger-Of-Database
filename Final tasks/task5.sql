CREATE TABLE itstudent2 (
    regno INT PRIMARY KEY,
    name VARCHAR(100),
    mark1 INT,
    mark2 INT,
    total INT
);


INSERT INTO itstudent2 (regno, name, mark1, mark2, total) VALUES
(101, 'Shahriar', 0, 0, 0),
(102, 'Mim', 0, 0, 0),
(103, 'Tanvir', 0, 0, 0);

CREATE OR REPLACE PROCEDURE pl(reg INT, m1 INT, m2 INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE itstudent2
    SET mark1 = m1,
        mark2 = m2,
        total = m1 + m2
    WHERE regno = reg;

    IF NOT FOUND THEN
        RAISE NOTICE 'Student with regno % not found.', reg;
    ELSE
        RAISE NOTICE 'Total updated for student with regno %.', reg;
    END IF;
END;
$$;


CALL pl(101, 40, 45);
CALL pl(102, 38, 35);

SELECT * FROM itstudent2;

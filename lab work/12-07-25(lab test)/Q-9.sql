use lab_test_12_07_25;
 CREATE TABLE population_Q9 (
    NID VARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(50),
    DateOfBirth DATE,
    DateOfDeath NVARCHAR(10) DEFAULT 'alive'   -- 'alive' or death date as string
);

SELECT 
    name AS ConstraintName
FROM 
    sys.key_constraints
WHERE 
    type = 'PK' 
    AND OBJECT_NAME(parent_object_id) = 'population_Q9';

ALTER TABLE population_Q9
DROP CONSTRAINT  PK__populati__C7DEC333A1485BBD;



CREATE TABLE birth_people_Q9 (
    NID VARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(50),
    DateOfBirth DATE
);

CREATE TABLE dead_people_Q9 (
    NID VARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(50),
    DateOfDeath DATE
);

CREATE TABLE PopulationCount_Q9 (
    TotalPopulation INT
);

-- Initialize population count to zero
INSERT INTO PopulationCount_Q9 VALUES (0);



CREATE TRIGGER trg_Birth_people_insert_Q9
ON birth_people_Q9
AFTER INSERT
AS
BEGIN
 
    INSERT INTO population_Q9 (NID, Name, DateOfBirth)
    SELECT i.NID, i.Name, i.DateOfBirth
    FROM inserted i
    WHERE NOT EXISTS (
        SELECT 1 FROM population_Q9 p WHERE p.NID = i.NID
    );

    UPDATE PopulationCount_Q9
    SET TotalPopulation = TotalPopulation + (SELECT COUNT(*) FROM inserted);
END;


INSERT INTO birth_people_Q9 (NID, Name, DateOfBirth)
VALUES ('NID001', 'Baby-1', '2025-07-10');

select * from birth_people_Q9;
select * from population_Q9;
select * from PopulationCount_Q9;


CREATE TRIGGER trg_dead_people_insert_Q9
ON dead_people_Q9
AFTER INSERT
AS
BEGIN
 
    -- Insert missing people into population_Q9 by getting birth info from birth_people_Q9
    INSERT INTO population_Q9 (NID, Name, DateOfBirth, DateOfDeath)
    SELECT i.NID, i.Name, b.DateOfBirth, CONVERT(NVARCHAR(10), i.DateOfDeath, 23)  -- style code 23=yyyy-mm-dd
    FROM inserted i
     LEFT JOIN birth_people_Q9 b ON i.NID = b.NID
 
  

    -- Decrease total population count
    UPDATE PopulationCount_Q9
    SET TotalPopulation = CASE
        WHEN TotalPopulation - (SELECT COUNT(*) FROM inserted) < 0 THEN 0
        ELSE TotalPopulation - (SELECT COUNT(*) FROM inserted)
    END;
END;




INSERT INTO dead_people_Q9 (NID, Name, DateOfDeath)
VALUES ('NID001', 'Baby-1', '2025-08-11');

 
select * from dead_people_Q9;
select * from population_Q9;
select * from PopulationCount_Q9;

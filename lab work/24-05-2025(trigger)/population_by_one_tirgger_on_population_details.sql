-- Main table
CREATE TABLE population_details (
    person_id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100),
    gender NVARCHAR(10),
    birth_date DATE,
    birth_place NVARCHAR(100),
    is_alive BIT, -- 1 = alive, 0 = dead
    death_date DATE NULL,
    death_place NVARCHAR(100) NULL
);

-- Birth table
CREATE TABLE birth (
    birth_id INT PRIMARY KEY IDENTITY(1,1),
    person_id INT,
    birth_date DATE,
    birth_place NVARCHAR(100),
    FOREIGN KEY (person_id) REFERENCES population_details(person_id)
);

-- Death table
CREATE TABLE death (
    death_id INT PRIMARY KEY IDENTITY(1,1),
    person_id INT,
    death_date DATE NULL,
    death_place NVARCHAR(100),
    FOREIGN KEY (person_id) REFERENCES population_details(person_id)
);
 


 CREATE TRIGGER trg_InsertPopulationDetails
ON population_details
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert into birth table
    INSERT INTO birth (person_id, birth_date, birth_place)
    SELECT 
        person_id,
        birth_date,
        birth_place
    FROM INSERTED;

    -- Insert into death table only if person is dead (is_alive = 0)
    INSERT INTO death (person_id, death_date, death_place)
    SELECT 
        person_id,
        death_date,
        death_place
    FROM INSERTED
    WHERE is_alive = 0;
END;


 -- Insert multiple alive people
INSERT INTO population_details (full_name, gender, birth_date, birth_place, is_alive)
VALUES 
('Tanvir Hossain', 'Male', '1995-02-14', 'Dhaka', 1),
('Rahim Mia', 'Male', '2024-01-12', 'Cumilla', 1),
('Lamia Hossain', 'Female', '2001-08-21', 'Khulna', 1);

-- Insert multiple deceased people
INSERT INTO population_details (full_name, gender, birth_date, birth_place, is_alive, death_date, death_place)
VALUES 
('Sharmin Akter', 'Female', '1980-06-30', 'Chattogram', 0, '2023-08-10', 'Chattogram'),
('Abdul Karim', 'Male', '1945-03-25', 'Rajshahi', 0, '2010-11-05', 'Rajshahi'),
('Rafiqul Islam', 'Male', '1965-05-10', 'Sylhet', 0, '2022-12-01', 'Sylhet');

select * from population_details;
select * from birth;
select * from death;

delete from population_details;
delete  from  birth;
delete  from death


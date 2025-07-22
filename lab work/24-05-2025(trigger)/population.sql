use lab_24_5_25_trigger
-- Main population table
CREATE TABLE population (
    nid INT PRIMARY KEY,
    dob DATE,
    name NVARCHAR(100),
    district NVARCHAR(100)
);

-- Records of births
CREATE TABLE birth_info (
    nid INT PRIMARY KEY,
    dob DATE,
    name NVARCHAR(100),
    district NVARCHAR(100)
);

-- Records of deaths
CREATE TABLE death_info (
    nid INT PRIMARY KEY,
    date DATE,
    name NVARCHAR(100)
);


CREATE TRIGGER trg_birth_info_insert
ON birth_info
AFTER INSERT
AS
BEGIN
   

    INSERT INTO population (nid, dob, name, district)
    SELECT nid, dob, name, district
    FROM inserted
    
END;




CREATE TRIGGER trg_death_info_insert
ON death_info
AFTER INSERT
AS
BEGIN
    

    DELETE FROM population
    WHERE nid IN (SELECT nid FROM inserted);
END;



INSERT INTO birth_info (nid, dob, name, district) VALUES
(101, '2000-05-10', 'Rahim Uddin', 'Dhaka')
 
 INSERT INTO birth_info (nid, dob, name, district) VALUES
(102, '2000-05-10', 'ashik Uddin', 'Dhaka')

 select * from population;
select * from birth_info;

 

INSERT INTO death_info (nid, date, name) VALUES
(101, '2024-03-15', 'Karim Hossain');

INSERT INTO death_info (nid, date, name) VALUES
(102, '2024-03-15', 'ashik Uddin');
delete from death_info

select * from population;
select * from death_info;

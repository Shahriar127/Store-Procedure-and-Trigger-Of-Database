CREATE TABLE population (
    nid VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    status VARCHAR(10) DEFAULT 'alive'  -- 'alive' or 'dead'
);


CREATE TABLE birth_people (
    nid VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE dead_people (
    nid VARCHAR(20) PRIMARY KEY,
    death_date DATE
);


CREATE OR REPLACE FUNCTION insert_into_population_on_birth()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO population (nid, name, dob, status)
    VALUES (NEW.nid, NEW.name, NEW.dob, 'alive');
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_birth_insert
AFTER INSERT ON birth_people
FOR EACH ROW
EXECUTE FUNCTION insert_into_population_on_birth();


CREATE OR REPLACE FUNCTION mark_dead_in_population()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE population
    SET status = 'dead'
    WHERE nid = NEW.nid;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_death_insert
AFTER INSERT ON dead_people
FOR EACH ROW
EXECUTE FUNCTION mark_dead_in_population();


INSERT INTO birth_people (nid, name, dob)
VALUES ('1234567890', 'Shahriar Jr.', '2025-07-11');

select * from population

INSERT INTO dead_people (nid, death_date)
VALUES ('1234567890', '2080-12-01');

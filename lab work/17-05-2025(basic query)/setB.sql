use lab_17_5_25_basic_query

-- =============================
-- SET-B: Employee Database
-- =============================

-- 1. Creating necessary tables
CREATE TABLE employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT,
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES company(company_name)
);

CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50)
);

-- 2. Inserting sample data
INSERT INTO employee VALUES
('Imran', 'Road 1', 'Dhaka'),
('Nusrat', 'Road 2', 'Rajshahi'),
('Fahim', 'Road 3', 'Rajshahi'),
('Joya', 'Road 4', 'Khulna'),
('Rafiq', 'Road 5', 'Dhaka');

INSERT INTO company VALUES
('Sonali Bank Ltd', 'Dhaka'), ('Agrani Bank', 'Rajshahi'), ('City Bank', 'Khulna');

INSERT INTO works VALUES
('Imran', 'Sonali Bank Ltd', 12000),
('Nusrat', 'Agrani Bank', 11000),
('Fahim', 'Agrani Bank', 9500),
('Joya', 'City Bank', 14000),
('Rafiq', 'Sonali Bank Ltd', 13000);

INSERT INTO manages VALUES
('Imran', 'Karim'), ('Nusrat', 'Hasan'), ('Fahim', 'Hasan');

-- 3. Performing Queries


-- i. Names, street & company name of employees who live in Dhaka
SELECT e.employee_name, e.street, w.company_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE e.city = 'Dhaka';

-- ii. Names of all employees with salary > 10,000 and live in Rajshahi
SELECT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE e.city = 'Rajshahi' AND w.salary > 10000;

-- iii. Names of all employees who earn more than every employee of Sonali Bank Ltd
SELECT DISTINCT w1.employee_name
FROM works w1
WHERE w1.salary > ALL (
    SELECT w2.salary FROM works w2
    WHERE w2.company_name = 'Sonali Bank Ltd'
);

-- iv. Names of all companies with average salary < 15,000
SELECT company_name
FROM works
GROUP BY company_name
HAVING AVG(salary) < 15000;

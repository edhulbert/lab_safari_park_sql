-- safari park

DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS enclosures;

CREATE TABLE enclosures (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    closed_for_maintenance BOOLEAN NOT NULL
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    enclosure_id INT REFERENCES enclosures(id)
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    employee_number INT NOT NULL
);

CREATE TABLE assignments (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id),
    enclosure_id INT REFERENCES enclosures(id),
    day VARCHAR(255)
);

-- INSERT INTO enclosures(name, capacity, closedForMaintenance) VALUES ('GiraffeHouse', 4, TRUE);
-- INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Andy','giraffe', 23, 1);
-- INSERT INTO staff(name, employeeNumber) VALUES ('John', 57);
-- INSERT INTO assignments(employeeId,enclosureId,day) VALUES (1,1,'Wednesday');

INSERT INTO employees (name, employee_number) VALUES ('Colin', 12873);
INSERT INTO employees (name, employee_number) VALUES ('Valeria', 78663);
INSERT INTO employees (name, employee_number) VALUES ('Ben', 98723);
INSERT INTO employees (name, employee_number) VALUES ('Kenny', 67752);
INSERT INTO employees (name, employee_number) VALUES ('Raheela', 77762);
INSERT INTO employees (name, employee_number) VALUES ('Iain', 37845);

INSERT INTO enclosures (name, capacity, closed_for_maintenance) VALUES ('Big Cat Field', 20, FALSE);
INSERT INTO enclosures (name, capacity, closed_for_maintenance) VALUES ('Reptile House', 30, FALSE);
INSERT INTO enclosures (name, capacity, closed_for_maintenance) VALUES ('Petting Zoo', 10, TRUE);
INSERT INTO enclosures (name, capacity, closed_for_maintenance) VALUES ('Bird Cage', 50, FALSE);

INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Leo', 'Lion', 12, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Polly', 'Parrot', 21, 4);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Sid', 'Snake', 3, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Rachel', 'Rabbit', 5, 3);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Charlotte', 'Cheetah', 8, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Tanya', 'Turtle', 5, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Michael', 'Maccaw', 19, 4);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Leah', 'Lion', 10, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Luke', 'Lion', 6, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Phil', 'Penguin', 2, 4);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Graham', 'Guinea Pig', 1, 3);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Nigel', 'Newt', 3, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Naomi', 'Newt', 3, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Harry', 'Hamster', 1, 3);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Terry', 'Tiger', 17, 1);

INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (1, 2, 'Monday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (5, 3, 'Wednesday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (1, 3, 'Thursday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (3, 2, 'Tuesday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (2, 1, 'Monday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (3, 3, 'Friday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (6, 4, 'Tuesday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (5, 2, 'Wednesday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (1, 1, 'Monday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (2, 4, 'Friday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (5, 3, 'Saturday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (1, 2, 'Sunday');

SELECT enclosures.name, employees.name
FROM enclosures
INNER JOIN assignments
ON enclosures.id = assignments.enclosure_id
INNER JOIN employees
ON assignments.employee_id = employees.id
WHERE enclosures.name = 'Big Cat Field';

SELECT enclosures.name, animals.name
FROM enclosures
INNER JOIN animals
ON enclosures.id = animals.enclosure_id
WHERE enclosures.name = 'Bird Cage';

SELECT enclosures.name, enclosures.closed_for_maintenance, employees.name
FROM enclosures
INNER JOIN assignments
ON enclosures.id = assignments.enclosure_id
INNER JOIN employees
ON assignments.employee_id = employees.id
WHERE enclosures.closed_for_maintenance = TRUE;

SELECT enclosures.name, animals.name, MAX(animals.age)
FROM enclosures
INNER JOIN animals
ON enclosures.id = animals.enclosure_id
GROUP BY enclosures.name, animals.name
ORDER BY MAX(animals.age) DESC, animals.name
LIMIT 1;

SELECT employees.name, COUNT (DISTINCT animals.type)
FROM employees
INNER JOIN assignments
ON employees.id = assignments.employee_id
INNER JOIN animals
ON assignments.enclosure_id = animals.enclosure_id
WHERE employees.name = 'Colin'
GROUP BY employees.name;

SELECT enclosures.name, COUNT(DISTINCT employees.name)
FROM enclosures
INNER JOIN assignments
ON enclosures.id = assignments.enclosure_id
INNER JOIN employees
ON assignments.employee_id = employees.id
WHERE enclosures.name = 'Reptile House'
GROUP BY enclosures.name; 

SELECT animals.name
FROM animals
INNER JOIN enclosures
ON animals.enclosure_id = enclosures.id
WHERE enclosures.id IN (SELECT animals.enclosure_id FROM animals WHERE animals.name = 'Terry');

-- safari park

DROP TABLE IF EXISTS assingments;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosures;

CREATE TABLE enclosures (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    closedForMaintenance BOOLEAN NOT NULL
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    enclosure_id INT REFERENCES enclosures(id)
);

CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    employeeNumber INT NOT NULL
);

CREATE TABLE assingments (
    id SERIAL PRIMARY KEY,
    employeeId INT REFERENCES staff(id),
    enclosureId INT REFERENCES enclosures(id),
    day VARCHAR(255)
);

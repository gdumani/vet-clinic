/* Database schema to keep the structure of entire database. */
createdb vet_clinic

CREATE TABLE animals ( id SERIAL PRIMARY KEY, name VARCHAR(20), date_of_birth DATE, escape_attempts int, neutered BOOL, weight_kg DECIMAL(4,2));

ALTER TABLE animals ADD COLUMN species VARCHAR(20);

/*=============================================================*/

CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name VARCHAR(50), age INT);

CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(30));

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT REFERENCES species(id),
ADD COLUMN owner_id INT REFERENCES owners(id);



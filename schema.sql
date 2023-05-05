/* Database schema to keep the structure of entire database. */
createdb vet_clinic

CREATE TABLE animals ( id SERIAL PRIMARY KEY, name VARCHAR(20), date_of_birth DATE, escape_attempts int, neutered BOOL, weight_kg DECIMAL(4,2));

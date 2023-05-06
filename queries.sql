/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/01/01';

SELECT name FROM animals WHERE neutered AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered;

SELECT * FROM animals WHERE NOT name = 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*==========================================================*/

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered,SUM(escape_attempts), AVG(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals 
WHERE DATE_PART('YEAR',date_of_birth) BETWEEN 1990 AND 2000 
GROUP BY species;

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

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022/01/01';
SAVEPOINT sp;
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO sp;
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;
COMMIT;


/*==========================================================*/

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered,SUM(escape_attempts), AVG(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals 
WHERE DATE_PART('YEAR',date_of_birth) BETWEEN 1990 AND 2000 
GROUP BY species;

/*==========================================================*/

SELECT name, owners.full_name as owner FROM animals 
	INNER JOIN owners ON owner_id = owners.id 
	WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name as species FROM animals 
	INNER JOIN species ON species_id = species.id 
	WHERE species.name = 'Pokemon';

SELECT full_name, animals.name from owners LEFT JOIN animals ON owners.id = animals.owner_id; 

SELECT COUNT(*), species.name From animals
	INNER JOIN species ON species_id = species.id 
	GROUP BY species.id;

SELECT animals.name, species.name as species, full_name as owner FROM animals 
        INNER JOIN species ON species_id = species.id
        INNER JOIN owners ON owner_id = owners.id  
	WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name, species.name as species, full_name as owner, escape_attempts FROM animals 
        INNER JOIN species ON species_id = species.id
        INNER JOIN owners ON owner_id = owners.id  
	WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT full_name, count(animals) from owners 
	LEFT JOIN animals ON owners.id = animals.owner_id
	GROUP BY full_name
	ORDER BY count(animals) DESC;


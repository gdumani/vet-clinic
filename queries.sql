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
	
/*==========================================================*/

SELECT vets.name, animals.name, visit_date FROM visits
	INNER JOIN animals ON animals_id = animals.id
	INNER JOIN vets ON vet_id = vets.id
	WHERE vets.name = 'William Tatcher'
	ORDER BY visit_date DESC
	LIMIT 1;

SELECT vets.name, count(DISTINCT animals) FROM visits
        INNER JOIN animals ON animals_id = animals.id
        INNER JOIN vets ON vet_id = vets.id
        WHERE vets.name = 'Stephanie Mendez'
        GROUP BY vets.name;


SELECT vets.name, species.name from vets
        LEFT JOIN specialization ON specialization.vet_id = vets.id
        LEFT JOIN species ON specialization.species_id = species.id;

SELECT animals.name, vets.name, visits.visit_date FROM visits
	INNER JOIN vets ON visits.vet_id = vets.id
	INNER JOIN animals ON visits.animals_id = animals.id
	WHERE vets.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020/04/01' AND '2020/04/30'; 

SELECT animals.name, COUNT(animals.name) AS visit_count FROM visits
	INNER JOIN animals ON visits.animals_id = animals.id
	GROUP BY animals.name ORDER BY visit_count DESC
	LIMIT 1;

SELECT animals.name AS animal, vets.name AS vet, visit_date FROM visits
	INNER JOIN vets ON visits.vet_id = vets.id
	INNER JOIN animals ON visits.animals_id = animals.id
	WHERE vets.name = 'Maisy Smith'
	ORDER BY visit_date ASC LIMIT 1;

SELECT animals.name AS animal, vets.name AS vet, visit_date FROM visits
	INNER JOIN vets ON visits.vet_id = vets.id
	INNER JOIN animals ON visits.animals_id = animals.id
	ORDER BY visit_date DESC LIMIT 1;

SELECT count(*) from visits 
	INNER JOIN vets ON visits.vet_id = vets.id
	INNER JOIN animals ON visits.animals_id = animals.id
	WHERE animals.species_id NOT IN 
		(SELECT species_id FROM specialization WHERE vet_id = visits.vet_id);

SELECT species.name, COUNT(species.name) from visits 
	INNER JOIN vets ON visits.vet_id = vets.id
	INNER JOIN animals ON visits.animals_id = animals.id
	INNER JOIN species ON animals.species_id = species.id
	WHERE vets.name = 'Maisy Smith'
	GROUP BY species.name;


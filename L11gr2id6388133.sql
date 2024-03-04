USE MovieTesting;

-- Q1
SELECT title, runtime
FROM movies
WHERE runtime > '02:00:00';
-- Finish

-- Q2
SELECT m.actor_id, a.name
FROM actors a
JOIN movie_cast m ON a.actor_id = m.actor_id
JOIN movies mm ON m.movie_id = mm.movie_id
WHERE character_name = 'Jenny Curran' AND title = 'Forrest Gump';
-- Finish

-- Q3
SELECT movie_id, title, release_date
FROM movies
WHERE YEAR(release_date) < '2009';
-- Finish

-- Q4
SELECT AVG(YEAR(CURDATE()) - YEAR(birthdate)) AS average_age
FROM actors;
-- Finish

-- Q5
SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(runtime))) AS average_runtime
FROM movies;
-- Finish

-- Q6.1
CREATE TABLE Q1 (
	userId 		char(36), 
	firstName 	nvarchar(20), 
	lastName 	nvarchar(20)
);
-- Finish
DROP TABLE Q1;
-- Q6.2
INSERT INTO Q1 (userId, firstName, lastName) VALUES
(UUID_SHORT(), 'Pitchaya', 'Teerawongpairoj'),
(UUID_SHORT(), 'Ariya', 'Phengphon');
-- Finish

-- Q6.3
SELECT  CONCAT(firstname, ' ' ,lastname) AS fullname
FROM Q1;
-- Finish

-- Q6.4
CREATE TABLE Q2 (
	Uname 	nvarchar(32), 
	Upass	binary(64)
);
-- Finish
DROP TABLE Q2;
-- Q6.5
INSERT INTO Q2 (Uname, Upass) VALUES
('6388133', MD5(123456));
-- Finish
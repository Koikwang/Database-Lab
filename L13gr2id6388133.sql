USE TestTrigger;

select * from person;
select * from project;

-- Q1.1
CREATE TABLE LogFileAudit(
	LogID		VARCHAR(225) 	PRIMARY KEY,
    Action		VARCHAR(225)	NOT NULL,
    TableName	VARCHAR(225)	NOT NULL
 );
 
-- Q1.2
DROP TRIGGER `addLogINS`;
DELIMITER \\
CREATE TRIGGER `addLogINS`
AFTER INSERT ON Person
FOR EACH ROW
BEGIN
	DECLARE Log_ID		VARCHAR(225);
    DECLARE Action		VARCHAR(225);
    DECLARE TableName	VARCHAR(225);
		SET Log_ID 		= (SELECT MAX(LogID) FROM LogFileAudit);
        SET Action		= 'INSERT';
        SET TableName	= 'person';
	IF Log_ID IS NULL THEN
		SET Log_ID = 1;
	ELSE
		SET Log_ID = Log_ID + 1;
	END IF;
    INSERT INTO LogFileAudit VALUES (Log_ID, Action, TableName);
END; \\
DELIMITER ;

INSERT INTO Person (pid, full_name, budget, proj_id) VALUES ('011','Sarah Mogan', 1000.00, 4);

SELECT * FROM LogFileAudit;

-- Q1.3
DROP TRIGGER `addLogDEL`;
DELIMITER \\
CREATE TRIGGER `addLogDEL`
AFTER DELETE ON project
FOR EACH ROW
BEGIN
	DECLARE Log_ID		VARCHAR(225);
    DECLARE Action		VARCHAR(225);
    DECLARE TableName	VARCHAR(225);
		SET Log_ID 		= (SELECT MAX(LogID) FROM LogFileAudit);
        SET Action		= 'DELETE';
        SET TableName	= 'project';
	IF Log_ID IS NULL THEN
		SET Log_ID = 1;
	ELSE
		SET Log_ID = Log_ID + 1;
	END IF;
    INSERT INTO LogFileAudit VALUES (Log_ID, Action, TableName);
END; \\
DELIMITER ;

DELETE FROM project WHERE proj_id = '1';

-- Q2
DROP TRIGGER `cascade_insert`;
DELIMITER \\
CREATE TRIGGER `cascade_insert`
AFTER INSERT ON person
FOR EACH ROW
BEGIN
	DECLARE project_ID 		VARCHAR(4);
    DECLARE project_name 	VARCHAR(225);
    DECLARE total_budget 	VARCHAR(225);
		SET project_ID		= NEW.proj_id;
		SET project_name 	= 'Unknown';
        SET total_budget	= NEW.budget;
	INSERT INTO project VALUES (project_ID, project_name,total_budget);
END; \\
DELIMITER ;

INSERT INTO person (pid, full_name, budget, proj_id) VALUES ('012','Harry Potter', 15000, 5);
CREATE DATABASE Transactions;

USE Transactions;
CREATE TABLE accounts ( 
  acc_id INT,
  acc_name varchar(255),
  acc_balance DECIMAL(10,2),
  PRIMARY KEY(acc_id) 
) ENGINE InnoDB; 

INSERT INTO accounts (acc_id, acc_name, acc_balance)
VALUES (1, 'John Smith', 1000.00),
       (2, 'Jane Doe', 5000.00),
       (3, 'Bob Johnson', 2500.00),
       (4, 'Sarah Lee', 15000.00),
       (5, 'Alex Kim', 7500.00);
SELECT * FROM accounts;

USE Transactions;
BEGIN;
	SELECT acc_balance FROM accounts
	WHERE acc_id=1 FOR UPDATE;
	UPDATE accounts
	SET acc_balance=acc_balance+500
	WHERE acc_id=1;
COMMIT; 

-- Q0
CREATE TABLE BankAccount (
	AccountNum 		INT NOT NULL PRIMARY KEY,
	ACC_ID 			INT NOT NULL,
	AccountBalance	DECIMAL(10,2),
	FOREIGN KEY (ACC_ID) REFERENCES accounts(acc_id)
);

-- Q1
DROP PROCEDURE AddAccounts;
DELIMITER //
CREATE PROCEDURE `AddAccounts`()
BEGIN
	IF EXISTS(SELECT * FROM BankAccount) THEN
		ROLLBACK;
        SELECT 'ERROR';
	ELSE 
		INSERT INTO BankAccount
		VALUES 
			(117, 1, 1000),
			(118, 2, 2000),
			(119, 3, 500);
		COMMIT;
    END IF;
END; //
DELIMITER ;

CALL AddAccounts();

SELECT * FROM BankAccount;  

-- Q2
DROP PROCEDURE TransferMoney;
DELIMITER //
CREATE PROCEDURE `TransferMoney`()
BEGIN
	SET @from = 117;
	SET @to = 118;
	SET @amount = 550;
    START TRANSACTION;
		IF EXISTS(SELECT * FROM BankAccount WHERE AccountNum = @from AND AccountBalance >= @amount) THEN
			UPDATE BankAccount
			SET AccountBalance = AccountBalance + 550
			WHERE AccountNum = @to; 
			UPDATE BankAccount SET AccountBalance = AccountBalance - 550 WHERE AccountNum = @from;
			COMMIT;
            SELECT 'SUCCESSFULLY TRANSFERRED';
		ELSE 
			ROLLBACK;
            SELECT 'INSUFFICIENT BALANCE';
		END IF;
END; //
DELIMITER ;

CALL TransferMoney();

SELECT * FROM  BankAccount; 
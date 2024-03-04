USE premierproducts;

-- Q1
DELIMITER //
CREATE PROCEDURE `sp_Customer_Order`(IN Order_Date DATE, IN Min_Ordered INT)
BEGIN
	SELECT o.OrderNum, o.OrderDate, SUM(c2.NumOrdered) AS TotalOrders,
		(SELECT SUM(c1.QuotedPrice*c1.NumOrdered) AS TotalPrice
		FROM currentorders c1
        WHERE c2.OrderNum = c1.OrderNum
		GROUP BY o.OrderNum) AS TotalPrice, o.CustomerNum
	FROM orders o
	JOIN currentorders c2 ON o.OrderNum = c2.OrderNum
    WHERE DATE(OrderDate) = Order_Date
	GROUP BY o.OrderNum
	HAVING TotalOrders >= Min_Ordered;
END 
// DELIMITER ;

DROP PROCEDURE sp_Customer_Order;

CALL sp_Customer_Order('2010-10-21',1);

-- Q2 
DELIMITER //
CREATE PROCEDURE `sp_Orders_By_Customer`(IN Customer_num INT)
BEGIN
	SELECT o.OrderNum, o.OrderDate, SUM(c2.NumOrdered) AS TotalPartsOrders,
		(SELECT SUM(c1.QuotedPrice*c1.NumOrdered) AS TotalPrice
		FROM currentorders c1
        WHERE c2.OrderNum = c1.OrderNum
		GROUP BY o.OrderNum) AS TotalPrice
	FROM orders o
	JOIN currentorders c2 ON o.OrderNum = c2.OrderNum
    WHERE CustomerNum = Customer_num
	GROUP BY o.OrderNum;
END 
// DELIMITER ;

DROP PROCEDURE sp_Orders_By_Customer;

CALL sp_Orders_By_Customer(148);

DROP FUNCTION update_rep;
-- Q3
DELIMITER //
CREATE FUNCTION update_rep(old_rep_num INT, new_rep_num INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE resultValue INT;
    IF EXISTS(SELECT * FROM rep WHERE RepNum = old_rep_num) THEN
		SET resultValue = 1;
        SET foreign_key_checks = 0;
        UPDATE rep
			SET RepNum = new_rep_num
			WHERE RepNum = old_rep_num;
		SET foreign_key_checks = 1;
        UPDATE customer
			SET RepNum = new_rep_num
			WHERE RepNum = old_rep_num;
		SET foreign_key_checks = 1;
        UPDATE currentorders
			SET RepNum = new_rep_num
			WHERE RepNum = old_rep_num;
		SET foreign_key_checks = 1;
      ELSE      
		SET resultValue = 0;
	END IF;
	RETURN resultValue;
END;
// DELIMITER ;

SELECT update_rep(20,999);
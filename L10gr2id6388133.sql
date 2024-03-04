USE PremierProducts;
DROP VIEW vwCustomerRep;

-- Q1
CREATE VIEW vwCustomerRep AS 
SELECT c.CustomerNum, c.CustomerName, c.Zip, FirstName AS RepFName, LastName AS RepLName
FROM Customer c
JOIN Rep r ON c.RepNum = r.RepNum
ORDER BY CustomerNum;

SELECT * FROM vwCustomerRep;

-- Q2 
ALTER VIEW vwCustomerRep AS 
SELECT c.CustomerNum, c.CustomerName, c.Zip, FirstName AS RepFName, LastName AS RepLName, Commision, Rate
FROM Customer c
JOIN Rep r ON c.RepNum = r.RepNum
ORDER BY CustomerNum;

SELECT * FROM vwCustomerRep;

DROP VIEW vwTotalOrder_Customer;

-- Q3
CREATE VIEW vwTotalOrder_Customer AS
SELECT c.CustomerNum, c.CustomerName, COUNT(o.OrderNum) AS totalOrders
FROM Orders o
JOIN Customer c ON o.CustomerNum = c.CustomerNum
GROUP BY CustomerName
ORDER BY CustomerNum; 

SELECT * FROM vwTotalOrder_Customer;
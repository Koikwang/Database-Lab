/* ---------------------------------------------- 
|	Student ID: 6388133							|
|	Name: Pitchaya Teerawongpairoj				|
   ---------------------------------------------*/

USE classicmodels;

-- Q1: Find the total numbers of quantity ordered per product line for the complete order, 
-- sorted the results from the highest numbers to the lowest ones. 
-- Note: the complete order is considered from the order with the status 'Shipped'.
SELECT p.productLine, SUM(o.quantityOrdered) AS QuantityOrdered
FROM products p 
JOIN orderdetails o ON p.productCode = o.productCode
RIGHT JOIN orders s ON o.orderNumber = s.orderNumber
WHERE status LIKE '%Shipped%'
GROUP BY p.productLine
ORDER BY QuantityOrdered DESC;
-- Finish

-- Q2: Calculate the amount of loss (cancelled) values per product of the 'Ships' product line for all 'Cancelled' orders. 
-- Note: the amount of values is calculated from the quantity ordered multiplied by its price)
SELECT p.productCode, p.productName, SUM(o.quantityOrdered*o.priceEach) AS 'Amount Of Cancelled Values'
FROM products p 
INNER JOIN orderdetails o ON p.productCode = o.productCode
INNER JOIN orders s ON o.orderNumber = s.orderNumber
WHERE p.productLine LIKE '%Ship%' AND status LIKE '%Cancelled%'
GROUP BY p.productName
ORDER BY p.productCode;
-- Finish

-- Q3: List the products (code and name) that have never been sold
SELECT p.productCode, p.productName
FROM products p  
LEFT JOIN orderdetails o ON p.productCode = o.productCode
WHERE o.orderNumber IS NULL;
-- Finish

-- Q4: List the customers who made the orders with the product line 'Classic Cars' more than 3 times in total, 
-- sorted the result by the number of times from the highest values to the lowest ones.
-- Hint: the number of times they ordered can be counted from the unique order numbers
SELECT c.customerName, COUNT(DISTINCT(o.orderNumber)) AS timesOrders
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails s ON o.orderNumber = s.orderNumber
INNER JOIN products p ON s.productCode = p.productCode
WHERE productLine LIKE '%Classic Cars%'
GROUP BY c.customerName
HAVING timesOrders > 3
ORDER BY timesOrders DESC;
-- Finish

-- Q5: List the top 3 customers outside USA and their payment statistics (the total number of payment checks, 
-- the total amount of payments, and the average amount of payments)
SELECT c.customerName, c.country, COUNT(checkNumber) AS TotlaNumCheck, SUM(amount) AS TotalAmtPaid, AVG(amount) AS AvgPaid
FROM customers c
INNER JOIN payments p ON c.customerNumber=p.customerNumber
WHERE country != 'USA'
GROUP BY c.customerName 
ORDER BY TotlaNumCheck DESC
LIMIT 3;
-- Finish

-- Q6: List the German customers who made the orders not more than 3 times in total, 
-- sorted the result by the customer's name alphabetically.
SELECT customerName, COUNT(o.orderNumber) AS numOrders
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE c.country LIKE '%Germany%'
GROUP BY customerName
HAVING COUNT(o.orderNumber) <= 3
ORDER BY customerName;
-- Finish

-- Q7: List the locations of US customers (city, state) of the employee and 
-- their corresponding sale representatives’ office location (city, state)
SELECT DISTINCT CONCAT(c.city, ' ', c.state) AS "Customer's Location", CONCAT(o.city, ' ', o.state) AS "Sale Rep's Location"
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
WHERE c.country = 'USA' AND o.country = 'USA'
ORDER BY `Customer's Location`;
-- Finish

-- Q8: List all combinations of the 'sales representative employees who work in USA office and all US customers
-- Hint: There are 36 US customers and 6 sales representatives located in USA
SELECT CONCAT(e.firstName, ' ', e.lastName) AS SalesRep, CONCAT(o.city, ' ', o.state) AS SalesLocation, c.customerName, CONCAT(c.city, ' ', c.country) AS CustomerLocation
FROM customers c 
CROSS JOIN employees e 
JOIN offices o ON e.officeCode = o.officeCode
WHERE o.country LIKE '%USA%' AND c.country = 'USA' AND e.jobTitle LIKE '%Sales Rep%'
LIMIT 1000;









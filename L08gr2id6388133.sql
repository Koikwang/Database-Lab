/* ---------------------------------------------- 
|	Student ID: 6388133							|
|	Name: Pitchaya Teerawongpairoj				|
   ---------------------------------------------*/

USE classicmodels;


-- Q1: List the product code and product name of the product line "Planes" and their total quantity of ordered
-- using subquery without JOIN
SELECT productCode, productName,
	(SELECT SUM(quantityOrdered)
    FROM orderdetails o
    WHERE o.productCode = p.productCode) AS TotalQuantityOrdered
FROM products p
WHERE productLine = 'Planes'
ORDER BY TotalQuantityOrdered DESC;
-- Finish

-- Q2: List the customer info. (number, name, and number of times they made the orders) 
-- who order more frequent than the average.
-- Hint: On average, the number of times the customers ordered is 3.3265.
SELECT customerNumber, customerName,
	(SELECT COUNT(orderNumber)
		FROM orders o
		WHERE o.customerNumber = c.customerNumber) AS TotalNumOrder 
FROM customers c
HAVING TotalNumOrder > 
	(SELECT AVG(numOrder)
		FROM (SELECT COUNT(orderNumber) AS numOrder 
				FROM orders 
				GROUP BY customerNumber) avgCusOrder)
ORDER BY TotalNumOrder DESC;
-- Finish

-- Q3: If the company wants to have another new office to serve the customers, 
-- what country should be the next destination?
-- Hint: The location of the new office should be defined based on the highest numbers of customers of the
-- country and should not duplicate with the current location
-- ANS: Germany
SELECT country
FROM (SELECT DISTINCT COUNT(country) AS countCountry , country
	FROM customers
    WHERE country NOT IN (SELECT DISTINCT(country) FROM offices)
    GROUP BY country
    ORDER BY countCountry DESC LIMIT 1) o;
-- Finish

-- Q4: Using EXISTS, find the list of the employees, who work at the offices in the territory "EMEA", 
-- and their total number of customers if any
SELECT CONCAT(e.firstName, ' ' , e.lastName) AS 'Name', e.jobTitle,
	(SELECT COUNT(customerNumber) 
    FROM customers c
    WHERE c.salesRepEmployeeNumber = e.employeeNumber) AS TotalNumPeople
FROM employees e
WHERE EXISTS 
	(SELECT DISTINCT officeCode 
	FROM offices o
    WHERE territory = 'EMEA' AND e.officeCode = o.officeCode);
-- Finish

-- Q5: Modify Q4 to show the number of people each the same 'EMEA' employees needed to take care of
-- Hint: For all employees who have customers, calculate the total number of customers, and for ones who do not
-- have customers, show the total number of employees under his/her supervision
SELECT DISTINCT CONCAT(e.firstName, ' ' , e.lastName) AS 'Name', e.jobTitle,
	(SELECT COUNT(employeeNumber) 
    FROM employees e1
    WHERE e.employeeNumber = e1.reportsTo) AS TotalNumPeople
FROM employees e
WHERE EXISTS 
	(SELECT DISTINCT officeCode 
	FROM offices o
    WHERE territory = 'EMEA' AND e.officeCode = o.officeCode)
    AND jobTitle LIKE '%Sale Manager%'
    
UNION 
SELECT DISTINCT CONCAT(e.firstName, ' ' , e.lastName) AS 'Name', e.jobTitle,
	(SELECT COUNT(customerNumber) 
    FROM customers c
    WHERE c.salesRepEmployeeNumber = e.employeeNumber) AS TotalNumPeople
FROM employees e
WHERE EXISTS 
	(SELECT DISTINCT officeCode 
	FROM offices o
    WHERE territory = 'EMEA' AND e.officeCode = o.officeCode)
    AND jobTitle NOT LIKE '%Manager%';

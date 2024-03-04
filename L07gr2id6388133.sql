/* ---------------------------------------------- 
|	Student ID: 6388133							|
|	Name: Pitchaya Teerawongpairoj				|
   ---------------------------------------------*/

USE classicmodels;
-- Q1: Find the list of products that are sold to customers in Japan only (Not to Singaporian Customers)
-- ANS of Q1:   28 products 
SELECT DISTINCT p.productCode, p.productName -- , c.country
FROM customers c
INNER JOIN orders d ON c.customerNumber = d.customerNumber
INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
INNER JOIN products p ON o.productCode = p.productCode
WHERE country ='Japan' AND p.productCode NOT IN
	( SELECT DISTINCT p.productCode
	FROM customers c
	INNER JOIN orders d ON c.customerNumber = d.customerNumber
	INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
	INNER JOIN products p ON o.productCode = p.productCode
	WHERE country ='Singapore')
ORDER BY p.productCode;
-- Finish

-- Q2: Find the list of products that are sold to customers in Singapore only (Not to Japanese customers
-- ANS of Q2:   35 products 
SELECT DISTINCT p.productCode, p.productName -- , c.country
FROM customers c
INNER JOIN orders d ON c.customerNumber = d.customerNumber
INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
INNER JOIN products p ON o.productCode = p.productCode
WHERE country ='Singapore' AND p.productCode NOT IN
	( SELECT DISTINCT p.productCode
	FROM customers c
	INNER JOIN orders d ON c.customerNumber = d.customerNumber
	INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
	INNER JOIN products p ON o.productCode = p.productCode
	WHERE country ='Japan')
ORDER BY p.productCode;
-- Finish

-- Q3: Find the list of products that are sold to both customers in Japan and Singapore
-- ANS of Q3:   17 products 
SELECT DISTINCT p.productCode, p.productName -- , c.country
FROM customers c
INNER JOIN orders d ON c.customerNumber = d.customerNumber
INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
INNER JOIN products p ON o.productCode = p.productCode
WHERE country ='Japan' AND p.productCode  IN
	( SELECT DISTINCT p.productCode
	FROM customers c
	INNER JOIN orders d ON c.customerNumber = d.customerNumber
	INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
	INNER JOIN products p ON o.productCode = p.productCode
	WHERE country ='Singapore')
ORDER BY p.productCode;
-- Finish

-- Q4: How many of products in total that are sold to customers in Japan and Singapore? 
-- ANS of Q4:   80 products 
SELECT DISTINCT p.productCode , p.productName -- , c.country
FROM customers c
INNER JOIN orders d ON c.customerNumber = d.customerNumber
INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
INNER JOIN products p ON o.productCode = p.productCode
WHERE country ='Japan'
UNION
SELECT DISTINCT p.productCode , p.productName -- , c.country
FROM customers c
INNER JOIN orders d ON c.customerNumber = d.customerNumber
INNER JOIN orderdetails o ON d.orderNumber = o.orderNumber
INNER JOIN products p ON o.productCode = p.productCode
WHERE country ='Singapore';
-- Finish


-- Q5: List all contact names and phone numbers of both customers and the employess in one result
(SELECT CONCAT(contactFirstName,' ' ,contactLastname) AS `Contact Name`, phone
FROM customers)
UNION ALL
SELECT CONCAT(firstName,' ',lastName) AS `Contact Name`, o.phone
FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode
ORDER BY `Contact Name` ASC;
-- Finish

-- Q6: Select top 3 of the most sold product (judged by the total numbers of quantity ordered) in 
-- the following product lines: Motorcycles, Classic Cars, and Vintage Cars respectively.
(SELECT p.productCode, p.productName, p.productLine, SUM(o.quantityOrdered) AS 'totalQuantityOrdered'
FROM products p
JOIN orderdetails o ON p.productCode = o.productCode
WHERE productLine='Motorcycles'
GROUP BY productCode
ORDER BY `totalQuantityOrdered` DESC
LIMIT 3)
UNION
(SELECT p.productCode, p.productName, p.productLine, SUM(o.quantityOrdered) AS 'totalQuantityOrdered'
FROM products p
JOIN orderdetails o ON p.productCode = o.productCode
WHERE productLine='Classic Cars' 
GROUP BY productCode
ORDER BY `totalQuantityOrdered` DESC
LIMIT 3)
UNION
(SELECT p.productCode, p.productName, p.productLine, SUM(o.quantityOrdered) AS 'totalQuantityOrdered'
FROM products p
JOIN orderdetails o ON p.productCode = o.productCode
WHERE productLine='Vintage Cars'
GROUP BY productCode
ORDER BY `totalQuantityOrdered` DESC
LIMIT 3);
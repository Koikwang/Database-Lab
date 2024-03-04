/* ---------------------------------------------- 
|	Student ID: 6388133							|
|	Name: Pitchaya Teerawongpairoj				|
   ---------------------------------------------*/

USE classicmodels;

-- Q1: How many customers are located in NYC?
SELECT COUNT(city) AS NumberOfCustomersInNYC
FROM customers
WHERE city LIKE 'NYC';
-- FINISH

-- Q2: What is the average amount of the payment and the standard deviation of 
-- the payments occurred in the third quarter of the year?
-- Note: Third quarter of every year is from 1 July – 30 September
SELECT ROUND(AVG(amount),2) AS averageAmount, FORMAT(STDDEV(amount),2) AS standardDeviation 
FROM payments
WHERE QUARTER(paymentDate)=3;
-- FINISH

-- Q3: How many limited company customers that are under the responsibility of 
-- the sale representative named, 'Leslie Jennings'
-- Note: 'Ltd.' used in the name of a company indicates a limited company
-- SELECT CONCAT(e.firstName,' ', e.lastName) AS 'Full Name', COUNT(e.firstName), COUNT(e.lastName)
SELECT COUNT(e.firstName) AS NumLtdComp
FROM employees e
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerName LIKE '%Ltd%' AND e.firstName = 'Leslie' AND e.lastName = 'Jennings';
-- FINISH

-- Q4: Show the number of offices located in each country, ordered by country names
SELECT country , COUNT(officeCode) AS numOffices
FROM offices
GROUP BY country 
ORDER BY country ASC;
-- FINISH

-- Q5: List all sale managers (employee number, full name, job title) 
--      and their subordinate sale representatives under their supervision.
-- Note: The attribute 'reportsTo' shows the recursive relationship. 
-- The value indicates the employee number of their manager that he/she reports to.
SELECT e.employeeNumber, CONCAT(e.firstName,' ', e.lastName) AS 'Full Name', e.jobTitle, COUNT(a.employeeNumber)
FROM employees e
INNER JOIN employees a ON e.employeeNumber = a.reportsTo
WHERE e.jobTitle LIKE '%Manager%'
GROUP BY e.jobTitle;
-- FINISH

-- Q6: Calculate the average of the price difference between 'MSRP' and 'buyPrice' of each product line
-- The result must include the name of the product line and its average difference price, sorted from the highest to lowest difference value.
SELECT productLine, ROUND(AVG(MSRP - buyPrice),2) AS avgDiff
FROM products
GROUP BY productLine
ORDER BY avgDiff DESC;
-- FINISH

-- Q7: Show the list of the product lines that have the number of the products at least 10 but not more than 20 products. 
-- The result must include the name of the product line, the total numbers of the products and the range of MSRP per product line,
-- sorted by the name of product line
-- Note: The range of MSRP is calculated from the difference of the maximum and the minimum MSRP value
SELECT productLine, COUNT(productLine) AS numProd, MAX(MSRP) - MIN(MSRP) AS rangeMSRP
FROM products 
GROUP BY productLine
HAVING COUNT(productLine) > 10 AND COUNT(productLine) <= 20;
-- Finish

-- Q8: Show the top 3 most sold product (judged by the total number of quantity ordered) of the 'Ships' product line.
-- The result must include the product code, the product name, the total number of quantity ordered and the total amount of sales
-- (calculated by the quantity ordered multiplied by the price)
SELECT p.productCode, p.productName, SUM(o.quantityOrdered) as totalQuantity, SUM(o.quantityOrdered* o.priceEach) as totalSales
FROM products p 
INNER JOIN orderdetails o ON p.productCode = o.productCode
WHERE p.productLine LIKE '%Ship%'
GROUP BY productCode
ORDER BY totalQuantity DESC
LIMIT 3;
-- Finish








-- 1 
-- Return orders placed in June 2015
SELECT orderid,
	   orderdate,
	   custid,
	   empid
FROM Sales.Orders
	WHERE orderdate >= '20150601' and orderdate <= '20150630'

-- Return orders placed on the last day of the month
-- Tables involved: Sales.Orders table

SELECT orderid,
	   orderdate,
	   custid,
	   empid
FROM Sales.Orders
	WHERE orderdate = EOMONTH(orderdate)

-- Return employees with last name containing the letter 'e' twice or more
-- Tables involved: HR.Employees table
SELECT empID,
	   firstName,
	   LastName
FROM HR.Employees
	WHERE LastName LIKE '%e%e%'

SELECT empid, firstname, LastName
FROM HR.Employees
	WHERE LEN(LastName) - LEN(REPLACE(LastName, 'e', '') ) >= 2

-- 4 
-- Return orders with total value(qty*unitprice) greater than 10000
-- sorted by total value
-- Tables involved: Sales.OrderDetails table
SELECT orderid, SUM(qty * unitPrice)
FROM Sales.OrderDetails
	GROUP BY orderid 
	having SUM(qty * unitPrice) > 10000


-- 5
-- Write a query against the HR.Employees table that returns employees
-- with a last name that starts with a lower case letter.
-- Remember that the collation of the sample database
-- is case insensitive (Latin1_General_CI_AS).
-- For simplicity, you can assume that only English letters are used
-- in the employee last names.
-- Tables involved: Sales.OrderDetails table

select empid, LastName 
from HR.Employees (NOLOCK)
where Lastname COLLATE Latin1_General_CS_AS LIKE '[a-z]'

-- Return the three ship countries with the highest average freight for orders placed in 2015
-- Tables involved: Sales.Orders table
SELECT TOP 3 shipcountry, AVG(freight) avgFreight
FROM Sales.Orders
	WHERE orderdate BETWEEN '20150101' AND '20151231'
GROUP BY shipcountry
		ORDER BY avgFreight DESC

-- Calculate row numbers for orders
-- based on order date ordering (using order id as tiebreaker)
-- for each customer separately
-- Tables involved: Sales.Orders table
SELECT custid, orderdate , orderid ,
ROW_NUMBER() OVER ( PARTITION BY custid order by orderdate) rnum
FROM Sales.Orders

-- 9
-- Figure out and return for each employee the gender based on the title of courtesy
-- Ms., Mrs. - Female, Mr. - Male, Dr. - Unknown
-- Tables involved: HR.Employees table

SELECT empid, 
	   firstname, 
	   lastname, 
	   titleofcourtesy, 
	   CASE WHEN titleOfCourtesy IN ( 'Ms.', 'Mrs.') THEN 'Female'
		    WHEN titleOfCourtesy = 'Mr.' THEN 'Male'
			WHEN titleOfCourtesy = 'Dr.' THEN 'Unknown' END Gender
FROM HR.Employees (NOLOCK)

-- Return for each customer the customer ID and region
-- sort the rows in the output by region
-- having NULLs sort last (after non-NULL values)
-- Note that the default in T-SQL is that NULLs sort first
-- Tables involved: Sales.Customers table
SELECT custid , Region 
FROM Sales.Customers
	ORDER BY CASE WHEN region IS NULL then 'ZZ' ELSE region END 
	
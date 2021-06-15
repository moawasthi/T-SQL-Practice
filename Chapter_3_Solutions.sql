-- 1-1
-- Write a query that generates 5 copies out of each employee row
-- Tables involved: TSQLV4 database, Employees and Nums tables

SELECT empid, firstname, lastname, n
FROM HR.Employees
CROSS JOIN dbo.Nums
where n <=5


-- 1-2 (Optional, Advanced)
-- Write a query that returns a row for each employee and day 
-- in the range June 12, 2016 – June 16 2016.
-- Tables involved: TSQLV4 database, Employees and Nums tables

SELECT empid, firstname, lastname, DATEADD(dd, n- 1, '2016-06-12')
FROM HR.Employees
CROSS JOIN dbo.Nums
where n <=5

-- 3
-- Return US customers, and for each customer the total number of orders 
-- and total quantities.
-- Tables involved: TSQLV4 database, Customers, Orders and OrderDetails tables
SELECT c.custid , COUNT( distinct o.orderid) numorders, SUM(od.qty) totalqty
from Sales.Customers c
	INNER JOIN Sales.Orders o 
		ON c.custid = o.custid
	INNER JOIN Sales.OrderDetails od
		ON od.orderid = o.orderid
		WHERE c.country = 'USA'
GROUP BY c.custid, country

-- 4
-- Return customers and their orders including customers who placed no orders
-- Tables involved: TSQLV4 database, Customers and Orders tables

SELECT cus.custid, cus.companyName, ord.orderid, ord.orderdate FROM Sales.Customers cus
LEFT JOIN  Sales.Orders ord 
	on cus.custid = ord.custid


-- 5
-- Return customers who placed no orders
-- Tables involved: TSQLV4 database, Customers and Orders tables

SELECT cus.custid, cus.companyName, ord.orderid, ord.orderdate FROM Sales.Customers cus
LEFT JOIN  Sales.Orders ord 
	on cus.custid = ord.custid
	WHERE ord.Orderid IS NULL

-- Return customers with orders placed on Feb 12, 2016 along with their orders
-- Tables involved: TSQLV4 database, Customers and Orders tables
SELECT cus.custid, cus.companyName, ord.orderid, ord.orderdate FROM Sales.Customers cus
INNER JOIN  Sales.Orders ord 
	on cus.custid = ord.custid
	WHERE ord.Orderdate = '20160212'

-- Write a query that returns all customers in the output, but matches
-- them with their respective orders only if they were placed on February 12, 2016
-- Tables involved: TSQLV4 database, Customers and Orders tables

SELECT cus.custid, cus.companyName, ord.orderid, CASE WHEN ord.orderdate = '2016-02-12' THEN ord.orderdate ELSE NULL END as orderdate FROM Sales.Customers cus
LEFT JOIN  Sales.Orders ord 
	on cus.custid = ord.custid

-- Return all customers, and for each return a Yes/No value
-- depending on whether the customer placed an order on Feb 12, 2016
-- Tables involved: TSQLV4 database, Customers and Orders tables

SELECT cus.custid, cus.companyName, ord.orderid, CASE WHEN ord.orderdate = '2016-02-12' THEN 'Yes' ELSE 'No' END as orderdate FROM Sales.Customers cus
LEFT JOIN  Sales.Orders ord 
	on cus.custid = ord.custid



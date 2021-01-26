-- returns orders placed in June 2015

SELECT orderid, 
	   orderdate,
	   custid,
	   empid
FROM Sales.Orders (NOLOCK)
	WHERE orderdate >= '2015-06-01' AND orderdate <='2015-06-30'

-- returns orders placed on last date of the month
SELECT orderid,
	   orderdate, 
	   custid, 
	   empid
FROM Sales.Orders (NOLOCK)
	WHERE orderdate = EOMONTH(orderdate)

-- last name containing letter E twice or more
SELECT empid, 
	   firstname, 
	   lastname
FROM HR.Employees (NOLOCK)
	WHERE lastname like '%e%e%'

-- qty * unitprice > 10000 order by totalvalue
SELECT orderid, 
	   SUM(qty * unitprice) totalvalue
FROM Sales.OrderDetails (NOLOCK)
	GROUP BY orderid
		HAVING SUM(qty * unitprice) > 10000
order by totalvalue

--  three shippedto countries having highest average freight in 2015
SELECT  shipcountry, AVG(freight) avgfreight
FROM Sales.Orders (NOLOCK)
	WHERE orderdate BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY shipcountry
order by avgfreight desc OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY

-- row numbers for orders based on orderdate (using orderid as tiebreaker) ordering for each customer separately
SELECT custid, 
	   orderdate, 
	   orderid, 
	   ROW_NUMBER() OVER( PARTITION BY custid ORDER BY orderdate, orderid) rnum
FROM Sales.Orders (NOLOCK)

-- return for each employee the gender based on title of  courtesy. for ms, mrs return female, for Mr. return male.
--for other cases return unknown
SELECT empid, 
	   firstname, 
	   lastname, 
	   titleofcourtesy, 
	   CASE WHEN titleofcourtesy IN ( 'mrs.', 'ms.') THEN 'Female'
			WHEN titleofcourtesy IN ( 'mr.') THEN 'Male'
			ELSE 'Unknown' END
FROM HR.Employees (NOLOCK)

-- Sales.Customers custid and region, sort nulls at last

SELECT custid, region
FROM Sales.Customers (NOLOCK)
	ORDER BY CASE WHEN region IS NULL THEN 'Z'  ELSE region END
	

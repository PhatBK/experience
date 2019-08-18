USE AdventureWorks2008;

/*Phan 1 - cau 1*/
SELECT P.*
FROM Production.Product AS P, 
	Production.ProductCategory AS C, 
	Production.ProductSubcategory AS S,
	Sales.SalesOrderHeader AS H,
	Sales.SalesOrderDetail AS D,
	Person.Address AS A
WHERE P.ProductSubcategoryID = S.ProductSubcategoryID
	AND S.ProductCategoryID = C.ProductCategoryID
	AND C.Name = 'Clothing'
	AND H.SalesOrderID = D.SalesOrderID
	AND D.ProductID = P.ProductID
	AND MONTH(H.ShipDate) = 5
	AND YEAR(H.ShipDate) = 2003
	AND H.ShipToAddressID = A.AddressID
	AND A.City = 'London'

/*Lenh tao index*/
CREATE INDEX c_name ON Production.ProductCategory(Name);
/*Tuong tu voi cac truong khac da duoc viet tren giay*/


/* Phan 1 - cau 2 */	
SELECT P1.ProductNumber, SUM(H1.TotalDue), P1.Name
FROM Production.Product AS P1,
	Sales.SalesOrderHeader AS H1,
	Sales.SalesOrderDetail AS D1
WHERE P1.ProductID = D1.ProductID
	AND P1.ProductID IN (
	SELECT P.ProductID
	FROM Production.Product AS P, Sales.SalesOrderDetail AS D, Sales.SalesOrderHeader AS H
	WHERE P.ProductID = D.ProductID
		AND D.SalesOrderID = H.SalesOrderID
		AND P.SellStartDate > '2002-05-01'
		AND H.OrderDate < '2004-10-31'
	GROUP BY P.ProductID
	HAVING SUM(H.TotalDue) > 10000
)
GROUP BY P1.ProductID, P1.ProductNumber, P1.Name
	
	
/* Phan 1 - cau 3 */
SELECT H1.CustomerID, H1.SalesOrderID , H1.TotalDue
FROM Sales.SalesOrderHeader AS H1
WHERE H1.CustomerID IN (
		SELECT H.CustomerID
		FROM Sales.SalesOrderHeader AS H, Person.Address AS A
		WHERE H.ShipToAddressID = A.AddressID
			AND A.City = 'Paris'
			AND YEAR(H.ShipDate) = 2003
		GROUP BY H.CustomerID
		HAVING COUNT(H.SalesOrderID) > 5
)


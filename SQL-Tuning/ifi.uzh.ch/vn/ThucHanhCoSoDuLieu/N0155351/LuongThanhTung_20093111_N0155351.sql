use AdventureWorks2008;

/*CAU 1*/
SELECT TOP 10 A.ProductNumber, A.ListPrice, A.Name
FROM Production.Product AS A
WHERE A.ProductID IN 
	( SELECT B.ProductID
		FROM Sales.SalesOrderDetail AS B
		GROUP BY B.ProductID)
ORDER BY A.ListPrice DESC


/*CAU 2*/
SELECT E.FirstName, E.LastName, G.EmailAddress, D.SalesOrderID, D.TOTAL	  
FROM Person.Person AS E,
	 Sales.Customer AS F,
	 Person.EmailAddress AS G,
	(SELECT C.SalesOrderID, B.CustomerID, C.TOTAL, B.ModifiedDate
	 FROM 
		Sales.SalesOrderHeader AS B,
		(SELECT A.SalesOrderID, SUM(A.LineTotal) [TOTAL]
			FROM Sales.SalesOrderDetail AS A
			WHERE YEAR(A.ModifiedDate) = 2003
			GROUP BY A.SalesOrderID
			HAVING SUM(A.LineTotal) > 100000) AS C
	 WHERE B.SalesOrderID = C.SalesOrderID) AS D
WHERE D.CustomerID = F.CustomerID AND
	  F.PersonID = E.BusinessEntityID AND
	  F.PersonID = G.BusinessEntityID
	  
/*cAU 3*/	  
SELECT A.ProductID, COUNT(D.OrderQty) [NUMBER]
FROM Production.Product AS A,
	 Production.ProductSubcategory AS B,
	 Production.ProductCategory AS C,
	 Sales.SalesOrderDetail AS D
WHERE D.ProductID = A.ProductID AND
	  A.ProductSubcategoryID = B.ProductSubcategoryID AND
	  B.ProductCategoryID = C.ProductCategoryID AND
	  C.Name = 'Clothing'	 
GROUP BY A.ProductID
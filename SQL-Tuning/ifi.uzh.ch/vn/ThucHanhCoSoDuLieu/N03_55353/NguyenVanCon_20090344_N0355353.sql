USE AdventureWorks2008
/*----CAU_1----*/
SELECT P.ProductNumber, P.ListPrice, P.Name
FROM Production.Product AS P
WHERE MONTH(P.SellEndDate) = 5
  AND YEAR(P.SellEndDate) = 2002
  AND P.ProductID NOT IN (
	  SELECT SOD.ProductID
	  FROM Sales.SalesOrderDetail AS SOD, Sales.SalesOrderHeader AS SOH
	  WHERE SOH.OrderDate < '20020530'
  )

/*-----CAU_2-----*/
SELECT SOH1.CustomerID, SOD1.ProductID, SOH1.TotalDue
FROM Sales.SalesOrderHeader AS SOH1, Sales.PersonCreditCard AS PCA, Sales.SalesOrderDetail AS SOD1
WHERE SOH1.CreditCardID = PCA.CreditCardID
  AND SOH1.SalesOrderID = SOD1.SalesOrderID
  AND PCA.BusinessEntityID IN (
	SELECT BEA.BusinessEntityID
	FROM Person.BusinessEntityAddress AS BEA, Person.Address AS AD
	WHERE BEA.AddressID = AD.AddressID
	  AND AD.City = 'PARIS'	  
 )
  AND SOH1.CustomerID IN ( 
	SELECT SOH.CustomerID
	FROM Sales.SalesOrderHeader AS SOH
	WHERE YEAR(SOH.OrderDate) = 2003
	GROUP BY SOH.CustomerID
	HAVING COUNT(SOH.SalesOrderID) > 10
	)
	
/*------CAU3-------*/

SELECT SUM(SOD.OrderQty)
FROM Sales.SalesOrderDetail AS SOD, Sales.SalesOrderHeader AS SOH,
	 Sales.PersonCreditCard AS PCA, Person.BusinessEntityAddress AS PEA,
	 Person.Address AS AD
WHERE SOD.SalesOrderID = SOH.SalesOrderID
  AND SOH.CreditCardID = PCA.CreditCardID
  AND PCA.BusinessEntityID = PEA.BusinessEntityID
  AND PEA.AddressID = AD.AddressID
  AND AD.City = 'LONDON'
  AND YEAR(SOD.ModifiedDate) = 2003
  AND MONTH(SOD.ModifiedDate) = 5
  AND SOD.ProductID IN
   (
	SELECT P.ProductID
	FROM  Production.Product AS P, Production.ProductCategory AS PC, Production.ProductSubcategory AS PS
	WHERE PC.ProductCategoryID = PS.ProductCategoryID
	AND P.ProductSubcategoryID = PS.ProductSubcategoryID
	AND PC.Name = 'CLOTHING'
  )
  GROUP BY SOD.ProductID
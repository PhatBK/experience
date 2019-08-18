use AdventureWorks2008_temp

-----1----
SELECT	P.ProductNumber,P.ListPrice,P.Name
FROM	Production.Product as P,Sales.SalesOrderDetail as SOD
WHERE	YEAR(P.SellEndDate) >=2002
	AND	MONTH(P.SellEndDate) >=5	
	AND P.ProductID not IN( select ProductID from Sales.SalesOrderDetail)
	
GO
----2----
SELECT SOH.SalesOrderID, SOH.TotalDue, SOH.CustomerID
FROM Sales.SalesOrderHeader as SOH, Person.Address as A
WHERE SOH.ModifiedDate = A.ModifiedDate
AND YEAR(SOH.OrderDate) = 2003
AND A.City = 'Paris'
Group by SalesOrderID, SOH.TotalDue, SOH.CustomerID
having COUNT(SOH.SalesOrderID) > 10

---3--
SELECT COUNT(PP.ProductID)
FROM Person.Address as A, Production.Product as PP
Where PP.ModifiedDate = A.ModifiedDate
and PP.Name = 'Clothing'
and A.City = 'London'
and MONTH(PP.ModifiedDate) = 5
and YEAR(PP.ModifiedDate) = 2003
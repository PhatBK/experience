USE AdventureWorks2008Old
GO
---Cau 1:
-- cach 1
SELECT TOP 10 ProductNumber, ListPrice, Name
FROM  Production.Product p, Production.TransactionHistory t
WHERE p.ProductID = t.ProductID
and t.TransactionType = 'S'
GO
-- cach 2
SELECT DISTINCT TOP (10) P.ProductNumber, P.ListPrice, P.Name
FROM Sales.SalesOrderDetail as SOD
	INNER JOIN Production.Product as P
		ON SOD.ProductID = P.ProductID
ORDER BY P.ListPrice DESC;
---cau 2

	SELECT P.FirstName, P.LastName, EA.EmailAddress, SOH.SalesOrderID,
	SOH.TotalDue
	FROM Sales.SalesOrderHeader as SOH
	INNER JOIN Sales.Customer as C
		ON SOH.CustomerID = C.CustomerID
	INNER JOIN Person.Person as P
		ON C.PersonID = P.BusinessEntityID
	INNER JOIN Person.EmailAddress as EA
		ON P.BusinessEntityID = EA.BusinessEntityID
	WHERE SOH.TotalDue > 100000;
-- cau 3
SELECT COUNT (DISTINCT P.ProductID)
FROM Production.Product as P
	INNER JOIN Production.ProductSubcategory as PSc
		ON P.ProductSubcategoryID = PSc.ProductSubcategoryID
	INNER JOIN Production.ProductCategory as PC
		ON PSc.ProductCategoryID = PC.ProductCategoryID
	INNER JOIN Sales.SalesOrderDetail as SOD
		ON SOD.ProductID = P.ProductID
	INNER JOIN Sales.SalesOrderHeader as SOH
		ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN Person.Address as AD
		ON AD.AddressID = SOH.BillToAddressID
WHERE AD.City = 'London'
	AND PC.Name = 'Clothing';
--- cau 4
WITH combine (ProductID, tcount, [month]) AS
(
SELECT P.ProductID, COUNT (DISTINCT SOH.SalesOrderID) as tcount, 
	MONTH (SOH.OrderDate) as [month]
FROM Sales.SalesOrderHeader as SOH
	INNER JOIN Sales.SalesOrderDetail as SOD
		ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN Production.Product as P 
		ON P.ProductID = SOD.ProductID
	INNER JOIN Person.Address as AD
		ON AD.AddressID = SOH.BillToAddressID
WHERE (AD.City = 'London')
	AND (MONTH (SOH.OrderDate) = 4
		OR MONTH (SOH.OrderDate) = 5
		OR MONTH (SOH.OrderDate) = 6)
	AND (YEAR (SOH.OrderDate) = 2003)
GROUP BY P.ProductID, YEAR (SOH.OrderDate), MONTH (SOH.OrderDate)
)
SELECT *
FROM combine as co
WHERE co.ProductID in (
	SELECT te.ProductID
	FROM (
	SELECT ROW_NUMBER() OVER (PARTITION BY co1.month ORDER BY co1.tcount DESC) as RegNo,
	*
	FROM combine as co1) as te
	WHERE te.RegNo <= 5
)
ORDER BY co.month, co.tcount desc;



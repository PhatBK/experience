USE AdventureWorks2008;
GO
/* 1 ------------------------------------------------- */
SELECT P.*
FROM Sales.SalesOrderDetail SOD, Sales.SalesOrderHeader SOH, Person.Address A,
	Production.Product P, Production.ProductCategory PC, Production.ProductSubcategory PS
WHERE SOD.SalesOrderID = SOH.SalesOrderID
AND SOD.ProductID = P.ProductID
AND P.ProductSubcategoryID = PS.ProductSubcategoryID
AND PS.ProductCategoryID = PC.ProductCategoryID
AND SOH.BillToAddressID = A.AddressID
AND City = 'London'
AND MONTH(SOH.ShipDate) = 5 AND YEAR(SOH.ShipDate) = 2003
GO
/* 2 --------------------------------------------------- */
SELECT P.ProductID, P.Name, SUM(LineTotal) AS 'TongDoanhThu'
FROM Sales.SalesOrderDetail SOD, Sales.SalesOrderHeader SOH,
	Production.Product P
WHERE SOD.SalesOrderID = SOH.SalesOrderID
AND SOD.ProductID = P.ProductID
AND P.SellStartDate >= '2003-05-01'
AND SOH.OrderDate <= '2004-10-31'
GROUP BY P.ProductID, P.Name
HAVING SUM(LineTotal) > 10000
GO
/* 3 --------------------------------------------------- */
SELECT TB1.CustomerID, SOH2.SalesOrderID, SOH2.TotalDue
FROM
(SELECT C.CustomerID
FROM Sales.SalesOrderHeader SOH, Sales.Customer C, Person.Address A
WHERE SOH.CustomerID = C.CustomerID
AND A.AddressID = SOH.BillToAddressID
AND City = 'Paris'
AND YEAR(SOH.ShipDate) = 2003
GROUP BY C.CustomerID
HAVING COUNT(SOH.SalesOrderID) > 3) TB1, Sales.SalesOrderHeader SOH2, Person.Address A2
WHERE SOH2.CustomerID = TB1.CustomerID
AND YEAR(SOH2.ShipDate) = 2003
AND A2.AddressID = SOH2.BillToAddressID
AND City = 'Paris'
GO
/* 4 --------------------------------------------------- */
SELECT *
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY [Thang]
		ORDER BY [TongDatHang] DESC) AS [row_num], [TongDatHang], [Nam], [Thang], ProductID
			FROM (SELECT MONTH(SOH.OrderDate) AS [Thang], YEAR(SOH.OrderDate) AS [Nam], ProductID, SUM(OrderQty) AS [TongDatHang]
FROM Sales.SalesOrderDetail SOD, Sales.SalesOrderHeader SOH, Person.Address A
WHERE SOD.SalesOrderID = SOH.SalesOrderID
AND SOH.BillToAddressID = A.AddressID
AND City = 'London'
AND YEAR(SOH.OrderDate) IN (2003, 2004)
AND MONTH(SOH.OrderDate) > 3 AND MONTH(SOH.OrderDate) < 7
GROUP BY ProductID, MONTH(SOH.OrderDate), YEAR(SOH.OrderDate)) AS TB1) AS TB2
WHERE TB2.row_num < 6



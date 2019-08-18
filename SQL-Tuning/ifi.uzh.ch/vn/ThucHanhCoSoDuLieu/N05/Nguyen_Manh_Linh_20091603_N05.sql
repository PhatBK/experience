USE AdventureWorks2008;

--cau 1--

SELECT P.*
FROM 
	Production.Product as P,
	Production.ProductSubcategory as PSC,
	Production.ProductCategory as PC,
	Sales.SalesOrderHeader as SOH,
	Sales.SalesOrderDetail as SOD,
	Person.Address as A
WHERE 
	P.ProductID = SOD.ProductID
	AND SOD.SalesOrderID = SOH.SalesOrderID
	AND SOH.ShipToAddressID = A.AddressID
	AND 
	P.ProductSubcategoryID = PSC.ProductSubcategoryID
	AND 
	PC.ProductCategoryID = PSC.ProductCategoryID
	AND PC.Name = 'Clothing'
	AND A.City = 'London'
	AND MONTH(SOH.OrderDate) >= 5
	AND YEAR(SOH.OrderDate) >= 2003
	
	--index--
	CREATE INDEX IX_Product_Name ON Production.Product(Name);
	CREATE INDEX IX_Address_City ON Person.Address(City);
	CREATE INDEX IX_SalesOrderHeader_OrderDate ON Sales.SalesOrderHeader(OrderDate);
	
--cau 2--
SELECT P.ProductNumber, P.Name, SUM(SOH.TotalDue)
FROM
	Sales.SalesOrderHeader as SOH,
	Sales.SalesOrderDetail as SOD,
	Production.Product as P
WHERE 
	SOH.SalesOrderID = SOD.SalesOrderID
	AND SOD.ProductID = P.ProductID
	AND MONTH(P.SellStartDate) >= 5
	AND YEAR(P.SellStartDate) >= 2002
	AND MONTH(P.SellEndDate) <= 10
	AND YEAR(P.SellEndDate) <= 2004
	AND SOH.TotalDue > 10000
GROUP BY P.ProductNumber, P.Name
--index--
	CREATE INDEX IX_SalesOrderHeader_TotalDue ON Sales.SalesOrderHeader(TotalDue);
	CREATE INDEX IX_Product_SellStartDate_SellEndDate ON Production.Product(SellStartDate, SellEndDate);
--cau3--
SELECT SOH.CustomerID, SOH.SalesOrderID, SOH.TotalDue
FROM 
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
WHERE 
	SOH.ShipToAddressID = A.AddressID
	AND YEAR(SOH.ShipDate) = 2003
	AND A.City = 'Paris'
GROUP BY SOH.CustomerID, SOH.SalesOrderID, SOH.TotalDue
HAVING 
	COUNT(SOH.SalesOrderNumber) > 5
	
--index--
CREATE INDEX IX_SalesOrderHeader_ShipDate On Sales.SalesOrderHeader(ShipDate);
CREATE INDEX IX_Address_City On Person.Address(City);


--cau 4--
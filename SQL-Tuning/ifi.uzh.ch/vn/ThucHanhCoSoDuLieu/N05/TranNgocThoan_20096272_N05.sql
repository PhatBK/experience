USE AdventureWorks2008;
-- TRAN NGOC THOAN - 20096272 - CNTT4K54
-- DE 04

-- BAL LAM ---------------------------------------------------

-- PHAN I ---------------
-- Cau 1 ------------------------------------------------------------------------------------

SELECT 
	P.*
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
	AND P.ProductSubcategoryID = PSC.ProductSubcategoryID
	AND PC.ProductCategoryID = PSC.ProductCategoryID
	
	AND PC.Name = 'Clothing'
	AND A.City = 'London'

	AND MONTH(SOH.OrderDate) = 5
	AND YEAR(SOH.OrderDate) = 2003
	
	-- Index
CREATE INDEX IX_Product_Name ON Production.Product(Name);
CREATE INDEX IX_Address_City ON Person.Address(City);
CREATE INDEX IX_SalesOrderHeader_OrderDate ON Sales.SalesOrderHeader(OrderDate);

	
-- Cau 2 ------------------------------------------------------------------------------------
SELECT 
	P.ProductNumber as SoHieuSP, 
	P.Name as TenSP, 
	SUM(SOH.TotalDue) as TongDoanhThu
FROM
	Sales.SalesOrderHeader as SOH,
	Sales.SalesOrderDetail as SOD,
	Production.Product as P
WHERE 
	SOH.SalesOrderID = SOD.SalesOrderID
	AND SOD.ProductID = P.ProductID
	
	AND MONTH(P.SellStartDate) >= 5
	AND YEAR(P.SellStartDate) >= 2002
	AND MONTH(SOH.OrderDate) <= 10
	AND YEAR(SOH.OrderDate) <= 2004
	
	AND SOH.TotalDue > 10000
	
	GROUP BY P.ProductNumber, P.Name
	
	-- Index
CREATE INDEX IX_SalesOrderHeader_TotalDue ON Sales.SalesOrderHeader(TotalDue);
CREATE INDEX IX_Product_SellStartDate_SellEndDate ON Production.Product(SellStartDate, SellEndDate);

	

-- Cau 3 ------------------------------------------------------------------------------------
SELECT 
	C.CustomerID as MaSoKH, 
	SOH.SalesOrderID as MaDH,
	SOH.TotalDue as GiaTri
FROM 
	Sales.SalesOrderHeader as SOH,
	Sales.Customer as C,
	Person.Address as A,
	Person.Person as P,
	Sales.CreditCard as CC,
	Sales.PersonCreditCard as PCC
	
WHERE
	SOH.AccountNumber = C.AccountNumber
	
	AND YEAR(SOH.ShipDate) = 2003
	
	AND A.AddressID = SOH.BillToAddressID
	AND A.City = 'Paris'
	
GROUP BY C.CustomerID, SOH.SalesOrderID,SOH.TotalDue 
HAVING 
	COUNT(SOH.SalesOrderNumber) >= 5
	
	--Index
CREATE INDEX IX_SalesOrderHeader_ShipDate On Sales.SalesOrderHeader(ShipDate);
CREATE INDEX IX_Address_City On Person.Address(City);


-- Cau 4 ------------------------------------------------------------------------------------


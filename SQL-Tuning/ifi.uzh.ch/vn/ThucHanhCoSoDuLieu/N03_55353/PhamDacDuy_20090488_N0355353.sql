use AdventureWorks
--1--
SELECT	P.ProductNumber,P.ListPrice,P.Name
FROM	Production.Product as P,Sales.SalesOrderDetail as SOD
WHERE	YEAR(P.SellEndDate)=2002
	AND	MONTH(P.SellEndDate)=5
	AND P.ProductID=SOD.ProductID
group by P.Name,P.ProductNumber,P.ListPrice
having	COUNT(SOD.SalesOrderID)=0

--2--
SELECT	CustomerID,SOH.SalesOrderID,SOH.SubTotal
FROM	Sales.SalesOrderHeader as SOH,
		Person.Address as A
WHERE	SOH.ShipToAddressID=A.AddressID
	AND A.City='Paris'
	AND YEAR(SOH.ShipDate)=2003
group by CustomerID,,SOH.SalesOrderID,SOH.SubTotal
having COUNT(SOH.SalesOrderID)>=10

--3--
SELECT	COUNT(P.ProductID)
FROM	Production.Product as P,Production.ProductCategory as PC,
		Production.ProductSubcategory as PSC,Sales.SalesOrderDetail as SOD,
		Sales.SalesOrderHeader as SOH,Person.Address as A
WHERE	P.ProductSubcategoryID=PSC.ProductSubcategoryID
	AND PSC.ProductCategoryID=PC.ProductCategoryID
	AND P.ProductID=SOD.ProductID
	ANd SOD.SalesOrderID=SOH.SalesOrderID
	AND SOH.BillToAddressID=A.AddressID
	AND YEAR(SOH.OrderDate)=2003
	AND MONTH(SOH.OrderDate)=5
	ANd PC.Name='Clothing'                                                     
	AND A.City='London'
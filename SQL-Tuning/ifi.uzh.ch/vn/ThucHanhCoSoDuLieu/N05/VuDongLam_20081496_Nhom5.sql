--Viet yeu cau truy van
--Phan 1

USE AdventureWorks2008

--1.
SELECT	Pro.*

FROM
Production.Product as Pro,
production.ProductCategory as PC,
Production.ProductSubcategory as PS,
Sales.SalesOrderDetail as SOD,
Sales.SalesOrderHeader as SOH,
Person.Address as A

WHERE  PC.ProductCategoryID= PC.ProductCategoryID and
PS.ProductSubcategoryID = Pro.ProductSubcategoryID and
SOD.SalesOrderDetailID = SOH.SalesOrderID and
SOH.BillToAddressID = A.AddressID and
PC.Name = 'Clothing' and
A.City = 'London' and
MONTH(ShipDate)=5 and
YEAR(ShipDate)=2003

--2.

SELECT	Pro.ProductNumber,Pro.Name,SOD.LineTotal

FROM
Production.Product as Pro,
Sales.SalesOrderDetail as SOD,
Sales.SalesOrderHeader as SOH

WHERE
Pro.ProductID=SOD.ProductID and
SOD.SalesOrderID=SOH.SalesOrderID and
SOH.OrderDate<='2004-10-31' and
SellStartDate>='2002-05-01' and
SOD.LineTotal>10000

--3.
SELECT Cus.CustomerID,SOD.SalesOrderDetailID,SOH.TotalDue

FROM
Sales.Customer as Cus,
Sales.SalesOrderDetail as SOD,
Sales.SalesOrderHeader as SOH,
Person.Person as Per,
Person.Address as Addr

WHERE
Per.BusinessEntityID=Cus.CustomerID and
Cus.CustomerID=SOH.CustomerID and
SOH.SalesOrderID = SOD.SalesOrderID and
SOH.ShipToAddressID=Addr.AddressID and
Addr.City='Paris' and
YEAR(SOH.OrderDate)=2003

GROUP BY SOD.SalesOrderDetailID,SOH.TotalDue,Cus.CustomerID
HAVING SUM(SOD.SalesOrderDetailID)>5

--4.





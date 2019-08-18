Use AdventureWorks2008
--1--
select P.ProductNumber, P.ListPrice, P.Name
from Production.Product as P,
	Sales.SalesOrderDetail as POD
where 
	P.ProductID = POD.ProductID
	and MONTH(POD.ModifiedDate) = 5
	and YEAR(POD.ModifiedDate) = 2002
	and
	P.ProductID in (
	select Sales.SalesOrderDetail.ProductID
	from Sales.SalesOrderDetail
	group by Sales.SalesOrderDetail.ProductID
	having COUNT(Sales.SalesOrderDetail.ProductID)>50	
	)
--2--
select P.LastName, E.EmailAddress, SOH.SalesOrderID, SOH.TotalDue, A.City
from Person.Person as P,
	Person.EmailAddress as E, 
	Person.Address as A,
	Sales.SalesOrderHeader as SOH,
	Sales.Customer as C
where P.BusinessEntityID = E.BusinessEntityID
	and SOH.ShipToAddressID = A.AddressID
	and A.City = 'Paris'
	and SOH.BillToAddressID = P.BusinessEntityID
	and YEAR(SOH.ModifiedDate)=2003
	and C.CustomerID in (
select Sales.SalesOrderHeader.CustomerID
from Sales.SalesOrderHeader
group by Sales.SalesOrderHeader.CustomerID
having COUNT(Sales.SalesOrderHeader.SalesOrderID)>10)
--3--
select COUNT(P.ProductID)
from Production.Product as P,
	Production.ProductSubcategory as PS,
	Production.ProductCategory as PC,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as PA
where P.ProductSubcategoryID = PS.ProductSubcategoryID
	and PS.ProductCategoryID = PC.ProductCategoryID
	and PC.Name = 'Clothing'
	and P.ProductID = SOD.ProductID
	and SOD.SalesOrderID = SOH.SalesOrderID
	and SOH.ShipToAddressID = PA.AddressID
	and PA.City = 'London'
	and YEAR(SOH.ModifiedDate) = 2003
	and MONTH(SOH.ModifiedDate) = 5
	--4--
select top 5 P.ProductID,SOH.ModifiedDate
from Production.Product as P,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
where P.ProductID = SOD.ProductID
	and SOD.SalesOrderID = SOH.SalesOrderID
	and SOH.ShipToAddressID = A.AddressID
	and A.City = 'London'	
	and MONTH(SOH.ModifiedDate)in(4,5,6,7,8,9)
	and YEAR(SOH.ModifiedDate) in (2003,2004)
group by P.ProductID,SOH.ModifiedDate
having COUNT(SOD.SalesOrderID) in 
( 
	select top 5 COUNT(SOD.SalesOrderID) 
	from Sales.SalesOrderDetail as SOD 
	group by SOD.SalesOrderID
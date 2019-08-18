--1----
use AdventureWorks
select P.ProductNumber, P.ListPrice, P.Name
from Production.Product as P, 
	Sales.SalesOrderDetail as SOD
where P.ProductID = SOD.ProductID 
		and MONTH(SOD.ModifiedDate)=5 
		and YEAR(SOD.ModifiedDate)=2002 
		

--2---
select Per.FirstName, Per.MiddleName, Per.LastName, E.EmailAddress, 
		SOH.SalesOrderID, SOH.TotalDue
from	Person.Person as Per,
		Sales.Customer as C, 
		Person.EmailAddress as E,
		Sales.SalesOrderHeader as SOH
where C.PersonID = Per.BusinessEntityID 
	and C.CustomerID = SOH.CustomerID
	and Per.BusinessEntityID = E.BusinessEntityID
	and SOH.TotalDue > 1000
	and YEAR(SOH.ModifiedDate) = 2003

---3---
select count(P.ProductID)
from Production.Product as P,
	Production.ProductSubcategory as PS,
	Production.ProductCategory as PC,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
where P.ProductSubcategoryID = PS.ProductSubcategoryID
		and PS.ProductCategoryID = PC.ProductCategoryID
		and P.ProductID = SOD.ProductID
		and SOD.SalesOrderID = SOH.SalesOrderID
		and A.AddressID = SOH.ShipToAddressID
		and PC.Name = 'Clothing'
		and A.City = 'London'
		and YEAR(SOH.ModifiedDate)=2003
		AND MONTH(SOH.ModifiedDate)=5

--4--
select top 5 P.ProductID
from Production.Product as P,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
where SOH.SalesOrderID = SOD.SalesOrderID
		and SOD.ProductID = P.ProductID
		and A.AddressID = SOH.ShipToAddressID
		and YEAR(SOH.ModifiedDate) = 2003
		and MONTH(SOH.ModifiedDate) IN(4,5,6,7,8,9)
		and A.City = 'London'
Group by P.ProductID
Having COUNT(SOD.SalesOrderID) IN (Select top 5 COUNT(SOD.SalesOrderID)
										from Sales.SalesOrderDetail as SOD
										group by SOD.ProductID)
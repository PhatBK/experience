use AdventureWorks2008
--2--
select P.LastName, E.EmailAddress, SOH.SalesOrderID, SOH.TotalDue, A.City
from Person.Person as P,
	Person.EmailAddress as E,
	Person.Address as A,
	Sales.SalesOrderHeader as SOH,
	Sales.Customer as C
where P.BusinessEntityID = E.BusinessEntityID
	and SOH.ShipToAddressID = A.AddressID
	and A.City = 'London'
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
-- PHAN 1
Use AdventureWorks

-- 1.
select top 10 P.ProductNumber, P.ListPrice, P.Name
from Production.Product as P, Sales.SalesOrderDetail as SOD
where P.ProductID = SOD.ProductID and P.ListPrice = (select MAX(P.ListPrice) 
													from Production.Product as P
													)
group by ProductNumber, ListPrice, Name
order by ListPrice											
								
								
-- 2.
select Person.FirstName, Person.MiddleName, Person.LastName, Email.EmailAddress, 
		SOD.SalesOrderID, SOD.LineTotal
from	Person.Person, AdventureWorks.Sales.Customer as Cus,
		Person.EmailAddress as Email,
		Sales.SalesOrderDetail as SOD,Sales.SalesOrderHeader as SOH
where Cus.PersonID = Person.BusinessEntityID and Cus.CustomerID = SOH.CustomerID 
	and SOH.SalesOrderID = SOD.SalesOrderID
	and Person.BusinessEntityID = Email.BusinessEntityID
	and SOD.LineTotal > 100000 and YEAR(SOD.ModifiedDate) = 2003		
group by FirstName, MiddleName, LastName, EmailAddress,LineTotal, SOD.SalesOrderID

-- 3.
select count(*)
from Production.Product as P,Production.ProductSubcategory as PS,
	Production.ProductCategory as PC,Person.Address as A,
	Sales.SalesOrderDetail as SOD,Sales.SalesOrderHeader as SOH
where 
		P.ProductID = SOD.ProductID
		and PS.ProductCategoryID = PC.ProductCategoryID
		and P.ProductSubcategoryID = PS.ProductSubcategoryID
		and SOH.SalesOrderID = SOD.SalesOrderID
		and A.AddressID = SOH.ShipToAddressID
		and PC.Name = 'Clothing'and A.City = 'London'

-- 4.
select top 5 P.ProductID, COUNT(SOH.SalesOrderID)
from Production.Product as P, Person.Address as A,
	Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD
where SOH.SalesOrderID = SOD.SalesOrderID
		and SOD.ProductID = P.ProductID
		and A.AddressID = SOH.ShipToAddressID
		and YEAR(SOD.ModifiedDate) = 2003
		and MONTH(SOD.ModifiedDate) In(4, 5, 6)
		and A.City = 'London'
Group by P.ProductID
Order by COUNT(SOH.SalesOrderID)
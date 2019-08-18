--cau 1
select P.ProductNumber, P.ListPrice, P.Name
from AdventureWorks.Production.Product as P, 
	 AdventureWorks.Sales.SalesOrderDetail as SOD
where P.ProductID = SOD.ProductID and P.ListPrice = (select MAX(P.ListPrice) 
													from AdventureWorks.Production.Product as P )

--cau 2
select Per.FirstName, Per.MiddleName, Per.LastName, E.EmailAddress, 
		SOH.SalesOrderID, SOH.TotalDue
from	AdventureWorks.Person.Person as Per,
		AdventureWorks.Sales.Customer as C, 
		AdventureWorks.Person.EmailAddress as E,
		AdventureWorks.Sales.SalesOrderHeader as SOH
where C.PersonID = Per.BusinessEntityID 
	and C.CustomerID = SOH.CustomerID
	and Per.BusinessEntityID = E.BusinessEntityID
	and SOH.TotalDue > 100000
	and YEAR(SOH.ModifiedDate) = 2003

--cau 3
select count(P.ProductID)
from AdventureWorks.Production.Product as P,
	AdventureWorks.Production.ProductSubcategory as PS,
	AdventureWorks.Production.ProductCategory as PC,
	AdventureWorks.Sales.SalesOrderDetail as SOD,
	AdventureWorks.Sales.SalesOrderHeader as SOH,
	AdventureWorks.Person.Address as A
where P.ProductSubcategoryID = PS.ProductSubcategoryID
		and PS.ProductCategoryID = PC.ProductCategoryID
		and P.ProductID = SOD.ProductID
		and SOD.SalesOrderID = SOH.SalesOrderID
		and A.AddressID = SOH.ShipToAddressID
		and PC.Name = 'Clothing'
		and A.City = 'London'

--cau 4
select P.ProductID
from AdventureWorks.Production.Product as P,
	AdventureWorks.Sales.SalesOrderDetail as SOD,
	AdventureWorks.Sales.SalesOrderHeader as SOH,
	AdventureWorks.Person.Address as A
where SOH.SalesOrderID = SOD.SalesOrderID
		and SOD.ProductID = P.ProductID
		and A.AddressID = SOH.ShipToAddressID
		and YEAR(SOH.ModifiedDate) = 2003
		and MONTH(SOH.ModifiedDate) In(4, 5, 6)
		and A.City = 'London'
Group by P.ProductID
Having COUNT(SOD.SalesOrderID) IN (Select top 5 COUNT(SOD.SalesOrderID)
										from AdventureWorks.Sales.SalesOrderDetail as SOD
										group by SOD.ProductID)
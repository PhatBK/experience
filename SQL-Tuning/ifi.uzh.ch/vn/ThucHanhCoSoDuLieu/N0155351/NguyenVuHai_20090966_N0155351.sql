--C1--
select AP.ProductNumber, AP.ListPrice, AP.Name
from AdventureWorks.Production.Product as AP, 
	 AdventureWorks.Sales.SalesOrderDetail as SOD
where AP.ProductID = SOD.ProductID and AP.ListPrice = (select MAX(AP.ListPrice) 
													from AdventureWorks.Production.Product as AP )

--C2--
select P.FirstName, P.MiddleName, P.LastName, E.EmailAddress, 
		S.SalesOrderID, S.TotalDue
from	AdventureWorks.Person.Person as P,
		AdventureWorks.Sales.Customer as C, 
		AdventureWorks.Person.EmailAddress as E,
		AdventureWorks.Sales.SalesOrderHeader as S
where C.PersonID = P.BusinessEntityID and C.CustomerID = S.CustomerID
	and P.BusinessEntityID = E.BusinessEntityID and S.TotalDue > 100000
	and YEAR(S.ModifiedDate) = 2003

--C3--
select count(P.ProductID)
from AdventureWorks.Production.Product as P,
	AdventureWorks.Production.ProductSubcategory as PP,
	AdventureWorks.Production.ProductCategory as PC,
	AdventureWorks.Sales.SalesOrderDetail as SOD,
	AdventureWorks.Sales.SalesOrderHeader as SOH,
	AdventureWorks.Person.Address as A
where P.ProductSubcategoryID = PP.ProductSubcategoryID
		and PP.ProductCategoryID = PC.ProductCategoryID
		and P.ProductID = SOD.ProductID
		and SOD.SalesOrderID = SOH.SalesOrderID
		and A.AddressID = SOH.ShipToAddressID
		and PC.Name = 'Clothing'
		and A.City = 'London'

--C4--
select P.ProductID, P.Name
from AdventureWorks.Production.Product as P,
	AdventureWorks.Sales.SalesOrderDetail as SOD,
	AdventureWorks.Sales.SalesOrderHeader as SOH,
	AdventureWorks.Person.Address as A
where SOH.SalesOrderID = SOD.SalesOrderID
		and SOD.ProductID = P.ProductID
		and YEAR(SOH.ModifiedDate) = 2003
		and MONTH(SOH.ModifiedDate)In (4, 5, 6)
		and COUNT(SOD.SalesOrderID) IN (Select top 5 COUNT(SOD.SalesOrderID)
										from AdventureWorks.Sales.SalesOrderDetail as SOD
										group by SOD.ProductID)
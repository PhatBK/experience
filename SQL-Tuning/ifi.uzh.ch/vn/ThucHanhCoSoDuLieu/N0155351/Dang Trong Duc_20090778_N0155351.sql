Use AdventureWorks2008
-- 1.1 --
Select distinct p.ProductNumber, p.ListPrice, p.Name
From Production.Product p, 
	(Select Top 10 sod.ProductID
		From Sales.SalesOrderDetail sod
		Order By UnitPrice DESC) topTen
Where p.ProductID = topTen.ProductID

-- 1.2 --
Select p.FirstName, em.EmailAddress, h.SalesOrderID, h.TotalDue
From Sales.Customer c, Sales.SalesOrderHeader h, Person.Person p, Person.EmailAddress em
Where Year(h.OrderDate) = 2003
	And h.TotalDue > 100000
	And h.CustomerID = c.CustomerID 
	And c.PersonID = p.BusinessEntityID
	And p.BusinessEntityID = em.BusinessEntityID
			
-- 1.3 --
Select COUNT(*)
From Production.Product p, Production.ProductSubcategory s, Production.ProductCategory c,
		Sales.SalesOrderHeader h,Sales.SalesOrderDetail d, Person.Address a
Where c.Name = 'Clothing'
	and p.ProductSubcategoryID = s.ProductSubcategoryID 
	and s.ProductCategoryID = c.ProductCategoryID
	and d.ProductID = p.ProductID
	and h.SalesOrderID = d.SalesOrderDetailID
	and h.ShipToAddressID = a.AddressID
	and a.City = 'London'
	
-- 1.4 -- 

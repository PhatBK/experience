use AdventureWorks2008
/*cau1*/

Select p.ProductNumber, p.ListPrice, p.Name
From Production.Product p
where 
YEAR(p.SellStartDate) =2002



/*cau2*/
Select p.FirstName, em.EmailAddress, h.SalesOrderID, h.TotalDue
From Sales.Customer c, Sales.SalesOrderHeader h, Person.Person p, Person.EmailAddress em,Person.Address a
Where Year(h.OrderDate) = 2003
	And h.TotalDue > 1000
	And a.City = 'London'
	And h.CustomerID = c.CustomerID 
	And c.PersonID = p.BusinessEntityID
	And p.BusinessEntityID = em.BusinessEntityID

/*cau3*/
Select COUNT(*)
From Production.Product p, Production.ProductSubcategory s, Production.ProductCategory c,
		Sales.SalesOrderHeader h,Sales.SalesOrderDetail d, Person.Address a
Where c.Name = 'Clothing'
	and p.ProductSubcategoryID = s.ProductSubcategoryID 
	and d.ProductID = p.ProductID
	and h.SalesOrderID = d.SalesOrderDetailID
	and s.ProductCategoryID = c.ProductCategoryID
	and h.ShipToAddressID = a.AddressID
	and a.City = 'London'
	and Year(h.OrderDate) = 2003



	
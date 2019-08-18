/* Cau 1 */
select ProductNumber, ListPrice, Name
from Production.Product as p1, Sales.SalesOrderDetail as s1
where p1.ProductID in
	(select top 10 ProductID
	from Sales.SalesOrderDetail
	where p1.ProductID = s1.ProductID
	group by ProductID
	order by (p1.ListPrice) DESC)
	
/* Cau 2 */
select year(OrderDate), FirstName, MiddleName, LastName, EmailPromotion, SaleOrderID, TotalDue
from Person.Person as p1, Sales.SalesOrderHeader as s1
where year(s1.OrderDate) = 2003
and s1.BusinessEntityID = p1.BusinessEntityID
and s1.TotalDue >= 100000

/* Cau 3 */
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

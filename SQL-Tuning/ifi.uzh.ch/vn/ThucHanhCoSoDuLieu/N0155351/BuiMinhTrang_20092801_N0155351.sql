----1
use AdventureWorks2008
select distinct Top 10 Product.ProductNumber, Product.ListPrice, Product.Name
from Production.Product, Sales.SalesOrderDetail
where Product.ProductID = SalesOrderDetail.ProductID
order by ListPrice DESC
	

----2
select Person.FirstName, Person.LastName, 
	   SalesOrderDetail.ProductID,
	   SalesOrderHeader.TotalDue,
	   EmailAddress.EmailAddress
from Sales.SalesOrderHeader, Sales.SalesOrderDetail, 
	 Person.Person, Person.EmailAddress
where Year(SalesOrderDetail.ModifiedDate) = 2003
and	SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
and Person.BusinessEntityID = EmailAddress.BusinessEntityID
and SalesOrderHeader.TotalDue >= 100000

---3
select COUNT (Product.ProductID)
from Production.Product, Production.ProductCategory, Sales.SalesOrderDetail, Production.ProductSubcategory
where SalesOrderDetail.ProductID = Product.ProductID
and Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
and ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
and ProductCategory.Name = 'Clothing'
and SalesOrderDetail.SalesOrderID in (
			select distinct sd.SalesOrderID
			from Sales.Customer sc, Person.Address pa, Person.Person pp, Person.BusinessEntityAddress pba,
				 Person.BusinessEntity pb, Sales.SalesOrderHeader ss, Sales.SalesOrderDetail sd
			where sc.PersonID = pp.BusinessEntityID and pp.BusinessEntityID = pb.BusinessEntityID
			and  pb.BusinessEntityID = pba.BusinessEntityID and pba.AddressID = pa.AddressID 
			and ss.CustomerID = sc.CustomerID and ss.SalesOrderID = sd.SalesOrderID
			and pa.City = 'London'
			)


----4

select ROW_NUMBER () OVER (PARTITION BY Month(sd.ModifiedDate) ORDER BY SoLuong)
from ()

select COUNT (ss.SalesOrderID) as [SoLuong], sd.ProductID
from Sales.Customer sc, Person.Address pa, Person.Person pp, Person.BusinessEntityAddress pba,
	 Person.BusinessEntity pb, Sales.SalesOrderHeader ss, Sales.SalesOrderDetail sd
where sc.PersonID = pp.BusinessEntityID and pp.BusinessEntityID = pb.BusinessEntityID
and  pb.BusinessEntityID = pba.BusinessEntityID and pba.AddressID = pa.AddressID 
and ss.CustomerID = sc.CustomerID and ss.SalesOrderID = sd.SalesOrderID
and pa.City = 'London' and Year(sd.ModifiedDate) = 2003
group by sd.ProductID
order by SoLuong DESC
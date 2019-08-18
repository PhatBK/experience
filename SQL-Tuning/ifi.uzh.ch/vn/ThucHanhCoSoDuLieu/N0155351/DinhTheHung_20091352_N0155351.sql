use AdventureWorks2008

-------query 1
select Product.ProductNumber, Product.ListPrice, Product.Name
from Production.Product, 
 ( Select SalesOrderDetail.ProductID 
  from Sales.SalesOrderDetail
  group by ProductID
  ) as tempTable
  
where Product.ProductID = tempTable.ProductID
Order by ListPrice DESC
go 
CREATE index inx_Product_Price on Production.Product(ListPrice) 

-------query 2

select Person.FirstName, Person.MiddleName, Person.LastName, SalesOrderHeader.SalesOrderID, SalesOrderHeader.SubTotal
from Sales.SalesOrderHeader, Sales.Customer, Person.Person, Person.EmailAddress
where SalesOrderHeader.CustomerID = Customer.CustomerID and Customer.PersonID = Person.BusinessEntityID
and Person.BusinessEntityID = EmailAddress.BusinessEntityID and SalesOrderHeader.SubTotal > 100000
and SalesOrderHeader.OrderDate like '2003*'  

 create index idx_subtotal on Sales.SalesOrderHeader(OrderDate)
 --- query 3
 
 select COUNT(*) as SoLuong
 from Sales.SalesOrderHeader, Sales.SalesOrderDetail, Production.Product, Production.ProductCategory, Production.ProductSubcategory
     , Person.BusinessEntityAddress, Person.Address
     
 where SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID and 
		SalesOrderDetail.ProductID = Product.ProductID and 
		Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID and 
		ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
        and ProductCategory.Name = 'Clothing' and SalesOrderHeader.CustomerID = BusinessEntityAddress.BusinessEntityID 
        and BusinessEntityAddress.AddressID = Address.AddressID and Address.City ='London'
 go
 create index idx_city on Person.Address(City)  
 go     
 create index idx_category on Production.ProductCategory(Name)  
 
 --- query 4
 
 select *
 from Sales.SalesOrderDetail, Sales.SalesOrderHeader
 
 where SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID and SalesOrderHeader.OrderDate like '2003'
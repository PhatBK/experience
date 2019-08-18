use AdventureWorks2008
/*cau 1*/
select 

	Production.Product.ProductNumber, Production.Product.Name,
	 Production.Product.ListPrice
from Production.Product
where Production.product.ProductID in(
	select Sales.SalesOrderDetail.ProductID
	from Sales.SalesOrderDetail
	group by Sales.SalesOrderDetail.ProductID
	having COUNT(Sales.SalesOrderDetail.SalesOrderDetailID)>50
	
)
and (Production.Product.SellStartDate) > '20020501'
/*cau 2*/
select Person.Person.FirstName
from Person.Person
where Person.Person.BusinessEntityID  in(
	select 
)
select Person.BusinessEntityContact
select Person.BusinessEntityContact.PersonID
from Person.BusinessEntityContact
select Sales.Customer.PersonID
 -->Sales.Customer.CustomerID
 from Sales.Customer
 where Sales.Customer.CustomerID in(
	select Sales.SalesOrderHeader.CustomerID
	from Sales.SalesOrderHeader
	where Sales.SalesOrderHeader.TotalDue > 1000
 )
 /*cau 3*/
 select COUNT(Production.Product.ProductID)
 from Production.Product
 where Production.Product.ProductSubcategoryID 
 in(
	select Production.ProductSubcategory.ProductSubcategoryID
	 from Production.ProductSubcategory
	 where Production.ProductSubcategory.ProductCategoryID in(
		select Production.ProductCategory.ProductCategoryID
		 from Production.ProductCategory
		 -->group by Production.ProductCategory.ProductCategoryID
		 -->having (Production.ProductCategory.Name) = 'Clothing'
		 where (Production.ProductCategory.Name) = 'Clothing'
	 )
 )
 and /*gui den thanh pho london*/
 
 
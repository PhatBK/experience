use AdventureWorks2008;
----------------------
create index name_index on Production.Product(Name)
create index city_index on Person.Address(City)
select *
from Production.Product, Production.ProductCategory, Production.ProductSubcategory,
	 Sales.SalesOrderHeader,Sales.SalesOrderDetail, Person.Address
where Product.ProductSubcategoryID= ProductSubcategory.ProductSubcategoryID
and ProductSubcategory.ProductCategoryID= ProductCategory.ProductCategoryID
and ProductCategory.Name='Clothing'
and Product.ProductID= SalesOrderDetail.ProductID
and SalesOrderDetail.SalesOrderID= SalesOrderHeader.SalesOrderID
and SalesOrderHeader.BillToAddressID= Address.AddressID
and Address.City='London'
and MONTH(SalesOrderHeader.ShipDate)=5
and YEAR(SalesOrderHeader.ShipDate)=2003


-------------------------
select Sales.SalesOrderDetail.ProductID, Production.Product.Name, SUM(sales.SalesOrderDetail.LineTotal) as_total
from Sales.SalesOrderDetail, Production.Product, Sales.SalesOrderHeader
where Product.ProductID= SalesOrderDetail.ProductID
and SalesOrderDetail.SalesOrderID= SalesOrderHeader.SalesOrderID
and MONTH(Product.SellStartDate)=5
and YEAR(Product.SellStartDate)=2002
and YEAR(SalesOrderHeader.OrderDate)<=2004
and YEAR(SalesOrderHeader.OrderDate)>=2002
and SUM(sales.SalesOrderDetail.LineTotal)>10000

-----------------------
create index city_index on Person.Address(City)
create index year_index on Sales.SalesOrderHeader(OrderDate)
select Sales.Customer.CustomerID, Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.TotalDue
from Sales.Customer, Sales.SalesOrderHeader, Person.Address
where SalesOrderHeader.CustomerID= Customer.CustomerID
and SalesOrderHeader.BillToAddressID=Address.AddressID
and Address.City='Paris'
and YEAR(SalesOrderHeader.OrderDate)=2003
group by Customer.CustomerID, Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.TotalDue
having COUNT(SalesOrderHeader.SalesOrderID)>5
----------------------------

/* cau 1 */
create index ProductCategoryID_index on Production.ProductCategory(ProductCategoryID)
drop index ProductCategoryID_index on Production.ProductCategory

select COUNT(*)as so_san_pham
from	Sales.SalesOrderHeader
		inner join	Sales.SalesOrderDetail on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
		inner join	Production.Product on SalesOrderDetail.ProductID = Product.ProductID
		inner join	Production.ProductSubcategory on Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
		inner join	Production.ProductCategory on ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
		inner join	Person.Address on SalesOrderHeader.ShipToAddressID = Address.AddressID
where	ProductCategory.Name = 'Clothing' and Address.City = 'London' and YEAR(SalesOrderHeader.OrderDate) = 2003
		and MONTH(SalesOrderHeader.OrderDate) = 5
		
/* cau 3*/
select	Person.Person.BusinessEntityID, Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.TotalDue 
from	Sales.SalesOrderHeader
		inner join	Person.Address on SalesOrderHeader.ShipToAddressID = Address.AddressID
		inner join	Sales.Customer on SalesOrderHeader.CustomerID = Customer.CustomerID
		inner join	Person.Person on Customer.CustomerID = Person.BusinessEntityID
where	Address.City = 'Paris' and YEAR(SalesOrderHeader.OrderDate) = 2003	
group by Person.Person.BusinessEntityID, Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.TotalDue 
having count(SalesOrderHeader.SalesOrderID)>5

/* cau 2*/
select	Production.Product.ProductNumber,Production.Product.Name, SUM(Sales.SalesOrderHeader.TotalDue)
from	(
select	Sales.SalesOrderDetail.ProductID as ProductID
from	Sales.SalesOrderHeader
		inner join	Sales.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
group by	SalesOrderDetail.ProductID
having		SUM(Sales.SalesOrderHeader.TotalDue) >=  10000
			and ((MONTH(SalesOrderHeader.OrderDate) + YEAR(SalesOrderHeader.OrderDate) * 12))>= 2002 * 12 + 5
			and ((MONTH(SalesOrderHeader.OrderDate) + YEAR(SalesOrderHeader.OrderDate) * 12))<= 2004 * 12 + 10
		) as Temp,
		Production.Product
where	Product.ProductID = Temp.ProductID		

/*cau 4*/


		
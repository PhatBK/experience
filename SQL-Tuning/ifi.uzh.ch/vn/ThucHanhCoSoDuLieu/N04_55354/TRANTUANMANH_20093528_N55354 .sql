-- cau 1
select	Product.Name, Product.ProductNumber, Product.ListPrice
from	(
select	SalesOrderDetail.ProductID as ProductID
from	Sales.SalesOrderHeader
		inner join	Sales.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
group by	SalesOrderDetail.ProductID
having		COUNT(SalesOrderHeader.SalesOrderID) >=  50
			and MIN((MONTH(SalesOrderHeader.OrderDate) + YEAR(SalesOrderHeader.OrderDate) * 12)) >= 2002 * 12 + 5
		) as Temp,
		Production.Product
where	Product.ProductID = Temp.ProductID		

--------------------------

-- cau 2

select	Person.FirstName, EmailAddress.EmailAddress, SalesOrderHeader.SalesOrderID, SalesOrderHeader.TotalDue
from	Sales.SalesOrderHeader
		inner join	Person.Address on SalesOrderHeader.BillToAddressID = Address.AddressID
		inner join	Sales.Customer on SalesOrderHeader.CustomerID = Customer.CustomerID
		inner join	Person.Person on Customer.CustomerID = Person.BusinessEntityID
		inner join	Person.EmailAddress on EmailAddress.BusinessEntityID = Person.BusinessEntityID
where	Address.City = 'London' and YEAR(SalesOrderHeader.OrderDate) = 2003	and SalesOrderHeader.TotalDue > 1000

----------------------

-- cau 3

select	COUNT(*)
from	Sales.SalesOrderHeader
		inner join	Sales.SalesOrderDetail on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
		inner join	Production.Product on SalesOrderDetail.ProductID = Product.ProductID
		inner join	Production.ProductSubcategory on Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
		inner join	Production.ProductCategory on ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
		inner join	Person.Address on SalesOrderHeader.ShipToAddressID = Address.AddressID
where	ProductCategory.Name = 'Clothing' and Address.City = 'London' and YEAR(SalesOrderHeader.OrderDate) = 2003
		and MONTH(SalesOrderHeader.OrderDate) = 5
------------------

-- cau 4

with	TempTb
as
(
select	ProductID, Thang, RANK() over (partition by Thang order by SUM(Qty) desc) as Rank
from		
(
select	ProductID as ProductID, MONTH(SalesOrderHeader.OrderDate) as Thang, SalesOrderDetail.OrderQty as Qty
from	Sales.SalesOrderHeader 
		inner join	Sales.SalesOrderDetail on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
		inner join	Person.Address on SalesOrderHeader.BillToAddressID = Address.AddressID
where	Address.City = 'London'
		and YEAR(SalesOrderHeader.OrderDate) = 2003
		and ( (MONTH(SalesOrderHeader.OrderDate) - 1) / 3 = 1 or  (MONTH(SalesOrderHeader.OrderDate) - 1) / 3 = 2)				
) as Temp		
group by  Thang, ProductID
)
select	*
from	TempTb
where	Rank <= 5
		
		
		
		
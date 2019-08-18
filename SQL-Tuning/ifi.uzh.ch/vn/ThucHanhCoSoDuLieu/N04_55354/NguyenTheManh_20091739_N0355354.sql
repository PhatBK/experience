--cau 1--
use AdventureWorks
select	Product.ListPrice, Product.ProductNumber, Product.Name
from	Production.Product, (select	Product.ProductID as ProductID, SalesOrderHeader.OrderDate
								from	Sales.SalesOrderHeader 
										inner join Sales.SalesOrderDetail on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
										inner join Production.Product on SalesOrderDetail.ProductID = Product.ProductID
								group by	Product.ProductID, SalesOrderHeader.OrderDate
								having		COUNT(SalesOrderDetail.SalesOrderDetailID) > 50 and  MIN(MONTH(SalesOrderHeader.OrderDate) + 12 * YEAR(SalesOrderHeader.OrderDate)) >= (12 * 2002 + 5)
							) as Temp
where	Product.ProductID = Temp.ProductID

--cau 2--
use AdventureWorks
select	Person.FirstName, Person.LastName, EmailAddress.EmailAddress, SalesOrderHeader.SalesOrderID, SalesOrderHeader.TotalDue
from	Sales.SalesOrderHeader
		inner join	Person.Address on Address.AddressID = SalesOrderHeader.BillToAddressID
		inner join	Sales.Customer on Customer.CustomerID = SalesOrderHeader.CustomerID
		inner join	Person.Person on Person.BusinessEntityID = Customer.PersonID
		inner join	Person.EmailAddress on Person.BusinessEntityID = EmailAddress.BusinessEntityID
where	Address.City = 'London' and SalesOrderHeader.TotalDue > 1000 and YEAR(SalesOrderHeader.OrderDate) = 2003

--make index ---
create index index_SaleOrderHeaderTotalDue  on [Sales].[SalesOrderHeader](TotalDue)

create index index_Address_City on [Person].[Address](City)

--cau 3--
use AdventureWorks
select	Count(Product.Name)		
from	Production.Product, 	(select Product.ProductID
									from Sales.SalesOrderDetail
										inner join Sales.SalesOrderHeader on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
										inner join Production.Product on Product.ProductID = SalesOrderDetail.ProductID
										inner join Production.ProductSubcategory on ProductSubcategory.ProductSubcategoryID = Product.ProductSubcategoryID
										inner join Production.ProductCategory on ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
										inner join Person.Address on Address.AddressID = SalesOrderHeader.BillToAddressID
									where	Production.ProductCategory.Name = 'Clothing' 
											and Person.Address.City ='london'
									group by Product.ProductID, SalesOrderHeader.OrderDate
									having (MONTH(SalesOrderHeader.OrderDate) + 12 * YEAR(SalesOrderHeader.OrderDate)) = (12 * 2003 + 5)
								)as Temp
where	Product.ProductID = Temp.ProductID
--make index --
create index index_SaleOrderHeaderOrderDate  on [Sales].[SalesOrderHeader](OrderDate)

-- cau 4--

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

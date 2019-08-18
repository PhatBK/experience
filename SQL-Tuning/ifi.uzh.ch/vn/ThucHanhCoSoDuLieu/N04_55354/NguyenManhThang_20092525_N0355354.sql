--1--
select ProductNumber, ListPrice, Name
from Production.Product
where ProductID IN
	(select SalesOrderDetail.ProductID as ProductID
	from Sales.SalesOrderHeader inner join Sales.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
								inner join Production.Product on SalesOrderDetail.ProductID = Product.ProductID
	where SellEndDate='2002-05-01 00:00:00.000'						
	group by SalesOrderDetail.ProductID having count(SalesOrderHeader.SalesOrderID)=0)

--2--
select CustomerID, SalesOrderID, SubTotal 
from Sales.SalesOrderHeader
where CustomerID IN
(	select SalesOrderHeader.CustomerID as CID
		from Sales.SalesOrderHeader inner join Sales.Customer on SalesOrderHeader.CustomerID = Customer.CustomerID
							inner join Person.Address on SalesOrderHeader.ShipToAddressID = Address.AddressID
										
										
		where Address.City='Paris' and YEAR(OrderDate)=2003 
	group by SalesOrderHeader.CustomerID having COUNT(SalesOrderID)>=10
) 

--3--
select count(ProductID)
from Production.Product	inner join Production.ProductSubcategory
							on Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
						inner join Production.ProductCategory
							on ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
where ProductID IN (select ProductID
		from Sales.SalesOrderHeader inner join Person.Address
									on SalesOrderHeader.ShipToAddressID = Address.AddressID
								inner join Sales.SalesOrderDetail
									on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
		where City='London' and MONTH(OrderDate)=5 and YEAR(OrderDate)=2003)

and ProductCategory.Name='Clothing'
--4--

	select * from (select sum(OrderQty) as TongSoOrder, Thang, Nam, ProductID,
					RANK() over (partition by Thang order by sum(OrderQty) desc) as RankNumber	
			
					from ( select ProductID as ProductID, Sales.SalesOrderDetail.SalesOrderID as OrderID,
					SalesOrderDetail.OrderQty as OrderQty, 
					MONTH(OrderDate) as Thang,
					YEAR(OrderDate) as Nam
					from Sales.SalesOrderHeader inner join Sales.SalesOrderDetail
									on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
									inner join Person.Address
									on SalesOrderHeader.BillToAddressID = Address.AddressID
					where ((MONTH(OrderDate)-1)/3=1)
					and (YEAR(OrderDate)=2003 or YEAR(OrderDate)=2004)
					and City='London') as Temp
					group by Thang, Nam, ProductID
					) as temp2
	where RankNumber <=5 






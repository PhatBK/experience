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

select	Person.FirstName, EmailAddress.EmailAddress, SalesOrderHeader.SalesOrderID, SalesOrderHeader.TotalDue
from	Sales.SalesOrderHeader
		inner join	Person.Address on SalesOrderHeader.BillToAddressID = Address.AddressID
		inner join	Sales.Customer on SalesOrderHeader.CustomerID = Customer.CustomerID
		inner join	Person.Person on Customer.CustomerID = Person.BusinessEntityID
		inner join	Person.EmailAddress on EmailAddress.BusinessEntityID = Person.BusinessEntityID
where	Address.City = 'London' and YEAR(SalesOrderHeader.OrderDate) = 2003	and SalesOrderHeader.TotalDue > 1000

select	COUNT(*)
from	Sales.SalesOrderHeader
		inner join	Sales.SalesOrderDetail on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
		inner join	Production.Product on SalesOrderDetail.ProductID = Product.ProductID
		inner join	Production.ProductSubcategory on Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
		inner join	Production.ProductCategory on ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
		inner join	Person.Address on SalesOrderHeader.ShipToAddressID = Address.AddressID
where	ProductCategory.Name = 'Clothing' and Address.City = 'London' and YEAR(SalesOrderHeader.OrderDate) = 2003
		and MONTH(SalesOrderHeader.OrderDate) = 5


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
		
		
		
		  
	use AdventureWorks2008

    /* create view*/
    create view TopFive as 
    select F.months, count(saleId) over(Partition by F.productID) soluong, F.years, 
    F.productId, F.saleId
	from Four F
	group by months, years, productId, saleId
	
	Select *
	from(
	Select *, DENSE_RANK() over(partition by months order by soluong DESC) thutu 
	from TopFive) as TG
	where TG.thutu<6
	
	/* Su dung truy van long */
	select TG2.ProductID, TG2.thutu
	from (
	select ProductID, DENSE_RANK() over(partition by TG1.thang order by TG1.soluongdonhang DESC) thutu
	from (
	select  TG.thang, SOD.ProductID, 
			COUNT(SOD.SalesOrderID) over(partition by SOD.ProductID) soluongdonhang
	from Sales.SalesOrderDetail SOD, 
	     (select SOH.SalesOrderID, MONTH(SOH.OrderDate) thang from Sales.SalesOrderHeader SOH, 
	            Person.Address A
	      where YEAR(SOH.OrderDate) = 2003 and MONTH(SOH.OrderDate) between 4 and 9
	      and SOH.BillToAddressID = A.AddressID and A.City = 'London'
	      ) as TG
	where SOD.SalesOrderID = TG.SalesOrderID) as TG1) TG2
	where TG2.thutu < 6
	
	/*==============Tao view =============*/
	create view TG as select SOH.SalesOrderID, 
		  MONTH(SOH.OrderDate) thang from Sales.SalesOrderHeader SOH, 
	            Person.Address A
	      where YEAR(SOH.OrderDate) = 2003 and MONTH(SOH.OrderDate) between 4 and 9
	      and SOH.BillToAddressID = A.AddressID and A.City = 'London'
	      
    create view TG2 as select  TG.thang, SOD.ProductID, 
			COUNT(SOD.SalesOrderID) over(partition by SOD.ProductiD) soluongdonhang
	from Sales.SalesOrderDetail SOD, TG
	where SOD.SalesOrderID = TG.SalesOrderID	      
	
	
	select TG3.ProductID, TG3.thutu
	from (
	select *, DENSE_RANK() over(partition by TG2.thang order by TG2.soluongdonhang DESC) thutu
	from TG2) TG3
	where TG3.thutu < 6
	
	/*==========================*/
	select *, DENSE_RANK() over(partition by thang order by soluong DESC) thutu
	from (
	select TG1.nam, TG1.thang, TG1.ProductID, COUNT(TG1.SalesOrderID) soluong
	from (
		select TG.*, SOD.ProductID
		from (
			select SOH.SalesOrderID, MONTH(SOH.OrderDate) thang, YEAR(SOH.OrderDate) nam
			from Sales.SalesOrderHeader SOH, Person.Address A
			where YEAR(SOH.OrderDate) = 2003 AND
				  MONTH(SOH.OrderDate) between 4 and 9 AND
				  SOH.BillToAddressID = A.AddressID AND
				  A.City = 'London') TG, Sales.SalesOrderDetail SOD
		where TG.SalesOrderID = SOD.SalesOrderID) AS TG1
    group by TG1.nam, TG1.thang, TG1.ProductID) AS TG2
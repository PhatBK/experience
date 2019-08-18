use AdventureWorks2008Old

-- Cau 1
select p.*
from Production.Product as p
	inner join Production.ProductSubcategory as ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
	inner join Production.ProductCategory as pc on ps.ProductCategoryID = pc.ProductCategoryID, 
	(select distinct ProductID
	from Sales.SalesOrderHeader as soh inner join Sales.SalesOrderDetail as sod on soh.SalesOrderID = sod.SalesOrderID inner join Person.Address as a on soh.ShipToAddressID = a.AddressID
	where a.City = 'London' and MONTH(OrderDate) = '5' and YEAR(OrderDate)='2003') as temp
where pc.Name = 'Clothing' and temp.ProductID = p.ProductID
--cau3

select temp.CustomerID, soh.SalesOrderID, TotalDue
from (select CustomerID
	from Sales.SalesOrderHeader as soh inner join Person.Address as a on a.AddressID = soh.ShipToAddressID
	where a.City = 'Paris'
	group by CustomerID
	having count(SalesOrderID) >5) as temp, Sales.SalesOrderHeader as soh
where soh.CustomerID = temp.CustomerID
	
--cau4
create view temp as
select Year(OrderDate) as Nam ,MONTH (OrderDate) as Thang , ProductID, SUM(OrderQty) as TongSoLuong
from Sales.SalesOrderDetail as sod inner join Sales.SalesOrderHeader as soh on sod.SalesOrderID = soh.SalesOrderID inner join Person.Address as a on a.AddressID = soh.ShipToAddressID
where MONTH(OrderDate) in ('4', '5', '6') and YEAR(OrderDate) in ('2003', '2004') and City = 'London'
group by ProductID, Year(OrderDate),MONTH (OrderDate)


Select temp2.*
from (select RANK() over (partition by temp.Thang, temp.Nam order by temp.TongSoLuong desc) as XepHang, temp.Nam, temp.Thang, temp.ProductID, temp.TongSoLuong 
	from temp
	) as temp2 
where temp2.XepHang <6


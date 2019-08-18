--				BAI THI PHAN THUC HANH NGUYEN THE ANH 20090116
use AdventureWorks2008Old
--Phan 1

--cau 1
select distinct p.ProductNumber,p.ListPrice,p.Name
from Production.Product as p	
	,Sales.SalesOrderDetail as sod,
	Sales.SalesOrderHeader as soh
where sod.SalesOrderID=soh.SalesOrderID
and p.ProductID=sod.ProductID
--san pham nay khong duoc ban sau thang 5-2002
and p.ProductID NOT IN(
--dua ra san pharm ban duoc tu thang 5-2002
					select distinct sod.ProductID
					from Sales.SalesOrderHeader as soh,
						 Sales.SalesOrderDetail as sod
					where soh.SalesOrderID=sod.SalesOrderDetailID
					and soh.OrderDate >='2002-05-01')
--san pham nay khong duoc ban lan nao 
and p.ProductID NOT IN (
		select p.ProductID
		from Production.Product as p
		where p.ProductID NOT IN (
			select sod.ProductID
			from Sales.SalesOrderDetail as sod
			,Sales.SalesOrderHeader as soh
			where soh.SalesOrderID=sod.SalesOrderID
			)
		)



--cau 2



--cau 3
select count(P.ProductID)
from Production.Product as P,
	Production.ProductSubcategory as PS,
	Production.ProductCategory as PC,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
where P.ProductSubcategoryID = PS.ProductSubcategoryID
		and PS.ProductCategoryID = PC.ProductCategoryID
		and P.ProductID = SOD.ProductID
		and SOD.SalesOrderID = SOH.SalesOrderID
		and A.AddressID = SOH.ShipToAddressID
		and PC.Name = 'Clothing'
		and A.City = 'London'
		and YEAR(SOH.ShipDate)=2003
		AND MONTH(SOH.ShipDate)=5
		
		--su dung index se su dung cau lenh sau
		--and  SOH.ShipDate >='2003-05-01'
		--and SOH.ShipDate<='2003-05-31' 
		

--cau 4

use AdventureWorks2008Old
	select YEAR(s1.OrderDate),Month(s1.OrderDate), COUNT(s2.ProductID)
	from Sales.SalesOrderHeader as s1
		,Sales.SalesOrderDetail as s2
	where 
	s1.SalesOrderID=s2.SalesOrderID
	and  s2.ProductID IN(
			select TOP 5 p.ProductID
			 from Production.Product as p,Sales.SalesOrderHeader as soh,
			 Person.Address as A
				 where YEAR(soh.OrderDate)=YEAR(s1.OrderDate)
			 and YEAR(SOH.OrderDate) IN(2003,2004)
			 and MONTH(SOH.OrderDate) IN(4,5,6,7,8,9)
			 and A.City = 'London'
			 group by YEAR(s1.OrderDate),MONTH(s1.OrderDate)
			)
		group by YEAR(s1.OrderDate),MONTH(s1.OrderDate)
--phan 2
use AdventureWorks2008
Go
--Phan 1

--Cau 1: <6 rows result>
select P.*
from Production.Product as P,
	Production.ProductCategory as PC,
	Production.ProductSubcategory as PS,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A	
where P.ProductSubcategoryID = PS.ProductSubcategoryID and
	PS.ProductCategoryID = PC.ProductCategoryID and
	P.ProductID = SOD.ProductID and
	SOD.SalesOrderID = SOH.SalesOrderID and
	SOH.ShipToAddressID = A.AddressID and
	PC.Name = 'Clothing' and
	A.City = 'London' and
	YEAR(SOH.ShipDate) = 2003 and
	MONTH(SOH.ShipDate) = 5


--Cau 2
select P.ProductNumber, SUM(SOD.LineTotal) as 'Tong doanh thu', P.Name
from Production.Product as P,
	Sales.SalesOrderHeader as SOH, 
	Sales.SalesOrderDetail as SOD	
where P.ProductID = SOD.ProductID and
	SOD.SalesOrderID = SOH.SalesOrderID and
	YEAR(P.SellStartDate) = 2002 and
	MONTH(P.SellStartDate) = 5 and
	SOH.OrderDate < '20041101'
group by P.ProductNumber, P.Name
having SUM(SOD.LineTotal) > 10000



--Cau 3

select C.CustomerID, SOH.SalesOrderID, SOH.TotalDue
from Sales.Customer as C,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
where C.CustomerID = SOH.CustomerID and
	SOH.ShipToAddressID = A.AddressID and
	A.City = 'Paris' and
	YEAR(SOH.ShipDate) = 2003 and
	C.CustomerID IN
		(Select C.CustomerID
		from Sales.Customer as C_1,
			Sales.SalesOrderHeader as SOH_1,
			Person.Address as A_1
		where C_1.CustomerID = SOH_1.CustomerID and
		SOH_1.ShipToAddressID = A_1.AddressID and
		A_1.City = 'Paris' and
		YEAR(SOH_1.ShipDate) = 2003
		group by C_1.CustomerID
		having COUNT(SOH_1.SalesOrderID) >5
		)
order by C.CustomerID


--Cau 4

select *
from (
	select RANK() over ( partition  by [nam],[thang] order by [tongdat] desc) as [rank_Number], 
		[nam], [thang], productID, [tongdat]
	from (		
		select YEAR(SOH.OrderDate) as [nam],MONTH(SOH.OrderDate) as [thang], 
			SOD.ProductID, SUM(SOD.OrderQty) as [tongdat]
		from Sales.SalesOrderDetail as SOD,
			Sales.SalesOrderHeader as SOH,
			Person.Address as A
		where SOD.SalesOrderID = SOH.SalesOrderID and
			SOH.BillToAddressID = A.AddressID and
			A.City = 'London' and
			YEAR(SOH.OrderDate) IN (2003,2004) and MONTH(SOH.OrderDate) IN (4,5,6)
		group by YEAR(SOH.OrderDate),MONTH(SOH.OrderDate),SOD.ProductID
		) as [Thongke]
	) as [thongke2]
where [rank_number] < 6 
	
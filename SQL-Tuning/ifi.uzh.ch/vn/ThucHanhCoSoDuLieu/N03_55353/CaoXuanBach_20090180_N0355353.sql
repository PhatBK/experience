use AdventureWorks2008

/*Phan 2*/

		select * 
		from (select DENSE_RANK() over (PARTITION by [Nam] order by [TongGiaTriHoaDon] desc) as [rank_Number],
		CustomerID, [Nam], [TongGiaTriHoaDon]
		from
		(
			select [ThongKeGiaTriHoaDon_KhachHang].CustomerID, 
			YEAR([ThongKeGiaTriHoaDon_KhachHang].ModifiedDate) as [Nam],
			SUM([ThongKeGiaTriHoaDon_KhachHang].[GiaTriHoaDon]) as [TongGiaTriHoaDon]
			from 
				(select Sales.SalesOrderHeader.CustomerID,
				Sales.SalesOrderHeader.SalesOrderID,
				Sales.SalesOrderHeader.ModifiedDate,
				SUM(Sales.SalesOrderDetail.LineTotal) as [GiaTriHoaDon]
				from Sales.SalesOrderHeader, Sales.SalesOrderDetail
				where SalesOrderDetail.SalesOrderID= SalesOrderHeader.SalesOrderID
				group by SalesOrderHeader.SalesOrderID,
						SalesOrderHeader.CustomerID,
						SalesOrderHeader.ModifiedDate
						) as [ThongKeGiaTriHoaDon_KhachHang]
			group by [ThongKeGiaTriHoaDon_KhachHang].CustomerID,
			YEAR([ThongKeGiaTriHoaDon_KhachHang].ModifiedDate)) as [ThongKeTongGiaTriHoaDon_KhachHang]
			) as [ThongKeTongGiaTriHoaDon_KhachHang1]
			
			where [rank_Number] <6
/*Phan 1*/

/*Cau 3*/

select 
	ProductID, sum(OrderQty) as sl
from 
	Sales.SalesOrderDetail, 
	Sales.SalesOrderHeader
where 
	SalesOrderHeader.BillToAddressID in
		(
		select AddressID
		from Person.Address
		where City= 'London'				
		)		and
	YEAR(ShipDate) = 2003 and
	MONTH(ShipDate) = 5 and
	ProductID in
	(
	
	select ProductID
from 
	Production.Product as P,
	Production.ProductCategory as PC,
	Production.ProductSubcategory as PSC
where
		P.ProductSubcategoryID = PSC.ProductSubcategoryID and
		PSC.ProductCategoryID= PC.ProductCategoryID and
		PC.Name = 'Clothing'
	
	)
group by ProductID	


		
/*Cau 2*/
select SOH.CustomerID, COUNT(SOH.SalesOrderID) as sl, sum(TotalDue)
from Sales.SalesOrderHeader	as SOH
where 
 BillToAddressID in
 (
	select AddressID
	from Person.Address
	where City= 'Paris'
 ) and
 YEAR(OrderDate) = 2003 
 group by SOH.CustomerID
 having COUNT(SOH.SalesOrderID) > 10

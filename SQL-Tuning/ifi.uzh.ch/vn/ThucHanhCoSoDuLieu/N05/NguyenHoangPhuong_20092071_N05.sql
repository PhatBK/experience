--.Nguyen Hoang Phuong
--.Cau 1
use AdventureWorks2008
select Product.name, Product.ProductID
from Production.Product, Sales.SalesOrderDetail, Sales.SalesOrderHeader, Person.Address,
		Production.ProductCategory, Production.ProductSubcategory
where Product.ProductID= SalesOrderDetail.ProductID
and SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
and Address.AddressID= SalesOrderHeader.BillToAddressID
and Product.ProductSubcategoryID= ProductSubcategory.ProductSubcategoryID
and ProductSubcategory.ProductCategoryID= ProductCategory.ProductCategoryID

and Address.City= 'London'
and Month(SalesOrderHeader.OrderDate)= 5
and YEAR(SalesOrderHeader.OrderDate)= 2003
and ProductCategory.Name= 'Clothing'


--.Cau 2

select Production.Product.ProductID, Product.Name, SUM(SalesOrderHeader.TotalDue) as Total
from Production.Product, Sales.SalesOrderDetail, Sales.SalesOrderHeader
where Product.ProductID= SalesOrderDetail.ProductID
and SalesOrderDetail.SalesOrderID= SalesOrderHeader.SalesOrderID

and Convert(varchar(8), Product.SellStartDate, 112) > CONVERT(varchar(8), '2002-05', 112)
and CONVERT(varchar(8), SalesOrderHeader.OrderDate, 112) < CONVERT(varchar(8), '2004-10', 112)

group by Product.ProductID, Product.Name
having SUM(SalesOrderHeader.TotalDue) > 1000


--. Cau 3

select SalesOrderHeader.CustomerID, SalesOrderHeader.SalesOrderID, SalesOrderHeader.TotalDue
from Sales.Customer, Sales.SalesOrderHeader, Person.Address
where Customer.CustomerID= SalesOrderHeader.CustomerID
and SalesOrderHeader.BillToAddressID= Address.AddressID

and Address.City= 'Paris'
and year(SalesOrderHeader.OrderDate) = 2003

group by SalesOrderHeader.CustomerID, SalesOrderHeader.SalesOrderID, SalesOrderHeader.TotalDue
having count(SalesOrderHeader.SalesOrderID) > 5

--.Cau 4

select year(SOH.OrderDate), month(SOH.OrderDate)
from Production.Product as P, Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD
where P.ProductID in 
	(select top 5 Production.Product.ProductID
	from Production.Product, Sales.SalesOrderDetail, Sales.SalesOrderHeader
	where SalesOrderDetail.ProductID= Product.ProductID
	and SalesOrderHeader.SalesOrderID= SalesOrderDetail.SalesOrderID
	
	
	and year(SalesOrderHeader.OrderDate) in (2003, 2004)
	
	and month(SalesOrderHeader.OrderDate) in (4, 5, 6)
	
	and year(SalesOrderHeader.OrderDate) = YEAR(SOH.OrderDate)
	and month(SalesOrderHeader.OrderDate) = MONTH(SOH.OrderDate)
	
	
	
	
	group by Product.ProductID, SalesOrderHeader.OrderDate
	--.having 
	
	order by COUNT(SalesOrderHeader.SalesOrderID)
	
	)

order by month(SOH.OrderDate) 
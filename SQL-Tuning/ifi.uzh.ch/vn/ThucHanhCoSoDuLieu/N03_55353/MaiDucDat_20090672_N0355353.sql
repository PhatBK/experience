/*Phan 1*/
use AdventureWorks2008;
/*Cau 1*/
create index index1 on Sales.SalesOrderHeader(OrderDate)
create view view11 as
(
select OH.SalesOrderID
from Sales.SalesOrderHeader as OH
where (YEAR(OH.OrderDate)> 2002) or (YEAR(OH.OrderDate) = 2002 and MONTH(OH.OrderDate) >= 5)
)

go
create view view12 as
(
select distinct OD.ProductID
from Sales.SalesOrderDetail as OD
where OD.SalesOrderID in (select * from view11)
)

go
create index index2 on Production.Product(SellEndDate)

go
select P.ProductNumber, P.ListPrice, P.Name
from Production.Product as P
where P.ProductID in (select * from view12)
	and MONTH(P.SellEndDate) = 5 and YEAR(P.SellEndDate) = 2002

go	
drop view view11
go
drop view view12
go
drop index index1 on Sales.SalesOrderHeader
go
drop index index2 on Production.Product


/*Cau 2*/

create index index21 on Person.Address(City)
go
create view view21 as
(
select AD.AddressID 
from Person.Address as AD
where AD.City = 'London'
)

go
create index index22 on Sales.SalesOrderHeader(OrderDate)

go
create view view22 as
(
select OH.CustomerID, COUNT(OH.CustomerID) as TongSo
from Sales.SalesOrderHeader as OH
where OH.ShipToAddressID in (select * from view21)
	and YEAR(OH.OrderDate) = 2003
group by OH.CustomerID
having COUNT(OH.CustomerID) > 10
)
go
select OH.CustomerID, OH.SalesOrderID, OH.TotalDue
from Sales.SalesOrderHeader as OH
where OH.CustomerID in (select CustomerID from view22)
order by OH.CustomerID
	
go
drop view view21
go
drop view view22
go
drop index index21 on Person.Address
go
drop index index22 on Sales.SalesOrderHeader

/*Cau 3*/

create view view31 as
(
select AD.AddressID 
from Person.Address as AD
where AD.City = 'London'
)

go
create view view32 as
(
select P.ProductID
from Production.Product as P, Production.ProductCategory as PC, Production.ProductSubcategory as PSC
where P.ProductSubcategoryID = PSC.ProductSubcategoryID 
	and PC.ProductCategoryID = PSC.ProductCategoryID
	and PC.Name = 'Clothing'
)

go
create view view33 as
(
select OH.SalesOrderID
from Sales.SalesOrderHeader as OH
where MONTH(OH.OrderDate) = 5 and YEAR(OH.OrderDate) = 2003
	and OH.ShipToAddressID in (select * from view31)
)

go
select COUNT(*)
from Sales.SalesOrderDetail as OD
where OD.SalesOrderID in (select * from view33)
	
go
drop view view31
go
drop view view32
go
drop view view33
	
/*Cau 4*/

create view view41 as
(
select AD.AddressID 
from Person.Address as AD
where AD.City = 'London'
)

go
create view view42 as
(
select YEAR(OH.OrderDate) as Nam, MONTH(OH.OrderDate) as Thang, OD.ProductID, SUM(OD.OrderQty) as SoLuong
from Sales.SalesOrderHeader as OH, Sales.SalesOrderDetail as OD
where OH.SalesOrderID = OD.SalesOrderID
	and OH.BillToAddressID in (select * from view41)
	and MONTH(OH.OrderDate) >=4 and MONTH(OH.OrderDate) <= 6
	and (YEAR(OH.OrderDate) = 2003 or YEAR(OH.OrderDate) = 2004)
group by YEAR(OH.OrderDate), MONTH(OH.OrderDate),  OD.ProductID
)

go
create view view43 as
(
select DENSE_RANK () over (partition by V.Thang order by V.SoLuong desc) as STT, V.Nam, V.Thang, V.ProductID, V.SoLuong
from view42 as V
)

go
select *
from view43 as V
where V.STT <= 5
order by V.Thang

go
drop view view41
go
drop view view42
go
drop view view43
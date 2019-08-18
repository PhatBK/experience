/**********************Phan 1*********************************/
/**Cau 1**/
create view view1 as (
	select ProductID
	from  Production.Product
	where Month (SellEndDate) > 4 and YEAR(SellEndDate) >= 2002
)

select distinct PD.ProductNumber, PD.ListPrice, PD.Name
from Sales.SalesOrderDetail as SOD, Production.Product as PD, view1
where PD.ProductID NOT IN (select distinct ProductID  from Sales.SalesOrderDetail)
and PD.ProductID IN (select ProductID from view1)

/**Cau 2**/
go
create view view2 as (
	select Address.AddressID
	from Person.Address
	where City = 'Paris'
)

select * from view2
create view view3 as (
	select SOH.CustomerID
	from Sales.SalesOrderHeader as SOH
	group by SOH.CustomerID
	having COUNT(SOH.SalesOrderID) > 10
)

select SOH.CustomerID, SOD.SalesOrderID, SUM(SOD.OrderQty * SOD.UnitPrice) as GiatriDH
from Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD
where SOH.CustomerID IN (select CustomerID from view3)
and SOH.BillToAddressID IN (select AddressID from view2)
and SOH.SalesOrderID = SOD.SalesOrderID
and Year (SOH.ShipDate) = 2003
group by SOH.CustomerID, SOD.SalesOrderID

/**Cau 3**/
go

create view view4 as (
	select P.ProductID
	from Production.Product as P, Production.ProductSubcategory as PSC, Production.ProductCategory as PC
	where P.ProductSubcategoryID = PSC.ProductSubcategoryID
	and PSC.ProductSubcategoryID = PC.ProductCategoryID
	and PC.Name = 'Clothing'
)

select * from view4

create view view5 as (
	select AddressID
	from Person.Address
	where City = 'London'
)

select distinct SOD.ProductID
from Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD, view4, view5
where SOH.BillToAddressID IN (select AddressID from view5)
and SOH.SalesOrderID = SOD.SalesOrderID
and SOD.ProductID IN (select ProductID from view4)
and Month (SOH.ModifiedDate) = 5 and YEAR (SOH.ModifiedDate) = 2003


/**Cau 4**/

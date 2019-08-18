use AdventureWorks2008
--Phan 1
--Cau 1
select *
from Production.Product AS P,
	Production.ProductCategory AS PCat,
	Production.ProductSubcategory AS PSubCat,
	Person.Address AS PAdd,
	Sales.SalesOrderDetail AS SOD,
	Sales.SalesOrderHeader AS SOH
where P.ProductID = SOD.ProductID
and P.ProductSubcategoryID = PSubCat.ProductSubcategoryID
and PCat.ProductCategoryID = PSubCat.ProductCategoryID
and SOD.SalesOrderID = SOH.SalesOrderID
and PAdd.AddressID = SOH.BillToAddressID
and PAdd.City = 'London'
and YEAR(SOH.ShipDate) = 2003
and MONTH(SOH.ShipDate) = 05
--Cau 2
select P.ProductID, P.Name, SUM(SOD.LineTotal) AS 'Tong doanh thu'
from Production.Product AS P,
	Sales.SalesOrderDetail AS SOD,
	Sales.SalesOrderHeader AS SOH
where P.ProductID = SOD.ProductID
and SOD.SalesOrderID = SOH.SalesOrderID
and CONVERT(varchar(8),P.SellStartDate, 120)>CONVERT(varchar(8), '2002-05', 120)
and CONVERT(varchar(8),SOH.OrderDate, 120)<CONVERT(varchar(8), '2004-10', 120)
group by P.ProductID, P.Name
having SUM(SOD.LineTotal)>10000
--Cau 3
select SOH.CustomerID, SOH.SalesOrderID, SOH.TotalDue
from Sales.SalesOrderHeader AS SOH,
	Person.Address AS PAdd,
	Sales.Customer AS SCus
where PAdd.AddressID = SOH.BillToAddressID
and PAdd.City = 'Paris'
and YEAR(SOH.ShipDate)=2003
group by SOH.CustomerID, SOH.SalesOrderID, SOH.TotalDue
having COUNT(SOH.SalesOrderID)>5
--Cau 4
select Production.Product.ProductID
from Production.Product AS P,
	Person.Address AS PAdd
where PAdd.City = 'London'

--q1

use AdventureWorks2008
select COUNT(P.ProductID)
from Production.ProductCategory as PC,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Production.ProductSubcategory as PS,
	Production. Product as P,
	Person.Address  as A
	
where PS.ProductCategoryID=PC.ProductCategoryID
	and PS.ProductSubcategoryID=P.ProductSubcategoryID
	and P.ProductID = SOD.ProductID
	and SOD.SalesOrderID=SOH.SalesOrderID
	and A.AddressID=SOH.ShipToAddressID
	and PC.Name='Clothing'
	and A.City ='London'
	and YEAR(SOH.ModifiedDate)=2003
	and MONTH(SOH.ModifiedDate)=5
	
	
--q2
select p.ProductID, P.Name,SUM(SOD.LineTotal) as doanhthu
from Production. Product as P,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH
	where  SOD.SalesOrderID=SOH.SalesOrderID
		and SOD.ProductID = P.ProductID
		and SOD.SalesOrderID=SOH.SalesOrderID
		and (year(P.SellStartDate)>2002 or(YEAR(P.SellStartDate)=2002 and MONTH(P.SellStartDate)>=5))
		and (year(SOH.OrderDate)<2004 or(YEAR(SOH.OrderDate)=2004 and MONTH(SOH.OrderDate)<=10))
	group by P.ProductID,P.Name
	having SUM(SOD.LineTotal)>10000	
	
	
--q3
select soh.CustomerID,soh.SalesOrderID,soh.TotalDue,COUNT(SOH.SalesOrderID) as sohoadon
from 
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Production. Product as P,
	Person.Address  as A
	
where P.ProductID = SOD.ProductID
	and SOD.SalesOrderID=SOH.SalesOrderID
	and A.AddressID=SOH.ShipToAddressID
	and A.City ='Paris'
	and year(SOH.OrderDate)=2003
	and SOH.SalesOrderID in (select SOH.SalesOrderID
									from Sales.SalesOrderHeader as SOH,
										Person.Address  as A
									where  A.AddressID=SOH.ShipToAddressID
									and A.City ='Paris'
									
									)
	
group by SOH.CustomerID,soh.SalesOrderID,SOH.TotalDue
having COUNT(SOH.SalesOrderID)>5



/*1. */
select P.ProductID, P.Name, P.Color, P.ListPrice 
from Production.Product as P, Production.ProductSubcategory as PS, Production.ProductCategory as PC, Person.Address as A, Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD

where P.ProductSubcategoryID = PS.ProductSubcategoryID
	and PS.ProductCategoryID = PC.ProductCategoryID
	and P.ProductID = SOD.ProductID
	and SOH.SalesOrderID = SOD.SalesOrderID
	and SOH.ShipToAddressID = A.AddressID
	and A.City = 'LonDon'
	and PC.Name = 'Clothing'
	and MONTH(SOH.ShipDate) = 5
	and YEAR(SOH.ShipDate) = 2003
	
/*2. */
select P.ProductID,P.Name,P.ProductNumber, SUM(SOD.OrderQty*SOD.UnitPrice) as DoanhThu
from  Production.Product as P, Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD
where P.ProductID = SOD.ProductID
	and SOH.SalesOrderID = SOD.SalesOrderDetailID
	and MONTH(P.SellStartDate) = 5
	and YEAR(P.SellStartDate) = 2002
	and SOH.OrderDate <= '20041031'
	group by P.ProductID, P.Name,P.ProductNumber
	having SUM(SOD.OrderQty*SOD.UnitPrice) > 10000
	 
/*3. */
select C.CustomerID, SOH.SalesOrderID, OrderQty*UnitPrice
from Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD, Sales.Customer as C, Person.Address as A
where SOH.SalesOrderID = SOD.SalesOrderID
	and SOH.AccountNumber = C.AccountNumber
	and SOH.BillToAddressID = A.AddressID
	and A.City = 'Paris'
	and YEAR(SOH.ShipDate) = 2003
	group by C.CustomerID, SOH.SalesOrderID, OrderQty, UnitPrice
	having COUNT(SOH.SalesOrderID) >5
	
/*4. */
select *
from (
	select RANK() over(partition by MONTH(SOH.OrderDate) order by SUM(SOD.OrderQty) DESC) as R, P.ProductID, P.Name,MONTH(SOH.OrderDate),YEAR(SOH.OrderDate)
	from Production.Product as P, Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD, Person.Address as A
	where P.ProductID = SOD.ProductID
		and SOD.SalesOrderID =SOH.SalesOrderID
		and SOH.BillToAddressID = A.AddressID
		and A.City = 'LonDon'
		and ((MONTH(SOH.OrderDate) <= 6 and MONTH(SOH.OrderDate) > 3 and YEAR(SOH.OrderDate)= 2003) 
		or (MONTH(SOH.OrderDate) <= 6 and MONTH(SOH.OrderDate) > 3 and YEAR(SOH.OrderDate) = 2004))
	group by P.ProductID, P.Name, SOH.OrderDate, SOD.OrderQty	,MONTH(SOH.OrderDate),YEAR(SOH.OrderDate)
) as KQ
where KQ.R <=5

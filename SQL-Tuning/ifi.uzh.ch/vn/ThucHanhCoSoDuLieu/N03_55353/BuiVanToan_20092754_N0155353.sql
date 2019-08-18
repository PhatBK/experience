use AdventureWorks2008

-- Cau 1 :
select PP.ProductNumber, PP.Name,  PP.ListPrice 
from Production.Product as PP
where MONTH(PP.SellEndDate)=5
   and YEAR(PP.SellEndDate)=2002
   and PP.ProductID not in ( select ProductID from Sales.SalesOrderDetail)
   
-- Cau 2 :
select Result.CusID, SalH1.SalesOrderID, Result.Sums
from(
	select SalH.CustomerID as CusID, COUNT(SalH.SalesOrderID) as Nums, SUM(SalD.LineTotal) as Sums
	from Person.Address as PA, Sales.SalesOrderHeader as SalH, Sales.SalesOrderDetail as SalD
	where SalH.ShipToAddressID =PA.AddressID
	  and SalH.SalesOrderID = SalD.SalesOrderID
	  and PA.City='Paris'
	  and YEAR(SalH.OrderDate)=2003
	group by SalH.CustomerID
	) as Result, Sales.SalesOrderHeader as SalH1, Sales.SalesOrderDetail AS SalD1
where SalH1.SalesOrderID = SalD1.SalesOrderID
  and SalH1.CustomerID = Result.CusID
  and Result.Nums >10

-- Cau 3 :
select * 
from Sales.SalesOrderDetail as SaLD, Person.Address as PA
where 

-- Cau 4 :





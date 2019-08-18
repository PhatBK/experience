USE AdventureWorks2008
 --Cau 1:
 select p2.ProductNumber, p2.Name, p2.ListPrice 
from (select P.ProductID 
		from Production.Product as P,
			 Sales.SalesOrderDetail as Sod
		where  P.ProductID = Sod.ProductID
		   and P.SellEndDate<='20020530'
		   and P.SellEndDate>='20020501'
		group by p.ProductID 
	  ) as Result, Production.Product as P2
where Result.ProductID = P2.ProductID
--Cau 2:

Select SOH.CustomerID,count(SOH.SalesOrderID) from Sales.SalesOrderHeader as SOH
WHERE SOH.BillToAddressID IN(
SELECT AD.AddressID  FROM Person.Address as AD
where AD.City='Paris') 
and YEAR(SOH.BillToAddressID)=2003
group by CustomerID
having COUNT(SOH.SalesOrderID)>10





--Cau 3
select COUNT(Pc.ProductCategoryID) as num
from Production.Product as PP,
     Production.ProductCategory as PC,
     Production.ProductSubcategory as PS,
     Sales.SalesOrderHeader as SalH,
     Sales.SalesOrderDetail as SalD,
     Person.Address as PerA
where SalH.SalesOrderID = SalD.SalesOrderID
  and SalD.ProductID = PP.ProductID
  and PP.ProductSubcategoryID = Ps.ProductSubcategoryID
  and PS.ProductCategoryID = Pc.ProductCategoryID
  and SalH.ShipToAddressID = PerA.AddressID
  and PC.Name='Clothing'
  and PerA.City ='London'
  and ShipDate>='20030501'
  and ShipDate<='20030530'
  
  --Cau 4
  select  MONTH(SalH1.OrderDate) as months, SUM(SalD1.OrderQty) as Nums, SalD1.ProductID
from Person.Address as PerA1,
	 Sales.SalesOrderDetail as SalD1,
     Sales.SalesOrderHeader as SalH1
where SalD1.ProductID in(
			select top 5 SalD.ProductID
			from Person.Address as PerA,
				 Sales.SalesOrderDetail as SalD,
				 Sales.SalesOrderHeader as SalH
			where SalH.SalesOrderID = SalD.SalesOrderID
			  and SalH.BillToAddressID = PerA.AddressID
			  and PerA.City='London'
			  and Month(SalH.OrderDate)=Month(SalH1.OrderDate)
			  and YEAR(SalH.OrderDate)= YEAR( SalH1.OrderDate)
			group by SalD.ProductID, MONTH(SalH.OrderDate)
			order by Sum(SalD.OrderQty) desc
		) 
  and SalH1.SalesOrderID = SalD1.SalesOrderID
  and Month(SalH1.OrderDate) in (4,5,6)
  and Year(SalH1.OrderDate)= 2003 or YEAR(SalH1.OrderDate)=2004
group by SalD1.ProductID,YEAR(SalH1.OrderDate), MONTH(SalH1.OrderDate)
order by months, Nums
use AdventureWorks2008
-- Phan 1:
-- Câu 1 : 
select p2.ProductNumber, p2.Name, p2.ListPrice 
from (select P.ProductID, COUNT(Sod.SalesOrderID) as num_order
		from Production.Product as P,
			 Sales.SalesOrderDetail as Sod
		where  P.ProductID = Sod.ProductID
		   and MONTH(P.SellEndDate)='5'
		   and YEAR(P.SellEndDate)='2002' 
		group by p.ProductID 
	  ) as Result, Production.Product as P2
where Result.ProductID = P2.ProductID
  and Result.num_order = 0
  
 -- Câu 2 :
select Per.BusinessEntityID, SalH.SalesOrderID, SalH.TotalDue 
from Person.Person as Per,
	 Sales.Customer as SalC,
	 Person.Address as PerA,
	 Person.EmailAddress as PerE,
	 Sales.SalesOrderHeader as SalH
where (select P.ProductID, COUNT(Sod.SalesOrderID) as num_order
		from Production.Product as P,
			 Sales.SalesOrderDetail as Sod
		where  P.ProductID = Sod.ProductID
		   and MONTH(P.SellEndDate)='5'
		   and YEAR(P.SellEndDate)='2002' 
		group by p.ProductID 
	  ) as Result, Production.Product as P2)
  and Year(SalH.OrderDate)='2003'
  and PerA.City='Paris'
  and SalH.CustomerID = SalC.CustomerID
  and SalC.PersonID = Per.BusinessEntityID
  and Per.BusinessEntityID = PerE.BusinessEntityID
  and SalH.BillToAddressID=PerA.AddressID
order by EmailAddress

-- Câu 3 :
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
  and ShipDate>='05/01/2003'
  and ShipDate<='05/30/2003'
  --tang hieu nang cua cau truy van
  CREATE INDEX myindex ON Sales.SalesOrderHeader(ShipDate)
  DROP INDEX myindex ON Sales.SalesOrderHeader
  
  
  --cau 4
select P.ProductID
from AdventureWorks.Production.Product as P,
	AdventureWorks.Sales.SalesOrderDetail as SOD,
	AdventureWorks.Sales.SalesOrderHeader as SOH,
	AdventureWorks.Person.Address as A
where SOH.SalesOrderID = SOD.SalesOrderID
		and SOD.ProductID = P.ProductID
		and A.AddressID = SOH.ShipToAddressID
		and YEAR(SOH.ModifiedDate) = '2003'
		and MONTH(SOH.ModifiedDate) In(4, 5, 6)
		and YEAR(SOH.ModifiedDate) ='2004'
		and A.City = 'London'
Group by P.ProductID
Having COUNT(SOD.SalesOrderID) IN (Select top 5 COUNT(SOD.SalesOrderID)
										from AdventureWorks.Sales.SalesOrderDetail as SOD
										group by SOD.ProductID)
use AdventureWorks2008;

-- Phan 1:
-- Cau 1 : 
select P2.ProductNumber, P2.Name, P2.ListPrice 
from	(select	P.ProductID, COUNT(SOD.SalesOrderID) as num_order
		from Production.Product as P, Sales.SalesOrderDetail as SOD
		where P.ProductID = SOD.ProductID
		and MONTH(P.SellEndDate) = 5
		and YEAR(P.SellStartDate) = 2002 
		group by P.ProductID 
	  ) as Result, Production.Product as P2
where Result.ProductID = P2.ProductID
  and Result.num_order = 0

-- Câu 2 :
select distinct P.FirstName,  PE.EmailAddress, SOH.SalesOrderID, SOH.TotalDue 
from Person.Person as P,
	 Sales.Customer as C,
	 Person.Address as PA,
	 Person.EmailAddress as PE,
	 Sales.SalesOrderHeader as SOH,
	 (select COUNT(SalesOrderID) as num_order, CustomerID
	 from Sales.SalesOrderHeader
	 where YEAR(OrderDate) = 2003
	 group by CustomerID) as temp 
where temp.num_order > 10
  and PA.City = 'Paris'
  and temp.CustomerID = SOH.CustomerID
  and SOH.CustomerID = C.CustomerID
  and C.PersonID = P.BusinessEntityID
  and P.BusinessEntityID = PE.BusinessEntityID
  and SOH.ShipToAddressID = PA.AddressID
order by FirstName


-- Câu 3 :
select COUNT(PC.ProductCategoryID) as num
from Production.Product as P,
     Production.ProductCategory as PC,
     Production.ProductSubcategory as PS,
     Sales.SalesOrderHeader as SOH,
     Sales.SalesOrderDetail as SOD,
     Person.Address as PA
where SOH.SalesOrderID = SOD.SalesOrderID
  and SOD.ProductID = P.ProductID
  and P.ProductSubcategoryID = PS.ProductSubcategoryID
  and PS.ProductCategoryID = PC.ProductCategoryID
  and SOH.BillToAddressID = PA.AddressID
  and PC.Name='Clothing'
  and PA.City ='London'
  and MONTH(ShipDate) = 5
  and YEAR(ShipDate) = 2003
     



			


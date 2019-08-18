
use AdventureWorks2008;

-- PHAN 1

-- cau 1
select p.ProductNumber, p. ListPrice, p.Name
from Production.Product as p
where MONTH(p.SellEndDate) < 6 and YEAR(SellEndDate) < 2003

-- cau 2
select soh.CustomerID, soh.SalesOrderID, soh.TotalDue
from Sales.SalesOrderHeader as soh, Person.Address addr
where  soh.ShipToAddressID = addr.AddressID and  addr.City = 'Paris' and YEAR(soh.ModifiedDate) = 2003
       and soh.CustomerID IN (
                            select soh.CustomerID
                            from Sales.SalesOrderHeader as soh
                            group by soh.CustomerID      
                            having count(soh.SalesOrderID)>10        
                            )
                            
-- cau 3 
select count(sod.SalesOrderDetailID) as total
from Production.ProductSubcategory as pSubCat, Production.Product as p, 
      Sales.SalesOrderHeader as soh, Production.ProductCategory as pCat ,
      Sales.SalesOrderDetail as sod , Person.Address as addr
                                 
where pSubCat.ProductCategoryID = pCat.ProductCategoryID and p.ProductSubcategoryID = pSubCat.ProductSubcategoryID
      and  sod.SalesOrderID = soh.SalesOrderID and p.ProductID = sod.ProductID and addr.AddressID = soh.ShipToAddressID and      
      YEAR(sod.ModifiedDate) = 2003 and MONTH(sod.ModifiedDate) = 5 and addr.City = 'London' and pCat.Name = 'Clothing'
 group by pCat.Name
 
 -- cau 4
 with sumTable( OrderTotalNumber, pID )
 as ( select SUM(OrderQty) over (PARTITION BY (ProductID)) as OrderTotalNumber, ProductID as pID
       from Sales.SalesOrderDetail)
 
 select  Year(sod.ModifiedDate), MONTH(sod.ModifiedDate), sumTable.OrderTotalNumber 
 from Sales.SalesOrderDetail as sod , Person.Address as addr , Sales.SalesOrderHeader as soh,
        (select RANK() over ( partition by Year(sod.ModifiedDate), Month(sod.ModifiedDate) order by sumTable.OrderTotalNumber desc)
          from Sales.SalesOrderDetail as sod, sumTable) as numRecord
          
 where Year(sod.ModifiedDate) =2003 or Year(sod.ModifiedDate) =2004 and Month(sod.ModifiedDate) =4 or Month(sod.ModifiedDate) =5
       or Month(sod.ModifiedDate) = 6 and numRecord <6 and addr.City='LONDON'
 
 
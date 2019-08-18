USE AdventureWorks2008
 --Cau 1:
select PP.Name,PP.ListPrice,PP.ProductNumber
from Production.Product AS PP,(select SS.ProductID
                  from Sales.SalesOrderDetail AS SS
                  Group by SS.ProductID
                  Having COUNT(SS.SalesOrderDetailID) >50) AS PPP
where PP.ProductID IN 
                ( 
                    PPP.ProductID                  
                  )
 AND PP.SellStartDate > '20020501'
 
 --Cau 2:
 
 Select Per.LastName, PE.EmailAddress, SS.SalesOrderID,SS.TotalDue
 From Person.Person AS Per,Person.Address AS Ad, Sales.SalesOrderHeader AS SS,
       Person.BusinessEntityAddress AS PB ,Sales.Customer AS SC, Person.EmailAddress AS PE
 Where Per.BusinessEntityID = PB.BusinessEntityID
   AND PB.AddressID = Ad.AddressID
   And SC.PersonID = Per.BusinessEntityID
   And SS.CustomerID = SC.CustomerID
   And PE.BusinessEntityID = Per.BusinessEntityID
   AND SS.TotalDue > 1000
   AND Ad.City = 'London'
   ANd SS.OrderDate Between '20020101' and '20021231' 
   
   --Cau 3
   Select COUNT(PP.ProductID)
   From  Production.Product AS PP,Production.ProductSubcategory AS PSPC,
         Production.ProductCategory AS PPC, Sales.SalesOrderHeader AS SS ,
         Sales.SalesOrderDetail AS SSD, Person.Address AS Ad
   Where PP.ProductSubcategoryID = PSPC.ProductSubcategoryID
     AND PSPC.ProductCategoryID = PPC.ProductCategoryID
     AND PPC.Name = 'Clothing'
     AND PP.ProductID = SSD.ProductID
     AND SSD.SalesOrderID = SS.SalesOrderID
     AND SS.ShipToAddressID = Ad.AddressID
     AND Ad.City = 'London'
     And SS.OrderDate Between '20030501' and '20030531'
     
    -- Cau 4
    
   Select top(5)PP.ProductID
   From  Production.Product AS PP, Sales.SalesOrderHeader AS SS ,
         Sales.SalesOrderDetail AS SSD , Person.Address AS Ad
   Where 
     PP.ProductID = SSD.ProductID
     AND SSD.SalesOrderID = SS.SalesOrderID
     AND SS.BillToAddressID = Ad.AddressID
     AND Ad.City = 'London'
     And SS.OrderDate Between '20030801' and '20031231'
    
 
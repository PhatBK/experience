USE AdventureWorks2008
/* CAU 1 */

CREATE INDEX Address_Index ON Address(City )
DROP INDEX Address_Index ON Address

SELECT *
FROM Production.Product,Production.ProductCategory,Production.ProductSubcategory

WHERE ProductCategory.Name='Clothing'
AND  Product.ProductSubcategoryID=ProductSubcategory.ProductSubcategoryID
AND ProductCategory.ProductCategoryID=ProductSubcategory.ProductCategoryID
AND ProductID IN (SELECT ProductID
                  FROM Sales.SalesOrderDetail 
                  WHERE SalesOrderID IN (
                               SELECT SalesOrderID
                               FROM Sales.SalesOrderHeader
                               WHERE MONTH(ShipDate) =5
                               AND YEAR(ShipDate) =2003    
                               AND BillToAddressID IN ( 
                                           SELECT AddressID
                                           FROM Person.Address
                                           WHERE City ='LonDon'
                               
                               )              
                  
                  
                   )

                  
                 )
                 
                 
/* CAU 2 */


SELECT Product.ProductNumber, Product.Name
FROM Production.Product, Sales.SalesOrderDetail
WHERE MONTH(SellStartDate) =5 AND YEAR(SellStartDate) =2002 
OR YEAR(SellStartDate) >2002
AND Product.ProductID IN ( 

               SELECT ProductID
               FROM Sales.SalesOrderDetail
               WHERE SalesOrderID IN ( 
                     SELECT SalesOrderID
                     FROM Sales.SalesOrderHeader
                     WHERE SalesOrderHeader.TotalDue >1000
                     AND MONTH(OrderDate) = 4 AND YEAR(OrderDate)= 2004
                     OR YEAR(OrderDate) <2004
               
                )
                
                
)



/* CAU 3 */

SELECT CustomerID,SalesOrderID, TotalDue
FROM  Sales.SalesOrderHeader
WHERE BillToAddressID  IN ( 
                 SELECT AddressID
                 FROM Person.Address
                 WHERE City ='Paris'
                 )
                 
AND CustomerID IN (SELECT  CustomerID
                   FROM  Sales.SalesOrderHeader
                   GROUP BY CustomerID
                   HAVING COUNT(SalesOrderID) >5
                   )
AND YEAR(ShipDate) =2003


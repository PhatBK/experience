USE AdventureWorks2008 

select top 10 ProductNumber, Name , listprice
from Production.Product
order by listprice desc

select Person.FirstName,Person.LastName, Person.EmailPromotion, SalesOrderDetail.ProductID, SalesOrderDetail.UnitPrice
from Person.Person, Sales.SalesOrderHeader, Sales.SalesOrderDetail 
where
SalesOrderHeader.SalesOrderID=SalesOrderDetail.SalesOrderDetailID
and UnitPrice>10000 and OrderDate=2003
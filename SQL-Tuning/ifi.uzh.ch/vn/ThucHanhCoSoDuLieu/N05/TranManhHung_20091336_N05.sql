--phan 1:
--1:
select P.*
from Production.ProductCategory as PC,
	Production.ProductSubcategory as PS,
	Production.Product as P,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
where PC.ProductCategoryID=PS.ProductCategoryID and 
	PS.ProductSubcategoryID=P.ProductSubcategoryID and 
	P.ProductID=SOD.ProductID and
	SOD.SalesOrderID=SOH.SalesOrderID and 
	SOH.BillToAddressID=A.AddressID and 
	PC.Name='Clothing' and
	A.City='London' and 
	MONTH(ShipDate)=4 and YEAR(ShipDate)=2003
	
	
--2:

select P.ProductNumber,SOD.LineTotal,P.Name
from Production.Product as P ,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH
where P.ProductID=SOD.ProductID and 
	SOD.SalesOrderID=SOH.SalesOrderID and 
	P.SellStartDate>='20020501' and 
	SOH.OrderDate<='20041001'and
	SOD.LineTotal>10000
	
--3: 
select C.CustomerID, SOD.SalesOrderDetailID,SOH.TotalDue
from Person.Person as P ,
	Sales.Customer as C,
	Sales.SalesOrderDetail as SOD,
	Sales.SalesOrderHeader as SOH,
	Person.Address as A
where P.BusinessEntityID=C.CustomerID and
	C.CustomerID=SOH.CustomerID and
	SOH.SalesOrderID=SOD.SalesOrderID and
	SOH.ShipToAddressID=A.AddressID and
	A.City='Paris' and YEAR(SOH.OrderDate)=2003 
group by SOD.SalesOrderDetailID,SOH.TotalDue,C.CustomerID
having SUM(SOD.SalesOrderDetailID)>5
--
	
	
	
	
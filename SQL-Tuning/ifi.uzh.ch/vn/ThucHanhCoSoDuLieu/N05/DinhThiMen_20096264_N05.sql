/* thong ke cac san pham thuoc loai clothing ma hoa don thanh toan duoc gui den thanh pho London trong thang 5 nam 2003*/

select Production.Product.Name, Production.Product.ProductID
from Production.Product, Production.ProductCategory,Production.ProductSubcategory, Sales.SalesOrderHeader, Sales.SalesOrderDetail, Person.Address
where Production.Product.ProductSubcategoryID=Production.ProductSubcategory.ProductSubcategoryID
and Production.ProductSubcategory.ProductCategoryID= Production.ProductCategory.ProductCategoryID
and Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
and Sales.SalesOrderHeader.SalesOrderID= Sales.SalesOrderDetail.SalesOrderID
and Production.ProductCategory.Name like 'Clothing'
and Sales.SalesOrderHeader.BillToAddressID = Person.Address.AddressID 
and Person.Address.City like 'London'
and ShipDate like '5/*/2003'

/* cau 2 phan 1*/
select ProductNumber, Production.Product.Name,SalesOrderID, SUM(TotalDue)
from Production.Product, Sales.SalesOrderHeader, Sales.SalesOrderDetail
where Production.Product.ProductID=Sales.SalesOrderDetail.ProductID
and Sales.SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
and OrderDate ='5/*/2002',OrderDate = '10/31/2004'
group by Sales.SalesOrderHeader.SalesOrderID
having sum(TotalDue)> 10000

/* 3. dua ra danh sach khach hang co don hang gui toi Paris*/

select Sales.CustomerID, SalesOrderID, TotalDue, COUNT(SalesOrderID)
from Sales.Customer,Sales.SalesOrderHeader,Person.Address
where Sales.Customer.TerritoryID = Sales.SalesOrderHeader.TerritoryID
 and Sales.SalesOrderHeader.BillToAddressID = Person.Address.AddressID
 and Person.Address.City like 'Paris'
 and ShipDate  like '*/*/2003'
 group by Sales.CustomerID, 
 having COUNT(SalesOrderID)>5


/* cau 4 phan 1*/


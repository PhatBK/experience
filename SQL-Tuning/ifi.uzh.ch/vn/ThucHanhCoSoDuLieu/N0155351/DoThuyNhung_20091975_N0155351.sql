use AdventureWorks2008
----1.1
select TOP 10 ProductNumber, ListPrice, Name
from Production.Product, Sales.SalesOrderDetail
where SalesOrderDetail.ProductID=Product.ProductID
ORDER BY ListPrice DESC
----1.2
use AdventureWorks2008
select FirstName, MiddleName, LastName, EmailAddress, SalesOrderID, TotalDue
from Person.EmailAddress, Person.Person, Sales.SalesOrderHeader
where SalesOrderHeader.CustomerID=Person.BusinessEntityID
AND Person.BusinessEntityID=EmailAddress.BusinessEntityID
AND TotalDue > 100000
AND YEAR(OrderDate)=2003
----1.3
select SUM(OrderQty)
from Sales.SalesOrderDetail, Sales.SalesOrderHeader,
Production.ProductCategory, Production.Product, Person.Address
where SalesOrderDetail.ProductID=Product.ProductID
AND Product.ProductSubcategoryID=ProductCategory.ProductCategoryID
AND SalesOrderHeader.SalesOrderID=SalesOrderDetail.SalesOrderID
AND SalesOrderHeader.BillToAddressID=Address.AddressID
AND ProductCategory.Name='Clothing'
AND Address.City='London'
----1.4
----Danh chi so index
----1.1
IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idProduct')
    DROP INDEX idProduct ON Sales.SalesOrderDetail;

CREATE INDEX idProduct 
    ON Sales.SalesOrderDetail (ProductID);
----1.2
IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idCustomer')
    DROP INDEX idCustomer ON Sales.SalesOrderHeader;

CREATE INDEX idCustomer 
    ON Sales.SalesOrderHeader (CustomerID);

IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idBusiness')
    DROP INDEX idBusiness ON Person.EmailAddress;

CREATE INDEX idBusiness 
    ON Person.EmailAddress (idBusiness);
----1.3
IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idProduct')
    DROP INDEX idProduct ON Sales.SalesOrderDetail;

CREATE INDEX idProduct 
    ON Sales.SalesOrderDetail (ProductID);

IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idCategory')
    DROP INDEX idCategory ON Production.Product;

CREATE INDEX idCategory
    ON Production.Product (ProductSubcaterogyID);

IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idAddress')
    DROP INDEX idAddress ON Sales.SaleOrderHeader;

CREATE INDEX idAddress
    ON Sales.SaleOrderHeader (BilltoAddressID);

IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idName')
    DROP INDEX idName ON Production.Category;

CREATE INDEX idName
    ON Production.Category (Name);
    
IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = 'idCity')
    DROP INDEX idCity ON Person.Address;

CREATE INDEX idCity
    ON Person.City (City);
----1.4
----                                             




    

     
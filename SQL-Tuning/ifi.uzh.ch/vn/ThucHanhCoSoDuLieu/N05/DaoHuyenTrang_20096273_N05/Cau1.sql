use AdventureWorks2008;
select Product.Name
from Production.ProductCategory, Production.ProductSubCategory, Production.Product, Sales.SalesOrderDetail, Sales.SalesOrderHeader, Sales.SalesTerritory
where Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
and Production.ProductSubcategory.ProductSubcategoryID = Production.Product.ProductSubcategoryID
and Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
and Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
and Sales.SalesOrderHeader.TerritoryID = Sales.SalesTerritory.TerritoryID
and Sales.SalesTerritory.Name = 'London'
and Production.ProductCategory.Name = 'Clothing'
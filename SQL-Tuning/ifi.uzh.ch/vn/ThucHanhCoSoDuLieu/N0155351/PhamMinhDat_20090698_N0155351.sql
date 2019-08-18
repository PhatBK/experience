USE AdventureWorks2008;

/* Phan 1*/
--Cau 1:
SELECT	TOP  10 Product.ProductNumber,
		Product.ListPrice,
		Product.Name 
FROM	Sales.ShoppingCartItem,
		Production.Product
		
WHERE	Sales.ShoppingCartItem.ProductID = Production.Product.ProductID		
ORDER BY Product.ListPrice*ShoppingCartItem.Quantity DESC

--Cau 2
SELECT	Person.FirstName, 
		Person.LastName, 
		EmailAddress.EmailAddress, 
		Sales.SalesOrderHeader.SalesOrderID, 
		Sales.SalesOrderHeader.TotalDue
FROM	Sales.Customer, 
		Sales.SalesOrderHeader, 
		Person.Person, 
		Person.EmailAddress
WHERE	Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
		and Sales.Customer.CustomerID = Person.BusinessEntityID
		and Person.BusinessEntityID = EmailAddress.BusinessEntityID
		and Sales.SalesOrderHeader.TotalDue > 100000
		and YEAR(Sales.SalesOrderHeader.OrderDate) = 2003

--Cau 3:
SELECT	COUNT(*) as SoLuong
FROM	Person.Address,
		Sales.SalesOrderHeader,
		Sales.SalesOrderDetail, 
		Sales.SpecialOfferProduct, 
		Production.Product, 
		Production.ProductSubcategory, 
		Production.ProductCategory
WHERE	Person.Address.AddressID = Sales.SalesOrderHeader.BillToAddressID
		and Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
		and Sales.SalesOrderDetail.SpecialOfferID = Sales.SpecialOfferProduct.SpecialOfferID
		and Sales.SpecialOfferProduct.ProductID = Product.ProductID
		and Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
		and ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
		and ProductCategory.Name = 'Clothing'
		and Person.Address.City = 'London'
		

-- Cau 4
SELECT	top 5 ShoppingCartItem.ProductID, SUM(ShoppingCartItem.Quantity) as TongSoLuong
FROM	Sales.ShoppingCartItem
WHERE	YEAR(Sales.ShoppingCartItem.DateCreated) = 2003
		and MONTH(Sales.ShoppingCartItem.DateCreated) >= 4
		and MONTH(Sales.ShoppingCartItem.DateCreated) <= 7

GROUP BY  MONTH(Sales.ShoppingCartItem.DateCreated), Sales.ShoppingCartItem.ProductID




		
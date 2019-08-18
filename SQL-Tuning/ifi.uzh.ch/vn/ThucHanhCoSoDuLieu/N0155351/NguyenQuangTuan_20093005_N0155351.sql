USE AdventureWorks;
-- Cau 1:
SELECT TOP 10 
	Product.ProductNumber, Product.ListPrice, Product.Name
FROM Production.Product
WHERE Product.ProductID IN 
						( SELECT ProductID FROM Sales.SalesOrderDetail )
ORDER BY ListPrice DESC;
-- Cau 2:
SELECT Person.FirstName, Person.EmailPromotion, SalesOrderHeader.SalesOrderID, SalesOrderDetail.LineTotal
FROM Sales.Customer, Person.Person, Sales.SalesOrderHeader, Sales.SalesOrderDetail
WHERE	Customer.PersonID = Person.BusinessEntityID
		AND Customer.CustomerID = SalesOrderHeader.CustomerID
		AND SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
		AND SalesOrderDetail.LineTotal > 100.000
		AND YEAR(SalesOrderDetail.ModifiedDate) = 2003;
-- Cau 3:
SELECT COUNT(*)
FROM 
	(SELECT Product.ProductID
	FROM Production.Product, Production.ProductSubcategory, Production.ProductCategory, 
	Sales.SalesOrderDetail, Sales.SalesOrderHeader, Person.Address
	WHERE Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
			AND ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
			AND Product.ProductID = SalesOrderDetail.ProductID
			AND SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
			AND SalesOrderHeader.BillToAddressID = Address.AddressID
			AND ProductCategory.Name = 'Clothing'
			AND Address.City = 'London'
	GROUP BY Product.ProductID) as temp;
-- Cau 4: 
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID IN (
SELECT TOP 5 Product.ProductID
FROM Sales.SalesOrderDetail, Production.Product, Sales.SalesOrderHeader, Person.Address
WHERE	SalesOrderDetail.ProductID = Product.ProductID 
		AND SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
		AND SalesOrderHeader.BillToAddressID = Address.AddressID
		AND Address.City = 'London'
GROUP BY Product.ProductID
ORDER BY COUNT(Product.ProductID) DESC;


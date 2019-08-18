-- Phan 1 --
--- 1
SELECT	Product.ProductNumber, Product.ListPrice, Product.Name, Y, M
FROM(
	SELECT		SalesOrderDetail.ProductID AS ProductID,
				YEAR(SalesOrderHeader.OrderDate)AS Y, 
				MONTH(SalesOrderHeader.OrderDate) AS M
	FROM		Sales.SalesOrderHeader
	INNER JOIN	Sales.SalesOrderDetail 
		on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
	INNER JOIN Production.Product
		on Product.ProductID = SalesOrderDetail.ProductID
	WHERE		Product.SellStartDate > '20020430'
	GROUP BY	SalesOrderDetail.ProductID,
				YEAR(SalesOrderHeader.OrderDate),
				MONTH(SalesOrderHeader.OrderDate)	
	HAVING		COUNT(SalesOrderHeader.SalesOrderID) >  50
	) AS Tmp
	INNER JOIN Production.Product
		ON Tmp.ProductID = Product.ProductID
ORDER BY	Y ASC,
			M ASC

--- 2
SELECT	(Person.FirstName + COALESCE(' ' + Person.MiddleName, '') + ' ' + Person.LastName) [Full Name],
		EmailAddress.EmailAddress, SalesOrderHeader.SalesOrderID, SalesOrderHeader.TotalDue
FROM	Sales.SalesOrderHeader
		INNER JOIN	Person.Address 
			ON SalesOrderHeader.BillToAddressID = Address.AddressID
		INNER JOIN	Sales.Customer 
			ON SalesOrderHeader.CustomerID = Customer.CustomerID
		INNER JOIN	Person.Person 
			ON Customer.CustomerID = Person.BusinessEntityID
		INNER JOIN	Person.EmailAddress 
			ON EmailAddress.BusinessEntityID = Person.BusinessEntityID
WHERE	Address.City = 'London' 
	AND YEAR(SalesOrderHeader.OrderDate) = 2003	
	AND SalesOrderHeader.TotalDue > 1000
	
-- 3
SELECT	COUNT(*) AS [Tong So]
FROM	Sales.SalesOrderHeader
		INNER JOIN	Sales.SalesOrderDetail 
			ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
		INNER JOIN	Production.Product 
			ON SalesOrderDetail.ProductID = Product.ProductID
		INNER JOIN	Production.ProductSubcategory 
			ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
		INNER JOIN	Production.ProductCategory 
			ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
		INNER JOIN	Person.Address 
			ON SalesOrderHeader.ShipToAddressID = Address.AddressID
WHERE	ProductCategory.Name = 'Clothing' 
		AND Address.City = 'London' 
		AND YEAR(SalesOrderHeader.OrderDate) = 2003
		AND MONTH(SalesOrderHeader.OrderDate) = 5

--- 4
GO
WITH TmpTable
AS(
	SELECT	ProductID, [Thang], RANK() OVER(PARTITION BY [Thang] ORDER BY SUM(Qty) DESC) AS Rank, Qty
	FROM(
		SELECT	ProductID AS ProductID, MONTH(SalesOrderHeader.OrderDate) AS [Thang], SalesOrderDetail.OrderQty AS Qty
		FROM	Sales.SalesOrderHeader 
				INNER JOIN	Sales.SalesOrderDetail 
					ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
				INNER JOIN	Person.Address 
					ON SalesOrderHeader.BillToAddressID = Address.AddressID
		WHERE	Address.City = 'London'
				AND YEAR(SalesOrderHeader.OrderDate) = 2003
				AND ((MONTH(SalesOrderHeader.OrderDate)) / 3 = 2 
					OR  (MONTH(SalesOrderHeader.OrderDate)) / 3 = 3)				
	) AS Temp		
	GROUP BY  [Thang], ProductID, Qty
)
SELECT	*
FROM	TmpTable
WHERE	Rank < 6
GO
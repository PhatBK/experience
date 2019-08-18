--Cau 1
Select	COUNT(*) as [So Luong Hang]
From	Sales.SalesOrderDetail as Detail, Sales.SalesOrderHeader as Header,
		Production.Product, Production.ProductCategory,Production.ProductSubcategory,
		Person.Address as addr
Where	Detail.SalesOrderID=header.SalesOrderID
	and Detail.ProductID=Product.ProductID
	and Product.ProductSubcategoryID=ProductSubcategory.ProductSubcategoryID
	and ProductSubcategory.ProductCategoryID=ProductCategory.ProductCategoryID
	and Header.ShipToAddressID=addr.AddressID
	and ProductCategory.Name='Clothing'
	and YEAR(Header.ShipDate)='2003'
	and MONTH(Header.ShipDate)='5'
	and addr.City='London'
	
--Cau 2
Select	Product.ProductID, Product.Name,  TongDoanhThu ,Product.ProductNumber 
From 
	(	Select	Detail.ProductID, SUM(Detail.LineTotal)as TongDoanhThu
		From	Production.Product as Pro, Sales.SalesOrderDetail as Detail
		Where	Pro.ProductID = Detail.ProductID
		and		YEAR(Pro.SellStartDate) >= 2002 and YEAR(Pro.SellStartDate) <= 2004
		and		MONTH(Pro.SellStartDate)>= 5
		Group by Detail.ProductID
		Having	SUM(Detail.LineTotal)> 10000 ) as tmp, Production.Product
Where tmp.ProductID=Product.ProductID

-- Cau 3 
Select	CustomerID, SalesOrderHeader.SalesOrderID, SalesOrderHeader.TotalDue
From	Sales.SalesOrderHeader,
		(	Select  CustomerID as ID, COUNT(SalesOrderHeader.SalesOrderID)as T
			From	Person.Address,Sales.SalesOrderHeader 
			Where	Address.City = 'Paris'
			and		SalesOrderHeader.ShipToAddressID = Address.AddressID
			and		Year(SalesOrderHeader.ShipDate) = 2003
			Group by	CustomerID
			Having COUNT(SalesOrderHeader.SalesOrderID) >5)Tem
Where	Tem.ID = SalesOrderHeader.CustomerID




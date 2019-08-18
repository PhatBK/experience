--De 4--

--Cau 1--
USE AdventureWorks2008
SELECT Pro.ProductID
FROM Production.Product as Pro, Production.ProductCategory as ProCate,Production.ProductSubcategory as ProSub,
	Sales.SalesOrderDetail as SaleDe, Sales.SalesOrderHeader as SaleHe,
	Person.Address as Addr, Person.BusinessEntityAddress as Bus,Person.Person as Per,
	Sales.Customer as Cus
	
WHERE 
	Addr.City = 'London'
	AND MONTH(SaleHe.OrderDate) = 5 AND YEAR(SaleHe.OrderDate) = 2003
	AND ProCate.Name = 'Clothing'
	AND Pro.ProductSubcategoryID = ProSub.ProductSubCategoryID
	AND ProSub.ProductCategoryID = ProCate.ProductCategoryID
	AND Pro.ProductID = SaleDe.ProductID
	AND SaleHe.SalesOrderID = SaleDe.SalesOrderID
	AND SaleHe.CustomerID = Cus.CustomerID
	
	AND Cus.PersonID = Per.BusinessEntityID

	AND Bus.BusinessEntityID = Per.BusinessEntityID
	And Bus.AddressID = Addr.AddressID



--Cau3--
USE AdventureWorks2008
SELECT Cus.CustomerID, SaleHe.SalesOrderID, SaleHe.TotalDue
FROM Sales.SalesOrderDetail as SaleDe, Sales.SalesOrderHeader as SaleHe,
	Person.Address as Addr, Person.BusinessEntityAddress as Bus,Person.Person as Per,
	Sales.Customer as Cus

WHERE 
	Addr.City = 'Paris'
	AND YEAR(SaleHe.OrderDate) = 2003
	
	AND SaleHe.SalesOrderID = SaleDe.SalesOrderID
	AND SaleHe.CustomerID = Cus.CustomerID
	
	AND Cus.PersonID = Per.BusinessEntityID

	AND Bus.BusinessEntityID = Per.BusinessEntityID
	AND Bus.AddressID = Addr.AddressID
	
GROUP BY SaleHe.SalesOrderID,Cus.CustomerID,SaleHe.TotalDue
HAVING COUNT(SaleHe.SalesOrderID)>5


	
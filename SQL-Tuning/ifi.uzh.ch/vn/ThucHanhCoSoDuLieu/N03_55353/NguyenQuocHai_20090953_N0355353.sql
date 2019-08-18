Cau 1
--1--
Select P.ProductNumber, P.ListPrice, P.ProductNumber
From Production.Product AS P, Sales.SalesOrderDetail AS SOD
Where P.ProductID = SOD.ProductID
		and MONTH(P.SellEndDate) = 5
		and YEAR(P.SellEndDate)= 2002
		and P.ProductID NOT IN(Select SOD.ProductID
								From Sales.SalesOrderDetail AS SOD, Sales.SalesOrderHeader AS SOH
								Where SOH.OrderDate < '20020150'
										
	
--2--
Select SOH.CustomerID,SOH.SalesOrderID, SOH.TotalDue
From Person.Person AS PER, Person.EmailAddress AS E, 
		Sales.SalesOrderHeader AS SOH,
		Sales.Customer AS C,
		Person.Address AS A
Where SOH.CustomerID = C.CustomerID
		and C.PersonID = PER.BusinessEntityID
		and C.CustomerID = SOH.CustomerID
		and PER.BusinessEntityID = E.BusinessEntityID
		and A.AddressID = SOH.BillToAddressID
		and SOH.TotalDue > 10
		and YEAR(SOH.ModifiedDate) = 2003
		and A.City = 'Paris'
--3--
Select COUNT(P.ProductID)
From Sales.SalesOrderDetail AS SOD,
		Sales.SalesOrderHeader AS SOH,
		Production.Product AS P,
		Production.ProductCategory AS PC,
		Production.ProductSubcategory AS PG,
		Person.Address AS A
Where SOH.SalesOrderID = SOD.SalesOrderID
		and SOD.ProductID = P.ProductID
		and P.ProductSubcategoryID = PG.ProductSubcategoryID
		and PG.ProductCategoryID = PC.ProductCategoryID
		and SOH.BillToAddressID = A.AddressID
		and PC.Name = 'Clothing'
		and A.City = 'London'
		and MONTH(SOH.ModifiedDate) = 5
		and YEAR(SOH.ModifiedDate) = 2003 
		 
--4--
Select top 5 P.ProductID , 
From Sales.SalesOrderDetail AS SOD,
		Sales.SalesOrderHeader AS SOH,
		Person.Address AS A,
		Production.Product AS P
Where SOD.SalesOrderID = SOH.SalesOrderID
		and SOH.BillToAddressID = A.AddressID
		and P.ProductID = SOD.ProductID
		and A.City = 'London'
		and MONTH(SOH.ModifiedDate) IN (4,5,6)
		and YEAR(SOH.ModifiedDate) = 2003
Group by P.ProductID
having COUNT(SOD.SalesOrderID) IN ( Select top 5 COUNT(SOD.SalesOrderID)
									From Sales.SalesOrderDetail AS SOD
									Group by SOD.ProductID
									Order by  COUNT(SOD.SalesOrderID))
		
			
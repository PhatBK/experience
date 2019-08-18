use AdventureWorks2008
Select COUNT(SA.ProductID)
From Sales.SalesOrderHeader as SS, Person.Address as PA, Sales.SalesOrderDetail as SA
Where SS.BillToAddressID = PA.AddressID
and SS.SalesOrderID = SA.SalesOrderID
and PA.AddressLine1 = 'London'
and SA.ProductID in (
   Select PP.ProductID
   From Production.Product as PP, Production.ProductSubcategory as PPS, Production.ProductCategory as PPC
   Where PP.ProductSubcategoryID = PPS.ProductSubcategoryID
   and PPS.ProductCategoryID = PPC.ProductCategoryID
   and PPC.Name = 'Clothing'
   )
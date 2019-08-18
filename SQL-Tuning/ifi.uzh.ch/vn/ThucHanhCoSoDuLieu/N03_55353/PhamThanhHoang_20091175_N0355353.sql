use AdventureWorks2008
go
-- cau 1 Phan 1

-- cau 2 Phan 1
select C.CustomerID,SUM(SOH.TotalDue) from Sales.SalesOrderHeader as SOH,Sales.Customer as C,Person.Address as A where C.CustomerID = SOH.CustomerID and SOH.ShipToAddressID = A.AddressID and A.City = 'Paris' and month(SOH.OrderDate) = 2003 group by C.CustomerID having COUNT(SOH.SalesOrderID) > 10
-- cau 3 Phan 1
select COUNT(P.ProductID) from Person.Address as A ,Sales.SalesOrderHeader as SOH, Sales.SalesOrderDetail as SOD,Production.Product as P,Production.ProductCategory as PC, Production.ProductSubcategory as PSC where SOH.SalesOrderID = SOD.SalesOrderID and SOD.ProductID = P.ProductID and PSC.ProductCategoryID = P.ProductSubcategoryID and PSC.ProductCategoryID = PC.ProductCategoryID and SOH.BillToAddressID = A.AddressID and A.City = 'London' and PSC.Name = 'Clothing' and MONTH(SOH.OrderDate) = 5 and YEAR(SOH.OrderDate) = 2003

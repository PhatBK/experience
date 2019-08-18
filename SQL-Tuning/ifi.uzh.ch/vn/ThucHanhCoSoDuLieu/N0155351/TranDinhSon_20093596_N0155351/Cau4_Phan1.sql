use AdventureWorks2008
Select top 5 SA.ProductID
From Sales.SalesOrderHeader as SS, Person.Address as PA,
   Sales.SalesOrderDetail as SA
Where SS.BillToAddressID = PA.AddressID
and SS.SalesOrderID = SA.SalesOrderID
and MONTH(SS.DueDate) >3 and MONTH(SS.DueDate) < 7
and YEAR(SS.DueDate) = 2003
Group by SA.ProductID
order by  sum(SA.OrderQty) DESC
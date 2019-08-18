use AdventureWorks2008
Select PP.FirstName, PA.EmailAddress, SS.SalesOrderID, SS.TotalDue
From Sales.SalesOrderHeader as SS, Person.EmailAddress as PA, Person.Person as PP
Where PP.BusinessEntityID = PA.BusinessEntityID
and PP.BusinessEntityID = SS.BillToAddressID
and YEAR(DueDate) = 2003 and SS.TotalDue > 100000

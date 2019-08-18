use AdventureWorks2008
Select Top 10 PP.ProductNumber, PP.ListPrice, PP.Name
From Production.Product as PP
Order by PP.ListPrice DESC

use AdventureWorks2008

--1
SELECT TOP (10) P.ProductNumber, P.ListPrice, P.Name FROM Production.Product as P order by P.ListPrice DESC


--2
SELECT PP.FirstName, PP.MiddleName, PP.LastName, PE.EmailAddress, SS.SalesOrderID, SS.TotalDue FROM Person.Person as PP 
LEFT JOIN Sales.Customer as SC on PP.BusinessEntityID = SC.PersonID
LEFT JOIN Person.EmailAddress as PE ON PP.BusinessEntityID = PE.BusinessEntityID
LEFT JOIN Sales.SalesOrderHeader as SS 
ON SS.CustomerID = SC.CustomerID
where SS.TotalDue > 100000



--3

SELECT COUNT(SOD.SalesOrderDetailID) 
FROM Sales.SalesOrderDetail as SOD
LEFT JOIN Sales.SalesOrderHeader as SS
ON SOD.SalesOrderID = SS.SalesOrderID
LEFT JOIN Person.Address as PA ON SS.BillToAddressID = PA.AddressID

WHERE PA.City = 'London' and SOD.ProductID IN

(
SELECT PP.ProductID FROM Production.Product as PP
 LEFT JOIN Production.ProductSubcategory as PPS ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID
 LEFT JOIN Production.ProductCategory as PPC ON PPS.ProductCategoryID = PPC.ProductCategoryID
 WHERE PPC.Name = 'Clothing'
)


--4
SELECT * FROM (
SELECT PP.ProductID,  PP.Name,MONTH(SS.DueDate) as thang, DENSE_RANK () over (PARTITION BY MONTH(SS.DueDate) ORDER BY (SS.TotalDue))as ranks  FROM Production.Product as PP 
LEFT JOIN Sales.SalesOrderDetail as SOD 
	ON PP.ProductID = SOD.ProductID
LEFT JOIn Sales.SalesOrderHeader as SS 
	ON SOD.SalesOrderID = SS.SalesOrderID
WHERE YEAR(SS.DueDate) = 2003
and MONTH(SS.DueDate) between 4 and 6


)
as a
WHERE ranks < 6
ORDER BY thang
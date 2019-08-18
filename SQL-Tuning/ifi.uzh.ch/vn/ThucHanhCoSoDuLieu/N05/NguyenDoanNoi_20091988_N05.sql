--Phan 1 
--Cau 1
select P.ProductID, P.Name
from 
	Production.Product AS P,
	Production.ProductSubcategory AS PSC,
	Production.ProductCategory AS PC,
	Sales.SalesOrderDetail AS SOD,
	Sales.SalesOrderHeader As SOH,
	Person.Address AS A
where
	P.ProductSubcategoryID = PSC.ProductSubcategoryID
	AND PSC.ProductCategoryID = PC.ProductCategoryID
	AND P.ProductID = SOD.ProductID
	AND SOD.SalesOrderID = SOH.SalesOrderID
	AND SOH.BillToAddressID = A.AddressID
	AND PC.Name = 'Clothing'
	AND A.City = 'London'
	AND YEAR(SOH.OrderDate) = 2003
	AND MONTH(SOH.OrderDate) = 5
	
--Cau 2
select P.ProductID, SUM(SOH.TotalDue) AS 'SUM_TOTAL_DUE', P.Name
from 
	Production.Product AS P,
	Sales.SalesOrderDetail AS SOD,
	Sales.SalesOrderHeader As SOH
where
	P.ProductID = SOD.ProductID
	AND SOD.SalesOrderID = SOH.SalesOrderID
	AND ((YEAR(P.SellStartDate) = 2002 AND MONTH(P.SellStartDate) > = 5)
		OR (YEAR(P.SellStartDate) > 2002))
	AND ((YEAR(SOH.OrderDate) = 2004 AND MONTH(SOH.OrderDate) <= 10)
		OR (YEAR(SOH.OrderDate) < 2004))
group by P.ProductID, P.Name
having SUM(SOH.TotalDue) > 10000

--Cau 3
select C.CustomerID, SOH.SalesOrderID, SOH.TotalDue
from 
	Sales.Customer AS C,
	Sales.SalesOrderHeader AS SOH,
	Person.Address AS A
where 
	C.CustomerID = SOH.CustomerID
	AND SOH.BillToAddressID = A.AddressID
	AND A.City = 'Paris'
	AND YEAR(SOH.OrderDate) = 2003
group by C.CustomerID, SOH.SalesOrderID, SOH.TotalDue
having COUNT(SOH.SalesOrderID) > 5

--Cau 4
select *
from (
		select distinct
			(COUNT(SOH.SalesOrderID) OVER (PARTITION BY YEAR(SOH.OrderDate), MONTH(SOH.OrderDate), P.ProductID)) AS NUM_ORDER,
			(RANK() OVER (PARTITION BY P.ProductID ORDER BY NUM_ORDER DESC)) AS R,
			P.ProductID AS PID , MONTH(SOH.OrderDate) AS mMonth, YEAR(SOH.OrderDate) AS mYear                                                                                                                                                                                                                              
		from 
			Person.Address AS A,
			Sales.SalesOrderHeader AS SOH,
			Sales.SalesOrderDetail SOD,
			Production.Product AS P
		where 
			A.AddressID = SOH.BillToAddressID
			AND SOH.SalesOrderID = SOD.SalesOrderID
			AND P.ProductID = SOD.ProductID
			AND YEAR(SOH.OrderDate) IN (2003, 2004)
			AND MONTH(SOH.OrderDate) IN (4, 5, 6)
		order by mYear, mMonth DESC
	)
where R <= 5
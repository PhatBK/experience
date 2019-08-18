use AdventureWorks2008Old
--Cau 1:--
select	P.ProductNumber,P.ListPrice,P.Name
from	Production.Product as P
where	ProductID in(
select ProductID
from Sales.SalesOrderDetail
group by ProductID
having COUNT(Sales.SalesOrderDetail.SalesOrderID)=0
)
and
YEAR(P.SellEndDate)=2002
and	MONTH(P.SellEndDate)=5


--Cau 2:--
SELECT	CustomerID,S.SalesOrderID,S.SubTotal
FROM	Sales.SalesOrderHeader as S,
		Person.Address as A
WHERE	S.ShipToAddressID=A.AddressID
	AND A.City='Paris'
	AND YEAR(S.OrderDate)=2003
group by CustomerID,S.SalesOrderID,S.SubTotal
having COUNT(S.SalesOrderID)>=10

--Cau 3:--
SELECT	COUNT(P.ProductID)
FROM	Production.Product as P,Production.ProductCategory as PC,
		Production.ProductSubcategory as PSC,Sales.SalesOrderDetail as SOD,
		Sales.SalesOrderHeader as SOH,Person.Address as A
WHERE	P.ProductSubcategoryID=PSC.ProductSubcategoryID
	AND PSC.ProductCategoryID=PC.ProductCategoryID
	AND P.ProductID=SOD.ProductID
	ANd SOD.SalesOrderID=SOH.SalesOrderID
	AND SOH.BillToAddressID=A.AddressID
	AND YEAR(SOH.OrderDate)=2003
	AND MONTH(SOH.OrderDate)=5
	ANd PC.Name='Clothing'                                                     
	AND A.City='London'
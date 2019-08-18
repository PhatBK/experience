use AdventureWorks2008

/*1. Dua ra danh sach cac nhan hang ket thuc ban tu thang 5 2002
	 ma truoc do ko co don hang
*/
select P.ProductNumber, P.ListPrice, P.Name
from Production.Product P
where ProductID IN (
	select ProductID
	from Sales.SalesOrderDetail SOD
	group by SOD.ProductID
	having  COUNT(SOD.SalesOrderID) = 0		
		AND MONTH(P.SellEndDate) = 5
		AND YEAR(P.SellEndDate) = 2002			
	)
	
/*2. Dua ra danh sach thong tin cac khach hang co tren 10 don hang
	 gui tu thanh pho "Paris" trong nam 2003
*/
select C.CustomerID as CusID, TG.SalesOrderID , TG.TotalDue 
from Sales.Customer C, (select SOH.CustomerID cid,SOH.SalesOrderID,SOH.TotalDue
	from Sales.SalesOrderHeader SOH, Person.Address A
	where SOH.ShipToAddressID = A.AddressID
		  AND A.City = 'Paris'		
	group by SOH.CustomerID
	having COUNT(SOH.SalesOrderID) > 10		
		  AND YEAR(SOH.OrderDate) = 2003		   
	) AS TG
where C.CustomerID = TG.cid
order by CusID

/*3.thong ke co bao nhieu sp thuoc loai clothing ma hoa don gui den london "London" thang 5 2003

*/
select COUNT(TG.productID) countProduct
from (
	select P.ProductID productID
	from Production.Product P, Production.ProductCategory PC, 
		Production.ProductSubcategory PS
	where PC.Name='Clothing' and PC.ProductCategoryID = PS.ProductCategoryID
      and PS.ProductSubcategoryID = P.ProductSubcategoryID) TG, 
		Sales.SalesOrderDetail SOD, Sales.SalesOrderHeader SOH, Person.Address A
where SOD.ProductID = TG.productID and SOD.SalesOrderID = SOH.SalesOrderID
	  and YEAR(SOH.OrderDate) = 2003 and MONTH(SOH.OrderDate) = 5 and 
	  (SOH.BillToAddressID = A.AddressID) and A.City = 'London'

/*4.Dua ra top 5 san pham duoc dat hang nhieu nhat tung thang cua quy 2 nam 2003 va nam 2004

*/

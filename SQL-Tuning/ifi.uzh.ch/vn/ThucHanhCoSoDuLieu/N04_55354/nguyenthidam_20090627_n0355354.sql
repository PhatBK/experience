-- bai 1: y 3
select SUM(D.OrderQty)
from Sales.SalesOrderDetail D, Sales.SalesOrderHeader H,  Production.Product P, Person.Address A, Production.ProductCategory C, Production.ProductSubcategory S
where D.SalesOrderID = H.SalesOrderID
and D.ProductID = P.ProductID
and P.ProductSubcategoryID = S.ProductSubcategoryID
and S.ProductCategoryID = C.ProductCategoryID
and H.BillToAddressID = A.AddressID
and A.City = 'London'
and C.Name = 'Clothing'
and YEAR(H.OrderDate) = 2003
and MONTH(H.OrderDate) = 5


-- bai 1 y 2

select H.CustomerID, H.SalesOrderID, SUM(D.LineTotal) giatri
from Sales.SalesOrderHeader H, Sales.SalesOrderDetail D, (select H.CustomerID
		from Sales.SalesOrderHeader H, Person.Address A
		where H.ShipToAddressID = A.AddressID
		and YEAR(H.OrderDate) = 2003
		and A.City = 'Paris'
		group by H.CustomerID
		having COUNT(H.SalesOrderID) > 10) khachhang
where H.SalesOrderID = D.SalesOrderID
and H.CustomerID = khachhang.CustomerID
group by H.CustomerID, H.SalesOrderID


-- bai 1 y 4
select ProductID, YEAR(H.OrderDate), MONTH(H.OrderDate), COUNT(D.OrderQty) soluong, RANK() over (partition by month(H.OrderDate), year(H.OrderDate) order by count(D.OrderQty) desc) hang
from Sales.SalesOrderDetail D, Sales.SalesOrderHeader H, Person.Address A
where D.SalesOrderID = H.SalesOrderID
and H.BillToAddressID = A.AddressID
and A.City = 'London'
and (YEAR(H.OrderDate) = 2003
or YEAR(H.OrderDate) = 2004)
and MONTH(H.OrderDate) between 4 and 6
group by YEAR(H.OrderDate), MONTH(H.OrderDate), ProductID
Order by YEAR(H.OrderDate) desc, MONTH(H.OrderDate) desc,COUNT(D.OrderQty) desc

select *
from (select ProductID, YEAR(H.OrderDate), MONTH(H.OrderDate), COUNT(D.OrderQty) soluong, RANK() over (partition by month(H.OrderDate), year(H.OrderDate) order by count(D.OrderQty) desc) hang
from Sales.SalesOrderDetail D, Sales.SalesOrderHeader H, Person.Address A
where D.SalesOrderID = H.SalesOrderID
and H.BillToAddressID = A.AddressID
and A.City = 'London'
and (YEAR(H.OrderDate) = 2003
or YEAR(H.OrderDate) = 2004)
and MONTH(H.OrderDate) between 4 and 6
group by YEAR(H.OrderDate), MONTH(H.OrderDate), ProductID
Order by MONTH(H.OrderDate) desc,YEAR(H.OrderDate) desc, COUNT(D.OrderQty) desc) ketqua
where ketqua.hang < 6
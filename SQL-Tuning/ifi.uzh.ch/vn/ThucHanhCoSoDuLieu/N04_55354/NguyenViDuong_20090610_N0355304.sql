-- Phan 1

--cau 1
select product.ProductNumber, product.ListPrice, product.Name
from ( select P.ProductID as PID
	from Sales.SalesOrderDetail D, Sales.SalesOrderHeader H, Production.Product P, Sales.SpecialOfferProduct S
where D.SalesOrderID = H.SalesOrderID
and P.ProductID = S.ProductID
and S.ProductID = D.ProductID
and (H.OrderDate) > 5/2002
group by D.SalesOrderID, P.ProductID
having SUM(D.OrderQty) > 50
) P, Production.Product product
where product.ProductID = P.PID

-- cau 2

select P.FirstName, P.LastName, E.EmailAddress, Cus.madonhang, Cus.giatri
from ( select H.CustomerID CID, D.SalesOrderID madonhang, SUM(D.LineTotal) giatri 
from Sales.SalesOrderDetail D, Sales.SalesOrderHeader H, Person.Person P, Person.EmailAddress E, Sales.Customer C, Person.Address A
where D.SalesOrderID = H.SalesOrderID
and H.CustomerID = C.CustomerID
and C.PersonID = P.BusinessEntityID
and P.BusinessEntityID = E.BusinessEntityID
and H.BillToAddressID = A.AddressID
and Year(H.OrderDate) = 2003
and A.City = 'London'
group by D.SalesOrderID, H.CustomerID
having SUM(D.LineTotal) > 1000 ) Cus, Person.Person P, Person.EmailAddress E, Sales.Customer C
where Cus.CID = C.CustomerID
and C.PersonID = P.BusinessEntityID
and P.BusinessEntityID = E.BusinessEntityID

-- cau 3

select SUM(D.OrderQty)
from Sales.SalesOrderDetail D, Sales.SalesOrderHeader H, Production.Product P, Production.ProductCategory C, Production.ProductSubcategory SC, Person.Address A
where D.SalesOrderID = H.SalesOrderID
and D.ProductID = P.ProductID
and P.ProductSubcategoryID = SC.ProductSubcategoryID
and SC.ProductCategoryID = C.ProductCategoryID
and H.BillToAddressID = A.AddressID
and C.Name = 'Clothing'
and A.City = 'London'
and YEAR(H.OrderDate) = 2003
and MONTH(H.OrderDate) = 5


-- cau 4

select kq.*
from ( select D.ProductID idProduct, MONTH(S.OrderDate) Thang, SUM(D.OrderQty) Tong, RANK() over(partition by MONTH(S.OrderDate) order by SUM(D.OrderQty)desc) hang 
from Sales.SalesOrderDetail D, Sales.SalesOrderHeader S
where D.SalesOrderID = S.SalesOrderID
and YEAR(S.OrderDate) = 2003
and MONTH(S.OrderDate) between 4 and 9
group by D.ProductID, MONTH(S.OrderDate)) kq
where kq.hang between 1 and 5

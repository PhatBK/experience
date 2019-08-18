
use AdventureWorks2008
--cau 1
select distinct Top(10) sp.ProductNumber,sp.ListPrice,sp.Name
from Production.Product as sp,Sales.SalesOrderDetail as cthd
where sp.ProductID=cthd.ProductID
order by sp.ListPrice desc


--cau 2
select ng.FirstName,ng.LastName,ng.MiddleName,cthd.SalesOrderID,cthd.LineTotal
from Sales.SalesOrderHeader as hddh join Sales.SalesOrderDetail as cthd 
on hddh.SalesOrderID=cthd.SalesOrderDetailID join Sales.Customer as kh
on hddh.CustomerID=kh.CustomerID join Person.Person as ng
on kh.CustomerID=ng.BusinessEntityID left join Person.EmailAddress as em
on ng.EmailPromotion=em.EmailAddressID
where cthd.LineTotal>10000 and YEAR(cthd.ModifiedDate)=2003


--cau 3
select  COUNT(*)
from (select cate.ProductCategoryID from Production.ProductCategory as cate where cate.Name='clothing')
as clo join Production.ProductSubcategory as subcate on clo.ProductCategoryID=subcate.ProductCategoryID 
join Production.Product as spham on spham.ProductSubcategoryID= subcate.ProductSubcategoryID
join Sales.SalesOrderDetail as cthd on spham.ProductID=cthd.ProductID 
join Sales.SalesOrderHeader as hdhd on cthd.SalesOrderID=hdhd.SalesOrderID
join (Select dchi.AddressID from Person.Address as dchi where dchi.City='London') as ad on ad.AddressID=hdhd.ShipToAddressID

--cau 4


use AdventureWorks2008Old

select p.ProductNumber, p.ListPrice, p.Name
from Production.Product as p
where p.SellEndDate >= '200202001'

-- Cau 2
select CustomerID, COUNT(SalesOrderID) as soDonHang
from
(
select CustomerID, SalesOrderID
from Sales.SalesOrderHeader
where YEAR(ModifiedDate) = '2003'
) as temp
group by temp.CustomerID


select *
from Person.Address as Addr, Sales.SalesOrderHeader as Sal, Sales.Customer
where Addr.AddressID = Sal.BillToAddressID and
		Sal.CustomerID = Customer.CustomerID and
		Addr.City='Paris' and
		year(Sal.ModifiedDate)='2003'
group by Sal.CustomerID	
having count(Sal.SalesOrderID) > 10


from Production.Product

select AddressID
from Person.Address
where City='Paris'
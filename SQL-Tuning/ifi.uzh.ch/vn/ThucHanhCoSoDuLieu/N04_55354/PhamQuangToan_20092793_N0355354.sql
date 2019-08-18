use AdventureWorks2008
go

/* cau truy van 1 */

select Product.Name, Product.StandardCost ,Product.ProductNumber 
from 
(select detail.ProductID
from Production.Product as pro, Sales.SalesOrderDetail as detail
where pro.ProductID = detail.ProductID
	and YEAR(pro.SellStartDate)='2002'
	and MONTH(pro.SellStartDate)='5'
group by detail.ProductID
having COUNT(detail.SalesOrderID)>50) as tmp, Production.Product
where tmp.ProductID=Product.ProductID

/*cau truy van 2*/
select per.FirstName+per.LastName [name],EmailAddress.EmailAddress, header.SalesOrderID, header.TotalDue
from Sales.SalesOrderHeader as header, Person.Address as addr, Person.Person as per, Sales.Customer as cus,
	Person.BusinessEntityAddress, Person.EmailAddress
where YEAR(header.OrderDate)='2003'
	and addr.City='London' 
	and header.CustomerID = cus.CustomerID
	and cus.PersonID=per.BusinessEntityID
	and per.BusinessEntityID=Person.BusinessEntityAddress.BusinessEntityID
	and Person.BusinessEntityAddress.AddressID=addr.AddressID
	and per.BusinessEntityID=Person.EmailAddress.BusinessEntityID
	and header.TotalDue>1000
order by per.BusinessEntityID

/*cau truy van 3*/
select COUNT(*) as [so hang]
from Sales.SalesOrderDetail as detail, Sales.SalesOrderHeader as header,
	 Production.Product, Production.ProductCategory,Production.ProductSubcategory,
	 Person.Address as addr
where detail.SalesOrderID=header.SalesOrderID
	and detail.ProductID=Product.ProductID
	and Product.ProductSubcategoryID=ProductSubcategory.ProductSubcategoryID
	and ProductSubcategory.ProductCategoryID=ProductCategory.ProductCategoryID
	and header.ShipToAddressID=addr.AddressID
	and ProductCategory.Name='Clothing'
	and YEAR(header.ShipDate)='2003'
	and MONTH(header.ShipDate)='5'
	and addr.City='London'
	 



/*cau truy van 4*/
select tmp.ProductID
from
(select detail.ProductID, 
	DENSE_RANK() over(order by sum(detail.OrderQty) DESC) [rowno]
from Sales.SalesOrderDetail as detail, Sales.SalesOrderHeader as header, Person.Address as addr
where detail.SalesOrderID=header.SalesOrderID
	and header.BillToAddressID=addr.AddressID
	and addr.City='London'
	and YEAR(header.OrderDate)='2003'
	and MONTH(header.OrderDate)>3
	and MONTH(header.OrderDate)<10
group by detail.ProductID) as tmp
where tmp.rowno<6



/*truy van bai 2*/
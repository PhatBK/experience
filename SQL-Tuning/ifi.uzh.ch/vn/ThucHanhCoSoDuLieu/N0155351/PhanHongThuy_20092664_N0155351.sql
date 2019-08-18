use AdventureWorks2008
go
--bai 1
select  Production.Product.ProductNumber, Production.Product.ListPrice, Production.Product.Name
from Production.Product
where ListPrice = (select MAX(Production.Product.ListPrice)
						from Production.Product)
--bai 2
select pp.FirstName, pp.LastName, pe.EmailAddress,ss.SalesOrderID,ss.TotalDue
from Sales.Customer sc, Person.Person pp, Person.EmailAddress pe, 
		Sales.SalesOrderHeader ss
where sc.PersonID = pp.BusinessEntityID
	and pp.BusinessEntityID = pe.BusinessEntityID
	and sc.CustomerID = ss.CustomerID
	and ss.TotalDue >100000
	and year(ss.ModifiedDate)= 2003
--bai 3
select COUNT(prp.ProductID)
from Production.ProductCategory prpc, Production.ProductSubcategory prpsc,
	Production.Product prp, Sales.SalesOrderDetail ssd,
	Sales.SalesOrderHeader ssh, Sales.Customer sc, 
	Person.Person pp, Person.BusinessEntity pb, Person.BusinessEntityAddress pba,
	Person.Address pa
where prpc.ProductCategoryID = prpsc.ProductCategoryID
	and prpsc.ProductSubcategoryID = prp.ProductSubcategoryID
	and prp.ProductID = ssd.ProductID
	and ssd.SalesOrderID = ssh.SalesOrderID
	and ssh.CustomerID = sc.CustomerID
	and sc.PersonID = pp.BusinessEntityID
	and pp.BusinessEntityID = pb.BusinessEntityID
	and pb.BusinessEntityID = pba.BusinessEntityID
	and pba.AddressID = pa.AddressID
	and pa.City = 'london'
	and prpc.Name = 'clothing'
--bai 4
select prp.ProductID
from Production.Product prp, Sales.SalesOrderDetail ssd,
	Sales.SalesOrderHeader ssh, Sales.Customer sc,
	Person.Person pp, Person.BusinessEntity pb, Person.BusinessEntityAddress pba,
	Person.Address pa
where prp.ProductID = ssd.ProductID
	and ssd.SalesOrderID = ssh.SalesOrderID
	and ssh.CustomerID = sc.CustomerID
	and pp.BusinessEntityID = pb.BusinessEntityID
	and pb.BusinessEntityID = pba.BusinessEntityID
	and YEAR(ssd.ModifiedDate) = 2003
	and MONTH(ssd.ModifiedDate)>3 
	and MONTH(ssd.ModifiedDate)<7
	and pa.City = 'london'

use AdventureWorks2008;

create index indexProductCategoryName  on Production.ProductCategory(Name);
create index indexAddressCity on Person.Address(City);

go
/* 3 */
select COUNT(ProductID) from (

	select distinct pp.ProductID from Production.Product as pp, Production.ProductCategory as ppc, Production.ProductSubcategory as pps,
						Sales.SalesOrderDetail as ssod, Sales.SalesOrderHeader as ssoh, Person.Address as pa
	where pp.ProductSubcategoryID = pps.ProductSubcategoryID and
		pps.ProductCategoryID = ppc.ProductCategoryID and
		ppc.Name = 'Clothing' and
		pp.ProductID = ssod.ProductID and
		ssod.SalesOrderID = ssoh.SalesOrderID and
		ssoh.ShipToAddressID = pa.AddressID and
		pa.City = 'London'
) as pid;

drop index indexProductCategoryName  on Production.ProductCategory;
drop index indexAddressCity on Person.Address;
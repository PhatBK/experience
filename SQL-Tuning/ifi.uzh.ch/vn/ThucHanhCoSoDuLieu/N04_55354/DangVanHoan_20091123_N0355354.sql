use AdventureWorks2008;
/*cau 1 phan 1*/
select Production.Product.Name, Production.Product.ProductNumber,Production.Product.ListPrice
From Production.Product
where Production.Product.ProductID in 
	(Select Sales.SalesOrderDetail.SalesOrderDetailID
	 From	Sales.SalesOrderDetail
	 where  Sales.SalesOrderDetail.SalesOrderID in
	 (Select Sales.SalesOrderHeader.SalesOrderID 
	 from Sales.SalesOrderHeader
	 group by Sales.SalesOrderHeader.SalesOrderID
	 having COUNT(Sales.SalesOrderHeader.SalesOrderID) >50))
	 		 
and DATEPART(YEAR,Production.Product.SellStartDate)	=2002
and DATEPART(MONTH,Production.Product.SellStartDate)	=5;			

/*cau 3 phan 1*/
select COUNT(Production.Product.ProductID)
From Production.Product
where Production.Product.ProductSubcategoryID in
	 (select Production.ProductSubcategory.ProductSubcategoryID
	 From Production.ProductSubcategory
	 Where Production.ProductSubcategory.ProductCategoryID in 
		(select Production.ProductCategory.ProductCategoryID
		From Production.ProductCategory
		where Production.ProductCategory.Name ="Clothing"))
and DATEPART(YEAR,Production.Product.SellStartDate)	=2003
and DATEPART(MONTH,Production.Product.SellStartDate)	=5
and
					

use AdventureWorks2008;
select Production.Product.ProductNumber, Production.Product.Name, 
from Production.Product
where Production.Product.SellStartDate like '2002-05%'

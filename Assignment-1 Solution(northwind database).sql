/* Assignment-1 */

--q-1  Write a query to get a Product list (id, name, unit price) where current products cost less than $20. 
select ProductID, ProductName, UnitPrice from dbo.Products 
where UnitPrice < 20;

--q-2  Write a query to get Product list (id, name, unit price) where products cost between $15 and $25 
select ProductID, ProductName, UnitPrice from dbo.Products
where UnitPrice Between 15 and 25;

--q-3  Write a query to get Product list (name, unit price) of above average price.  
SELECT ProductName, UnitPrice from dbo.Products
where UnitPrice > (select avg(UnitPrice) from dbo.Products);

--q-4  Write a query to get Product list (name, unit price) of ten most expensive products 
SELECT TOP 10 ProductName, UnitPrice FROM dbo.ProductsORDER BY UnitPrice DESC; 

--q-5  Write a query to count current and discontinued products 
select count(ProductName) from dbo.products 
where Discontinued=0;  --for current products 

select count(ProductName) from dbo.products 
where Discontinued=1;  --for discontinued products 

--q-6  Write a query to get Product list (name, units on order, units in stock) of stock is less than the quantity on order 
select ProductName, UnitsOnOrder, UnitsInStock from dbo.products
where UnitsInStock < UnitsOnOrder;

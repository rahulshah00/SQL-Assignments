/*
1. Create a stored procedure in the Northwind database that will calculate the average 
value of Freight for a specified customer.Then, a business rule will be added that will 
be triggered before every Update and Insert command in the Orders controller,and 
will use the stored procedure to verify that the Freight does not exceed the average 
freight. If it does, a message will be displayed and the command will be cancelled.
*/
CREATE TRIGGER CheckFreight
ON Orders
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @CustomerID nchar(5);
    DECLARE @Freight money;

    SELECT @CustomerID = CustomerID, @Freight = Freight
    FROM inserted;

    DECLARE @AverageFreight money;
    EXEC dbo.CalculateAverageFreight @CustomerID , @AverageFreight OUTPUT
    ;
    PRINT @AverageFreight

    IF @Freight > @AverageFreight
    BEGIN
        RAISERROR('Freight cannot exceed the average freight for the specified customer.',16,1);
		ROLLBACK TRANSACTION
	END
	
END

create PROCEDURE [dbo].[CalculateAverageFreight]
    @CustomerID nchar(5),
	@output money OUTPUT
AS
BEGIN
    SELECT @output = AVG(Freight)
    FROM Orders
    WHERE CustomerID = @CustomerID;
END;
Declare @money money
execute CalculateAverageFreight 'VINET' , @money output
print @money


/*
2. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
Employee Sales by Country
*/
alter procedure spEmpSalesByCountry
as 
begin 
	select employees.FirstName, c.Country, sum(o.UnitPrice*o.Quantity) as Sales
	from Orders od
	join Employees on od.EmployeeID=employees.EmployeeID
	join [Order Details] o on o.OrderID = Od.OrderID
	join Customers c on c.CustomerID=od.CustomerID
	group by c.Country,employees.FirstName
	order by employees.FirstName ,c.Country;
end

execute spEmpSalesByCountry
/*
3. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
Sales by Year
*/
alter procedure spSalesByYear
as 
begin
	select YEAR(o.ShippedDate) as Order_Year,sum(od.UnitPrice*od.Quantity) as Sales
	from Orders o
	join Employees e on o.EmployeeID=e.EmployeeID
	join [Order Details] od on od.OrderID=o.OrderID
	where o.ShippedDate is not null
	group by YEAR(o.ShippedDate)
end

execute spSalesByYear

/*
4. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
Sales By Category
*/
alter procedure spSalesByCategory
as 
begin
	select ca.CategoryName as Category,sum(od.UnitPrice*od.Quantity) as Sales
	from Products p
	join Categories ca on ca.CategoryID=p.CategoryID
	join [Order Details] od on p.ProductID=od.productID
	
	group by ca.CategoryName;
end

execute spSalesByCategory

/*
5. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
Ten Most Expensive Products
*/
CREATE PROCEDURE GetTop10ExpensiveProducts
AS
BEGIN
    SELECT TOP 10
        ProductName,
        UnitPrice
    FROM
        Products
    ORDER BY
        UnitPrice DESC;
END;

/*
6. write a SQL query to Create Stored procedure in the Northwind database to insert 
Customer Order Details
*/ 
create procedure spInsertCustOrderDetails

@OrderId integer , @ProductId integer , @UnitPrice money , @Quantity smallint , @Discount real
as 
begin 
	insert into [Order Details] values (@OrderId , @ProductId, @UnitPrice , @Quantity , @Discount);
end

/*
7. write a SQL query to Create Stored procedure in the Northwind database to update 
Customer Order Details
*/
CREATE PROCEDURE UpdateCustomerOrderDetails
    @OrderID int,
    @ProductID int,
    @Quantity int,
    @Discount real
AS
BEGIN
    UPDATE [Order Details]
    SET
        ProductID = @ProductID,
        Quantity = @Quantity,
        Discount = @Discount
    WHERE
        OrderID = @OrderID;
END;

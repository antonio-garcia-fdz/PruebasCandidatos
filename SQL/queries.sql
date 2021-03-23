--Usando la base de datos de ejemplo Northwind de SQL Server:

--1.	Obtener la lista de los productos no descatalogados incluyendo el nombre de la categoría ordenado por nombre de producto.
--2.	Mostrar el nombre de los clientes de  Nancy Davolio.
--3.	Mostrar el total facturado por año del empleado Steven Buchanan.
--4.	Mostrar el nombre de los empleados que dependan directa o indirectamente de Andrew Fuller.


--1.
SELECT prod.ProductName, cat.CategoryName
FROM [Northwind].[dbo].[Products] AS prod
	INNER JOIN [Northwind].[dbo].[Categories] AS cat
	ON prod.CategoryID = cat.CategoryID
	WHERE prod.Discontinued = 0
	ORDER BY prod.ProductName;

GO

--2.
SELECT DISTINCT(Cust.ContactName)
FROM [Northwind].[dbo].[Customers] AS Cust
	INNER JOIN  [Northwind].[dbo].[Orders] AS Ord
	ON Cust.CustomerID = Ord.CustomerID
	WHERE Ord.EmployeeID = (
		SELECT Emp.EmployeeID
		FROM [Northwind].[dbo].[Employees] AS Emp
		WHERE Emp.FirstName LIKE 'Nancy' AND Emp.LastName LIKE 'Davolio');

GO

--3.
SELECT SUM(OrdD.Quantity*OrdD.UnitPrice*(1 - OrdD.Discount)) AS 'Total Facturado Steven Buchanan'
FROM [Northwind].[dbo].[Order Details] AS OrdD
	INNER JOIN  [Northwind].[dbo].[Orders] AS Ord
	ON OrdD.OrderID = Ord.OrderID
	WHERE Ord.EmployeeID = (
		SELECT Emp.EmployeeID
		FROM [Northwind].[dbo].[Employees] AS Emp
		WHERE Emp.FirstName LIKE 'Steven' AND Emp.LastName LIKE 'Buchanan');

GO

--4.
WITH cte AS (
    SELECT
        Emp.EmployeeID,
        Emp.FirstName,
        Emp.LastName,
		    Emp.ReportsTo
    FROM
        [Northwind].[dbo].[Employees] AS Emp
    WHERE Emp.ReportsTo IS NULL --AND Emp.FirstName LIKE 'Andrew' AND Emp.LastName LIKE 'Fuller' 
    UNION ALL
    SELECT
        Emp2.EmployeeID,
        Emp2.FirstName,
        Emp2.LastName,
		    Emp2.ReportsTo
    FROM
        [Northwind].[dbo].[Employees] AS Emp2
        INNER JOIN cte
            ON cte.EmployeeID = Emp2.ReportsTo
)
SELECT * FROM cte;

GO

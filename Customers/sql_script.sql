
-- to run this script use:

-- sqlcmd -S localhost\SQLEXPRESS -i C:\path\to\sql_script.bat

-- REMEMBER: change path to csv file in BULK INSERT (lines 22-30)


-- create table for the new customers
CREATE TABLE [Northwind].[dbo].NewCustomers (
Id NVARCHAR(5) COLLATE Latin1_General_100_CI_AI_SC_UTF8 PRIMARY KEY ,
Name NVARCHAR(40) COLLATE Latin1_General_100_CI_AI_SC_UTF8  NOT NULL,
Address NVARCHAR(46) COLLATE Latin1_General_100_CI_AI_SC_UTF8  NOT NULL,
City NVARCHAR(15) COLLATE Latin1_General_100_CI_AI_SC_UTF8  NOT NULL,
Country NVARCHAR(11) COLLATE Latin1_General_100_CI_AI_SC_UTF8  NOT NULL,
PostalCode NVARCHAR(15)COLLATE Latin1_General_100_CI_AI_SC_UTF8  NOT NULL,
Phone NVARCHAR(17) COLLATE Latin1_General_100_CI_AI_SC_UTF8  NOT NULL
);

GO

-- insert the data by batches
BULK INSERT [Northwind].[dbo].NewCustomers
FROM 'C:\Users\Antonio\Desktop\PruebasCandidatos\Customers\Customers.csv' WITH (
    FIELDTERMINATOR=';',
    ROWTERMINATOR='\n'
    );

GO

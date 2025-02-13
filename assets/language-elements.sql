--  src: D:\src\sql\sql-docs\docs\t-sql\language-elements
--add-equals-transact-sql.md line: 32
expression += expression  


--add-transact-sql.md line: 34
expression + expression  

--add-transact-sql.md line: 52
-- Uses AdventureWorks  
  
SELECT p.FirstName, p.LastName, VacationHours, SickLeaveHours,   
    VacationHours + SickLeaveHours AS 'Total Hours Away'  
FROM HumanResources.Employee AS e  
    JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID  
ORDER BY 'Total Hours Away' ASC;  
GO  

--add-transact-sql.md line: 66
SET NOCOUNT ON  
DECLARE @startdate DATETIME, @adddays INT;  
SET @startdate = 'January 10, 1900 12:00 AM';  
SET @adddays = 5;  
SET NOCOUNT OFF;  
SELECT @startdate + 1.25 AS 'Start Date',   
   @startdate + @adddays AS 'Add Date';  
---- datetime+int=datetime
--add-transact-sql.md line: 78
Start Date                  Add Date
--------------------------- ---------------------------
1900-01-11 06:00:00.000     1900-01-15 00:00:00.000
  
(1 row(s) affected)
--! string +int=int if string to int can be converted to int, otherwise fail
--add-transact-sql.md line: 89
DECLARE @addvalue INT;  
SET @addvalue = 15;  
SELECT '125127' + @addvalue;  

--add-transact-sql.md line: 97
-----------------------
125142
  
(1 row(s) affected)

--add-transact-sql.md line: 109
-- Uses AdventureWorks  
  
SELECT FirstName, LastName, VacationHours, SickLeaveHours,   
    VacationHours + SickLeaveHours AS TotalHoursAway  
FROM DimEmployee  
ORDER BY TotalHoursAway ASC;  


--all-transact-sql.md line: 29
scalar_expression { = | <> | != | > | >= | !> | < | <= | !< } ALL ( subquery )  
--! IF (int >= ALL ( Select ..) ... else ...
--all-transact-sql.md line: 70
-- Uses AdventureWorks

CREATE PROCEDURE DaysToBuild @OrderID INT, @NumberOfDays INT  
AS  
IF   
@NumberOfDays >= ALL  
   (  
    SELECT DaysToManufacture  
    FROM Sales.SalesOrderDetail  
    JOIN Production.Product   
    ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID   
    WHERE SalesOrderID = @OrderID  
   )  
PRINT 'All items for this order can be manufactured in specified number of days or less.'  
ELSE   
PRINT 'Some items for this order can''t be manufactured in specified number of days or less.' ;  

--all-transact-sql.md line: 91
EXECUTE DaysToBuild 49080, 2 ;  

--all-transact-sql.md line: 99
EXECUTE DaysToBuild 49080, 1 ;  


--and-transact-sql.md line: 32
boolean_expression AND boolean_expression  
--! WHERE a=2 AND b=1
--and-transact-sql.md line: 62
-- Uses AdventureWorks  
  
SELECT  BusinessEntityID, LoginID, JobTitle, VacationHours   
FROM HumanResources.Employee  
WHERE JobTitle = 'Marketing Assistant'  
AND VacationHours > 41 ;  

--and-transact-sql.md line: 74
IF 1 = 1 AND 2 = 2  
BEGIN  
   PRINT 'First Example is TRUE'  
END  
ELSE PRINT 'First Example is FALSE' ;  
GO  
  
IF 1 = 1 AND 2 = 17  
BEGIN  
   PRINT 'Second Example is TRUE'  
END  
ELSE PRINT 'Second Example is FALSE' ;  
GO  




--assignment-operator-transact-sql.md line: 26
DECLARE @MyCounter INT;  
SET @MyCounter = 1;  

--assignment-operator-transact-sql.md line: 33
-- Uses AdventureWorks  
--! Select a='b' a header, 'b' value 
SELECT FirstColumnHeading = 'xyz',  
       SecondColumnHeading = ProductID  
FROM Production.Product;  
GO  


--begin-distributed-transaction-transact-sql.md line: 40
BEGIN DISTRIBUTED { TRAN | TRANSACTION }
     [ transaction_name | @tran_name_variable ]
[ ; ]
--! BEGIN DISTRIBUTED TRANSACTION for action on remote server
--begin-distributed-transaction-transact-sql.md line: 89
USE AdventureWorks2022;
GO
BEGIN DISTRIBUTED TRANSACTION;
-- Delete candidate from local instance.
DELETE AdventureWorks2022.HumanResources.JobCandidate
    WHERE JobCandidateID = 13;
-- Delete candidate from remote instance.
DELETE RemoteServer.AdventureWorks2022.HumanResources.JobCandidate
    WHERE JobCandidateID = 13;
COMMIT TRANSACTION;
GO


--begin-end-transact-sql.md line: 34
BEGIN  
    { sql_statement | statement_block }   
END  
 
--begin-end-transact-sql.md line: 54
USE AdventureWorks2022;
GO  
BEGIN TRANSACTION
GO  
--! IF BEGIN END
IF @@TRANCOUNT = 0  
BEGIN  
    SELECT FirstName, MiddleName   
    FROM Person.Person WHERE LastName = 'Adams';
   ROLLBACK TRANSACTION;
   PRINT N'Rolling back the transaction two times would cause an error.';
END;
ROLLBACK TRANSACTION;
PRINT N'Rolled back the transaction.';
GO  
/*  
Rolled back the transaction.  
*/  

--begin-end-transact-sql.md line: 77
-- Uses AdventureWorks  
--! WHILE a>1 BEGIN BREAK END
DECLARE @Iteration Integer = 0;
WHILE @Iteration <10  
BEGIN  
    SELECT FirstName, MiddleName   
    FROM dbo.DimCustomer WHERE LastName = 'Adams';
    SET @Iteration += 1  ;
END;


--begin-transaction-transact-sql.md line: 40
--Applies to SQL Server and Azure SQL Database
 
BEGIN { TRAN | TRANSACTION }   
    [ { transaction_name | @tran_name_variable }  
      [ WITH MARK [ 'description' ] ]  
    ]  
[ ; ]  

--begin-transaction-transact-sql.md line: 50
--Applies to Synpase Data Warehouse in Microsoft Fabric, Azure Synapse Analytics and Parallel Data Warehouse
 
BEGIN { TRAN | TRANSACTION }   
[ ; ]  
--! BEGIN TRAN M2 WITH WITH MARK N'Deleting a Job Candidate';  ROLLBACK; COMMIT TRANS M2;    Specifies that the transaction is marked in the log.
--begin-transaction-transact-sql.md line: 110
BEGIN TRAN T1;  
UPDATE table1 ...;  
BEGIN TRAN M2 WITH MARK;  
UPDATE table2 ...;  
SELECT * from table1;  
COMMIT TRAN M2;  
UPDATE table3 ...;  
COMMIT TRAN T1;  

--begin-transaction-transact-sql.md line: 145
BEGIN TRANSACTION;  
DELETE FROM HumanResources.JobCandidate  
    WHERE JobCandidateID = 13;  
COMMIT;  

--begin-transaction-transact-sql.md line: 158
CREATE TABLE ValueTable (id INT);  
BEGIN TRANSACTION;  
       INSERT INTO ValueTable VALUES(1);  
       INSERT INTO ValueTable VALUES(2);  
ROLLBACK;  


--begin-transaction-transact-sql.md line: 172
DECLARE @TranName VARCHAR(20);  
SELECT @TranName = 'MyTransaction';  
  
BEGIN TRANSACTION @TranName;  
USE AdventureWorks2022;  
DELETE FROM AdventureWorks2022.HumanResources.JobCandidate  
    WHERE JobCandidateID = 13;  
  
COMMIT TRANSACTION @TranName;  
GO  

--begin-transaction-transact-sql.md line: 190
BEGIN TRANSACTION CandidateDelete  
    WITH MARK N'Deleting a Job Candidate';  
GO  
USE AdventureWorks2022;  
GO  
DELETE FROM AdventureWorks2022.HumanResources.JobCandidate  
    WHERE JobCandidateID = 13;  
GO  
COMMIT TRANSACTION CandidateDelete;  
GO  


--between-transact-sql.md line: 33
test_expression [ NOT ] BETWEEN begin_expression AND end_expression  

--between-transact-sql.md line: 71
SELECT principal_id, name 
FROM sys.database_principals
WHERE type = 'R';

SELECT principal_id, name 
FROM sys.database_principals
WHERE type = 'R'
AND principal_id BETWEEN 16385 AND 16390;
GO  

--between-transact-sql.md line: 84
principal_id	name
------------  ---- 
0	            public
16384	        db_owner
16385	        db_accessadmin
16386	        db_securityadmin
16387	        db_ddladmin
16389	        db_backupoperator
16390	        db_datareader
16391	        db_datawriter
16392	        db_denydatareader
16393	        db_denydatawriter

--between-transact-sql.md line: 98
principal_id	name
------------  ---- 
16385	        db_accessadmin
16386	        db_securityadmin
16387	        db_ddladmin
16389	        db_backupoperator
16390	        db_datareader

--between-transact-sql.md line: 111
-- Uses AdventureWorks  
  
SELECT e.FirstName, e.LastName, ep.Rate  
FROM HumanResources.vEmployee e   
JOIN HumanResources.EmployeePayHistory ep   
    ON e.BusinessEntityID = ep.BusinessEntityID  
WHERE ep.Rate > 27 AND ep.Rate < 30  
ORDER BY ep.Rate;  
GO  

--between-transact-sql.md line: 125
 FirstName   LastName             Rate  
 ---------   -------------------  ---------  
 Paula       Barreto de Mattos    27.1394  
 Janaina     Bueno                27.4038  
 Dan         Bacon                27.4038  
 Ramesh      Meyyappan            27.4038  
 Karen       Berg                 27.4038  
 David       Bradley              28.7500  
 Hazem       Abolrous             28.8462  
 Ovidiu      Cracium              28.8462  
 Rob         Walters              29.8462  

--between-transact-sql.md line: 142
-- Uses AdventureWorks  
  
SELECT e.FirstName, e.LastName, ep.Rate  
FROM HumanResources.vEmployee e   
JOIN HumanResources.EmployeePayHistory ep   
    ON e.BusinessEntityID = ep.BusinessEntityID  
WHERE ep.Rate NOT BETWEEN 27 AND 30  
ORDER BY ep.Rate;  
GO  

--between-transact-sql.md line: 157
-- Uses AdventureWorks  
  
SELECT BusinessEntityID, RateChangeDate  
FROM HumanResources.EmployeePayHistory  
WHERE RateChangeDate BETWEEN '20011212' AND '20020105';  

--between-transact-sql.md line: 167
 BusinessEntityID RateChangeDate  
 ----------- -----------------------  
 3           2001-12-12 00:00:00.000  
 4           2002-01-05 00:00:00.000  


--bitwise-and-equals-transact-sql.md line: 34
expression &= expression  


--bitwise-and-transact-sql.md line: 32
expression & expression  

--bitwise-and-transact-sql.md line: 60
CREATE TABLE bitwise (   
  a_int_value INT NOT NULL,  
  b_int_value INT NOT NULL);  
GO  
INSERT bitwise VALUES (170, 75);  
GO  

--bitwise-and-transact-sql.md line: 71
SELECT a_int_value & b_int_value  
FROM bitwise;  
GO  

--bitwise-and-transact-sql.md line: 79
-----------   
10            
  
(1 row(s) affected)  

--bitwise-and-transact-sql.md line: 88
(A & B)  
0000 0000 1010 1010  
0000 0000 0100 1011  
-------------------  
0000 0000 0000 1010  


--bitwise-exclusive-or-equals-transact-sql.md line: 33
expression ^= expression  


--bitwise-exclusive-or-transact-sql.md line: 32
expression ^ expression  

--bitwise-exclusive-or-transact-sql.md line: 60
CREATE TABLE bitwise (   
  a_int_value INT NOT NULL,  
  b_int_value INT NOT NULL);
GO  
INSERT bitwise VALUES (170, 75);  
GO  

--bitwise-exclusive-or-transact-sql.md line: 71
SELECT a_int_value ^ b_int_value  
FROM bitwise;  
GO  

--bitwise-exclusive-or-transact-sql.md line: 79
-----------   
225           
  
(1 row(s) affected)  

--bitwise-exclusive-or-transact-sql.md line: 88
(A ^ B)     
         0000 0000 1010 1010  
         0000 0000 0100 1011  
         -------------------  
         0000 0000 1110 0001  


--bitwise-not-transact-sql.md line: 32
~ expression  

--bitwise-not-transact-sql.md line: 63
CREATE TABLE bitwise (  
  a_int_value INT NOT NULL,  
  b_int_value INT NOT NULL); 
GO  
INSERT bitwise VALUES (170, 75);  
GO  

--bitwise-not-transact-sql.md line: 74
SELECT ~ a_int_value, ~ b_int_value  
FROM bitwise;  

--bitwise-not-transact-sql.md line: 81
--- ---   
-171  -76   
  
(1 row(s) affected)  

--bitwise-not-transact-sql.md line: 90
 (~A)     
         0000 0000 0000 0000 0000 0000 1010 1010  
         ---------------------------------------  
         1111 1111 1111 1111 1111 1111 0101 0101  
(~B)     
         0000 0000 0000 0000 0000 0000 0100 1011  
         ---------------------------------------  
         1111 1111 1111 1111 1111 1111 1011 0100  



--bitwise-or-equals-transact-sql.md line: 34
expression |= expression  


--bitwise-or-transact-sql.md line: 32
expression | expression  

--bitwise-or-transact-sql.md line: 56
CREATE TABLE bitwise (  
  a_int_value INT NOT NULL,  
  b_int_value INT NOT NULL);  
GO  
INSERT bitwise VALUES (170, 75);  
GO  

--bitwise-or-transact-sql.md line: 67
SELECT a_int_value | b_int_value  
FROM bitwise;  
GO  

--bitwise-or-transact-sql.md line: 75
-----------   
235           
  
(1 row(s) affected)  

--bitwise-or-transact-sql.md line: 84
(A | B)  
0000 0000 1010 1010  
0000 0000 0100 1011  
-------------------  
0000 0000 1110 1011  


--break-transact-sql.md line: 35
WHILE (1=1)
BEGIN
   IF EXISTS (SELECT * FROM ##MyTempTable WHERE EventCode = 'Done')
   BEGIN
      BREAK;  -- 'Done' row has finally been inserted and detected, so end this loop.
   END

   PRINT N'The other process is not yet done.';  -- Re-confirm the non-done status to the console.
   WAITFOR DELAY '00:01:30';  -- Sleep for 90 seconds.
END

--break-transact-sql.md line: 50
DECLARE @sleeptimesec int = 1;
DECLARE @startingtime datetime2(2) = getdate();

PRINT N'Sleeping for ' + CAST(@sleeptimesec as varchar(5)) + ' seconds'
WHILE (1=1)
BEGIN
  
    PRINT N'Sleeping.';  
    PRINT datediff(s, getdate(),  @startingtime)

    IF datediff(s, getdate(),  @startingtime) < -@sleeptimesec
        BEGIN
            PRINT 'We have finished waiting.';
            BREAK;
        END
END


--case-transact-sql.md line: 44
-- Simple CASE expression:
CASE input_expression
     WHEN when_expression THEN result_expression [ ...n ]
     [ ELSE else_result_expression ]
END

-- Searched CASE expression:
CASE
     WHEN Boolean_expression THEN result_expression [ ...n ]
     [ ELSE else_result_expression ]
END

--case-transact-sql.md line: 60
CASE
     WHEN when_expression THEN result_expression [ ...n ]
     [ ELSE else_result_expression ]
END
--! SELECT CASE WHEN  THEN WHEN  THEN ELSE END
--case-transact-sql.md line: 127
WITH Data (value)
AS (
    SELECT 0
    UNION ALL
    SELECT 1
    )
SELECT CASE
        WHEN MIN(value) <= 0 THEN 0
        WHEN MAX(1 / value) >= 100 THEN 1
        END
FROM Data;
GO

--case-transact-sql.md line: 152
USE AdventureWorks2022;
GO

SELECT ProductNumber,
    Category = CASE ProductLine
        WHEN 'R' THEN 'Road'
        WHEN 'M' THEN 'Mountain'
        WHEN 'T' THEN 'Touring'
        WHEN 'S' THEN 'Other sale items'
        ELSE 'Not for sale'
        END,
    Name
FROM Production.Product
ORDER BY ProductNumber;
GO

--case-transact-sql.md line: 174
USE AdventureWorks2022;
GO

SELECT ProductNumber,
    Name,
    "Price Range" = CASE
        WHEN ListPrice = 0 THEN 'Mfg item - not for resale'
        WHEN ListPrice < 50 THEN 'Under $50'
        WHEN ListPrice >= 50 AND ListPrice < 250 THEN 'Under $250'
        WHEN ListPrice >= 250 AND ListPrice < 1000 THEN 'Under $1000'
        ELSE 'Over $1000'
        END
FROM Production.Product
ORDER BY ProductNumber;
GO

--case-transact-sql.md line: 196
SELECT BusinessEntityID,
    SalariedFlag
FROM HumanResources.Employee
ORDER BY CASE SalariedFlag
        WHEN 1 THEN BusinessEntityID
        END DESC,
    CASE
        WHEN SalariedFlag = 0 THEN BusinessEntityID
        END;
GO

--case-transact-sql.md line: 209
SELECT BusinessEntityID,
    LastName,
    TerritoryName,
    CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY CASE CountryRegionName
        WHEN 'United States' THEN TerritoryName
        ELSE CountryRegionName
        END;
GO

--case-transact-sql.md line: 227
USE AdventureWorks2022;
GO
-- SET CASE WHEN ELSE END OUTPUT Deleted. Inserted. WHERE
UPDATE HumanResources.Employee
SET VacationHours = (
        CASE
            WHEN ((VacationHours - 10.00) < 0) THEN VacationHours + 40
            ELSE (VacationHours + 20.00)
            END
        )
OUTPUT Deleted.BusinessEntityID,
    Deleted.VacationHours AS BeforeValue,
    Inserted.VacationHours AS AfterValue
WHERE SalariedFlag = 0;
GO

--case-transact-sql.md line: 249
USE AdventureWorks2022;
GO
--! CREATE FUNCTION () RETURN @a TABLE () AS BEGIN RETURN; END;
CREATE FUNCTION dbo.GetContactInformation (@BusinessEntityID INT)
RETURNS @retContactInformation TABLE (
    BusinessEntityID INT NOT NULL,
    FirstName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NULL,
    ContactType NVARCHAR(50) NULL,
    PRIMARY KEY CLUSTERED (BusinessEntityID ASC)
    )
AS
-- Returns the first name, last name and contact type for the specified contact.
BEGIN
    DECLARE @FirstName NVARCHAR(50),
        @LastName NVARCHAR(50),
        @ContactType NVARCHAR(50);

    -- Get common contact information
    SELECT @BusinessEntityID = BusinessEntityID,
        @FirstName = FirstName,
        @LastName = LastName
    FROM Person.Person
    WHERE BusinessEntityID = @BusinessEntityID;

    SET @ContactType = CASE
            -- Check for employee
            WHEN EXISTS (
                    SELECT *
                    FROM HumanResources.Employee AS e
                    WHERE e.BusinessEntityID = @BusinessEntityID
                    )
                THEN 'Employee'
                    -- Check for vendor
            WHEN EXISTS (
                    SELECT *
                    FROM Person.BusinessEntityContact AS bec
                    WHERE bec.BusinessEntityID = @BusinessEntityID
                    )
                THEN 'Vendor'
                    -- Check for store
            WHEN EXISTS (
                    SELECT *
                    FROM Purchasing.Vendor AS v
                    WHERE v.BusinessEntityID = @BusinessEntityID
                    )
                THEN 'Store Contact'
                    -- Check for individual consumer
            WHEN EXISTS (
                    SELECT *
                    FROM Sales.Customer AS c
                    WHERE c.PersonID = @BusinessEntityID
                    )
                THEN 'Consumer'
            END;

    -- Return the information to the caller
    IF @BusinessEntityID IS NOT NULL
    BEGIN
        INSERT @retContactInformation
        SELECT @BusinessEntityID,
            @FirstName,
            @LastName,
            @ContactType;
    END;

    RETURN;
END;
GO

SELECT BusinessEntityID,
    FirstName,
    LastName,
    ContactType
FROM dbo.GetContactInformation(2200);
GO

SELECT BusinessEntityID,
    FirstName,
    LastName,
    ContactType
FROM dbo.GetContactInformation(5);
GO

--case-transact-sql.md line: 339
USE AdventureWorks2022;
GO

SELECT JobTitle,
    MAX(ph1.Rate) AS MaximumRate
FROM HumanResources.Employee AS e
INNER JOIN HumanResources.EmployeePayHistory AS ph1
    ON e.BusinessEntityID = ph1.BusinessEntityID
GROUP BY JobTitle
HAVING (
        MAX(CASE
                WHEN SalariedFlag = 1 THEN ph1.Rate
                ELSE NULL
                END) > 40.00
        OR MAX(CASE
                WHEN SalariedFlag = 0 THEN ph1.Rate
                ELSE NULL
                END) > 15.00
        )
ORDER BY MaximumRate DESC;
GO

--case-transact-sql.md line: 369
-- Uses AdventureWorks

SELECT ProductAlternateKey,
    Category = CASE ProductLine
        WHEN 'R' THEN 'Road'
        WHEN 'M' THEN 'Mountain'
        WHEN 'T' THEN 'Touring'
        WHEN 'S' THEN 'Other sale items'
        ELSE 'Not for sale'
        END,
    EnglishProductName
FROM dbo.DimProduct
ORDER BY ProductKey;
GO

--case-transact-sql.md line: 390
-- Uses AdventureWorks

UPDATE dbo.DimEmployee
SET VacationHours = (
        CASE
            WHEN ((VacationHours - 10.00) < 0) THEN VacationHours + 40
            ELSE (VacationHours + 20.00)
            END
        )
WHERE SalariedFlag = 0;
GO

--! CHECKPOINT 
--checkpoint-transact-sql.md line: 40
CHECKPOINT [ checkpoint_duration ]  

--! DECLARE C CURSOR FOR SELECT FROM OPEN C; FETCH NEXT FROM C;  WHILE @STATUS = 0  BEGIN   FETCH NEXT FROM C; END; CLOSE C; DEALLOCATE C;  

--close-transact-sql.md line: 31
CLOSE { { [ GLOBAL ] cursor_name } | cursor_variable_name }  

--close-transact-sql.md line: 52
DECLARE Employee_Cursor CURSOR FOR  
SELECT EmployeeID, Title FROM AdventureWorks2022.HumanResources.Employee;  
OPEN Employee_Cursor;  
FETCH NEXT FROM Employee_Cursor;  
WHILE @@FETCH_STATUS = 0  
   BEGIN  
      FETCH NEXT FROM Employee_Cursor;  
   END;  
CLOSE Employee_Cursor;  
DEALLOCATE Employee_Cursor;  
GO  


--coalesce-transact-sql.md line: 31
COALESCE ( expression [ ,...n ] )   

--coalesce-transact-sql.md line: 50
CASE  
WHEN (expression1 IS NOT NULL) THEN expression1  
WHEN (expression2 IS NOT NULL) THEN expression2  
...  
ELSE expressionN  
END  

--coalesce-transact-sql.md line: 63
SELECT CASE WHEN x IS NOT NULL THEN x ELSE 1 END  
FROM  
(  
SELECT (SELECT Nullable FROM Demo WHERE SomeCol = 1) AS x  
) AS T;  
  

--coalesce-transact-sql.md line: 81
    USE tempdb;  
    GO  
    -- This statement fails because the PRIMARY KEY cannot accept NULL values  
    -- and the nullability of the COALESCE expression for col2   
    -- evaluates to NULL.  
    CREATE TABLE #Demo   
    (   
      col1 INTEGER NULL,   
      col2 AS COALESCE(col1, 0) PRIMARY KEY,   
      col3 AS ISNULL(col1, 0)   
    );   
  
    -- This statement succeeds because the nullability of the   
    -- ISNULL function evaluates AS NOT NULL.  
  
    CREATE TABLE #Demo   
    (   
      col1 INTEGER NULL,   
      col2 AS COALESCE(col1, 0),   
      col3 AS ISNULL(col1, 0) PRIMARY KEY   
    );  

--coalesce-transact-sql.md line: 114
SELECT Name, Class, Color, ProductNumber,  
COALESCE(Class, Color, ProductNumber) AS FirstNotNull  
FROM Production.Product;  

--coalesce-transact-sql.md line: 123
SET NOCOUNT ON;  
GO  
USE tempdb;  
IF OBJECT_ID('dbo.wages') IS NOT NULL  
    DROP TABLE wages;  
GO  
CREATE TABLE dbo.wages  
(  
    emp_id        TINYINT   IDENTITY,  
    hourly_wage   DECIMAL   NULL,  
    salary        DECIMAL   NULL,  
    commission    DECIMAL   NULL,  
    num_sales     TINYINT   NULL  
);  
GO  
INSERT dbo.wages (hourly_wage, salary, commission, num_sales)  
VALUES  
    (10.00, NULL, NULL, NULL),  
    (20.00, NULL, NULL, NULL),  
    (30.00, NULL, NULL, NULL),  
    (40.00, NULL, NULL, NULL),  
    (NULL, 10000.00, NULL, NULL),  
    (NULL, 20000.00, NULL, NULL),  
    (NULL, 30000.00, NULL, NULL),  
    (NULL, 40000.00, NULL, NULL),  
    (NULL, NULL, 15000, 3),  
    (NULL, NULL, 25000, 2),  
    (NULL, NULL, 20000, 6),  
    (NULL, NULL, 14000, 4);  
GO  
SET NOCOUNT OFF;  
GO  
SELECT CAST(COALESCE(hourly_wage * 40 * 52,   
   salary,   
   commission * num_sales) AS money) AS 'Total Salary'   
FROM dbo.wages  
ORDER BY 'Total Salary';  
GO  

--coalesce-transact-sql.md line: 166
Total Salary  
------------  
10000.00  
20000.00  
20800.00  
30000.00  
40000.00  
41600.00  
45000.00  
50000.00  
56000.00  
62400.00  
83200.00  
120000.00  
  
(12 row(s) affected)

--coalesce-transact-sql.md line: 188
Name         Color      ProductNumber  
------------ ---------- -------------  
Socks, Mens  NULL       PN1278  
Socks, Mens  Blue       PN1965  
NULL         White      PN9876

--coalesce-transact-sql.md line: 198
SELECT Name, Color, ProductNumber, COALESCE(Color, ProductNumber) AS FirstNotNull   
FROM Products ;  

--coalesce-transact-sql.md line: 205
Name         Color      ProductNumber  FirstNotNull  
------------ ---------- -------------  ------------  
Socks, Mens  NULL       PN1278         PN1278  
Socks, Mens  Blue       PN1965         Blue  
NULL         White      PN9876         White

--coalesce-transact-sql.md line: 218
CREATE TABLE dbo.wages  
(  
    emp_id        TINYINT   NULL,  
    hourly_wage   DECIMAL   NULL,  
    salary        DECIMAL   NULL,  
    commission    DECIMAL   NULL,  
    num_sales     TINYINT   NULL  
);  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (1, 10.00, NULL, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (2, 20.00, NULL, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (3, 30.00, NULL, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (4, 40.00, NULL, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (5, NULL, 10000.00, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (6, NULL, 20000.00, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (7, NULL, 30000.00, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (8, NULL, 40000.00, NULL, NULL);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (9, NULL, NULL, 15000, 3);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (10,NULL, NULL, 25000, 2);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (11, NULL, NULL, 20000, 6);  
  
INSERT INTO dbo.wages (emp_id, hourly_wage, salary, commission, num_sales)  
VALUES (12, NULL, NULL, 14000, 4);  
  
SELECT CAST(COALESCE(hourly_wage * 40 * 52,   
   salary,   
   commission * num_sales) AS DECIMAL(10,2)) AS TotalSalary   
FROM dbo.wages  
ORDER BY TotalSalary;  

--coalesce-transact-sql.md line: 272
Total Salary  
------------  
10000.00  
20000.00  
20800.00  
30000.00  
40000.00  
41600.00  
45000.00  
50000.00  
56000.00  
62400.00  
83200.00  
120000.00


--comment-transact-sql.md line: 34
-- text_of_comment  

--comment-transact-sql.md line: 59
-- Choose the AdventureWorks2022 database.  
USE AdventureWorks2022;  
GO  
-- Choose all columns and all rows from the Address table.  
SELECT *  
FROM Person.Address  
ORDER BY PostalCode ASC; -- We do not have to specify ASC because   
-- that is the default.  
GO  


--commit-transaction-transact-sql.md line: 39
-- Applies to SQL Server (starting with 2008) and Azure SQL Database
  
COMMIT [ { TRAN | TRANSACTION }  [ transaction_name | @tran_name_variable ] ] [ WITH ( DELAYED_DURABILITY = { OFF | ON } ) ]  
[ ; ]  

--commit-transaction-transact-sql.md line: 46
-- Applies to Synpase Data Warehouse in Microsoft Fabric, Azure Synapse Analytics and Parallel Data Warehouse Database
  
COMMIT [ TRAN | TRANSACTION ] 
[ ; ]  

--commit-transaction-transact-sql.md line: 95
BEGIN TRANSACTION;   
DELETE FROM HumanResources.JobCandidate  
    WHERE JobCandidateID = 13;   
COMMIT TRANSACTION;   

--commit-transaction-transact-sql.md line: 107
IF OBJECT_ID(N'TestTran',N'U') IS NOT NULL  
    DROP TABLE TestTran;  
GO  
CREATE TABLE TestTran (Cola INT PRIMARY KEY, Colb CHAR(3));  
GO  
-- This statement sets @@TRANCOUNT to 1.  
BEGIN TRANSACTION OuterTran;  
  
PRINT N'Transaction count after BEGIN OuterTran = '  
    + CAST(@@TRANCOUNT AS NVARCHAR(10));  
 
INSERT INTO TestTran VALUES (1, 'aaa');  
 
-- This statement sets @@TRANCOUNT to 2.  
BEGIN TRANSACTION Inner1;  
 
PRINT N'Transaction count after BEGIN Inner1 = '  
    + CAST(@@TRANCOUNT AS NVARCHAR(10));  
  
INSERT INTO TestTran VALUES (2, 'bbb');  
  
-- This statement sets @@TRANCOUNT to 3.  
BEGIN TRANSACTION Inner2;  
  
PRINT N'Transaction count after BEGIN Inner2 = '  
    + CAST(@@TRANCOUNT AS NVARCHAR(10));  
  
INSERT INTO TestTran VALUES (3, 'ccc');  
  
-- This statement decrements @@TRANCOUNT to 2.  
-- Nothing is committed.  
COMMIT TRANSACTION Inner2;  
 
PRINT N'Transaction count after COMMIT Inner2 = '  
    + CAST(@@TRANCOUNT AS NVARCHAR(10));  
 
-- This statement decrements @@TRANCOUNT to 1.  
-- Nothing is committed.  
COMMIT TRANSACTION Inner1;  
 
PRINT N'Transaction count after COMMIT Inner1 = '  
    + CAST(@@TRANCOUNT AS NVARCHAR(10));  
  
-- This statement decrements @@TRANCOUNT to 0 and  
-- commits outer transaction OuterTran.  
COMMIT TRANSACTION OuterTran;  
  
PRINT N'Transaction count after COMMIT OuterTran = '  
    + CAST(@@TRANCOUNT AS NVARCHAR(10));  


--commit-work-transact-sql.md line: 32
COMMIT [ WORK ]  
[ ; ]  


--comparison-operators-transact-sql.md line: 47
-- Uses AdventureWorks  
  
DECLARE @MyProduct INT;  
SET @MyProduct = 750;  
IF (@MyProduct <> 0)  
   SELECT ProductID, Name, ProductNumber  
   FROM Production.Product  
   WHERE ProductID = @MyProduct;  


--compound-operators-transact-sql.md line: 36
expression operator expression  

--compound-operators-transact-sql.md line: 55
DECLARE @x1 INT = 27;  
SET @x1 += 2 ;  
SELECT @x1 AS Added_2;  
  
DECLARE @x2 INT = 27;  
SET @x2 -= 2 ;  
SELECT @x2 AS Subtracted_2;  
  
DECLARE @x3 INT = 27;  
SET @x3 *= 2 ;  
SELECT @x3 AS Multiplied_by_2;  
  
DECLARE @x4 INT = 27;  
SET @x4 /= 2 ;  
SELECT @x4 AS Divided_by_2;  
  
DECLARE @x5 INT = 27;  
SET @x5 %= 2 ;  
SELECT @x5 AS Modulo_of_27_divided_by_2;  
  
DECLARE @x6 INT = 9;  
SET @x6 &= 13 ;  
SELECT @x6 AS Bitwise_AND;  
  
DECLARE @x7 INT = 27;  
SET @x7 ^= 2 ;  
SELECT @x7 AS Bitwise_Exclusive_OR;  
  
DECLARE @x8 INT = 27;  
SET @x8 |= 2 ;  
SELECT @x8 AS Bitwise_OR;  



--! ТОЛЬКО ДЛЯ  PARALLEL  DATA WAREHOUSE PDW приложения в SQL не работает. 
--create-diagnostics-session-transact-sql.md line: 26
-- Creating a new diagnostics session:  
CREATE DIAGNOSTICS SESSION diagnostics_name AS N'{<session_xml>}';  
  
<session_xml>::  
<Session>  
   [ <MaxItemCount>max_item_count_num</MaxItemCount> ]  
   <Filter>  
      { \<Event Name="event_name"/>  
         [ <Where>\<filter_property_name Name="value" ComparisonType="comp_type"/></Where> ] [ ,...n ]  
      } [ ,...n ]  
   </Filter> ]   
   <Capture>  
      \<Property Name="property_name"/> [ ,...n ]  
   </Capture>  
<Session>  
  
-- Retrieving results for a diagnostics session:  
SELECT * FROM master.sysdiag.diagnostics_name ;  
  
-- Removing results for a diagnostics session:  
DROP DIAGNOSTICS SESSION diagnostics_name ;  

--create-diagnostics-session-transact-sql.md line: 101
CREATE DIAGNOSTICS SESSION MYDIAGSESSION AS N'  
<Session>  
   <MaxItemCount>100</MaxItemCount>  
   <Filter>  
      <Event Name="EngineInstrumentation:EngineQueryRunningEvent" />  
      <Event Name="DmsCoreInstrumentation:DmsBlockingQueueEnqueueBeginEvent" />  
      <Where>  
         <SessionId Value="381" ComparisonType="NotEquals" />  
      </Where>  
   </Filter>  
   <Capture>  
      <Property Name="Query.CommandText" />  
      <Property Name="MachineName" />  
      <Property Name="Query.QueryId" />  
      <Property Name="Alias" />  
      <Property Name="Duration" />  
      <Property Name="Session.SessionId" />  
   </Capture>  
</Session>';  

--create-diagnostics-session-transact-sql.md line: 125
SELECT COUNT(EmployeeKey) FROM AdventureWorksDW2022..FactSalesQuota;  

--create-diagnostics-session-transact-sql.md line: 131
SELECT * FROM master.sysdiag.MYDIAGSESSION;  

--create-diagnostics-session-transact-sql.md line: 141
DROP DIAGNOSTICS SESSION MYDIAGSESSION;  

--create-diagnostics-session-transact-sql.md line: 148
-- Determine the session_id of your current session  
SELECT TOP 1 session_id();  
-- Replace \<*session_number*> in the code below with the numbers in your session_id  
CREATE DIAGNOSTICS SESSION PdwOptimizationDiagnostics AS N'  
<Session>  
   <MaxItemCount>100</MaxItemCount>  
   <Filter>  
      <Event Name="EngineInstrumentation:MemoGenerationBeginEvent" />  
      <Event Name="EngineInstrumentation:MemoGenerationEndEvent" />  
      <Event Name="DSQLInstrumentation:OptimizationBeginEvent" />  
      <Event Name="DSQLInstrumentation:OptimizationEndEvent" />  
      <Event Name="DSQLInstrumentation:BuildRelOpContextTreeBeginEvent" />  
      <Event Name="DSQLInstrumentation:PostPlanGenModifiersEndEvent" />  
      <Where>  
         <SessionId Value="\<*session_number*>" ComparisonType="Equals" />  
      </Where>  
   </Filter>  
   <Capture>  
      <Property Name="Session.SessionId" />  
      <Property Name="Query.QueryId" />  
      <Property Name="Query.CommandText" />  
      <Property Name="Name" />  
      <Property Name="DateTimePublished" />  
      <Property Name="DateTimePublished.Ticks" />  
  </Capture>  
</Session>';  

--create-diagnostics-session-transact-sql.md line: 179
USE ssawPDW;  
GO  
SELECT * FROM dbo.FactFinance;  

--create-diagnostics-session-transact-sql.md line: 187
SELECT *   
FROM master.sysdiag.PdwOptimizationDiagnostics   
ORDER BY DateTimePublished;  

--create-diagnostics-session-transact-sql.md line: 195
DROP DIAGNOSTICS SESSION PdwOptimizationDiagnostics;  

---! CURSOR настроек много! DECLARE a SCROLL CURSOR FOR SELECT  OPEN a FETCH NEXT FROM a  DEALLOCATE a;   ; SET @MyCursor @a= CURSOR GLOBAL/LOCAL SCROLL FOR  SELECT ...

--deallocate-transact-sql.md line: 31
DEALLOCATE { { [ GLOBAL ] cursor_name } | @cursor_variable_name }  

--deallocate-transact-sql.md line: 49
DECLARE abc SCROLL CURSOR FOR  
SELECT * FROM Person.Person;  

--deallocate-transact-sql.md line: 60
    DECLARE @MyCrsrRef CURSOR;  
    SET @MyCrsrRef = abc;  

--deallocate-transact-sql.md line: 67
    DECLARE @MyCursor CURSOR;  
    SET @MyCursor = CURSOR LOCAL SCROLL FOR  
    SELECT * FROM Person.Person;  

--deallocate-transact-sql.md line: 75
USE AdventureWorks2022;  
GO  
  
DECLARE @MyCursor CURSOR;  
SET @MyCursor = CURSOR LOCAL SCROLL FOR  
    SELECT * FROM Sales.SalesPerson;  
  
DEALLOCATE @MyCursor;  
  
SET @MyCursor = CURSOR LOCAL SCROLL FOR  
    SELECT * FROM Sales.SalesTerritory;  
GO  

--deallocate-transact-sql.md line: 98
USE AdventureWorks2022;  
GO  
-- Create and open a global named cursor that  
-- is visible outside the batch.  
DECLARE abc CURSOR GLOBAL SCROLL FOR  
    SELECT * FROM Sales.SalesPerson;  
OPEN abc;  
GO  
-- Reference the named cursor with a cursor variable.  
DECLARE @MyCrsrRef1 CURSOR;  
SET @MyCrsrRef1 = abc;  
-- Now deallocate the cursor reference.  
DEALLOCATE @MyCrsrRef1;  
-- Cursor abc still exists.  
FETCH NEXT FROM abc;  
GO  
-- Reference the named cursor again.  
DECLARE @MyCrsrRef2 CURSOR;  
SET @MyCrsrRef2 = abc;  
-- Now deallocate cursor name abc.  
DEALLOCATE abc;  
-- Cursor still exists, referenced by @MyCrsrRef2.  
FETCH NEXT FROM @MyCrsrRef2;  
-- Cursor finally is deallocated when last referencing  
-- variable goes out of scope at the end of the batch.  
GO  
-- Create an unnamed cursor.  
DECLARE @MyCursor CURSOR;  
SET @MyCursor = CURSOR LOCAL SCROLL FOR  
SELECT * FROM Sales.SalesTerritory;  
-- The following statement deallocates the cursor  
-- because no other variables reference it.  
DEALLOCATE @MyCursor;  
GO  


--declare-cursor-transact-sql.md line: 34
ISO Syntax  
DECLARE cursor_name [ INSENSITIVE ] [ SCROLL ] CURSOR   
     FOR select_statement   
     [ FOR { READ ONLY | UPDATE [ OF column_name [ ,...n ] ] } ]  
[;]  
Transact-SQL Extended Syntax  
DECLARE cursor_name CURSOR [ LOCAL | GLOBAL ]   
     [ FORWARD_ONLY | SCROLL ]   
     [ STATIC | KEYSET | DYNAMIC | FAST_FORWARD ]   
     [ READ_ONLY | SCROLL_LOCKS | OPTIMISTIC ]   
     [ TYPE_WARNING ]   
     FOR select_statement   
     [ FOR UPDATE [ OF column_name [ ,...n ] ] ]  
[;]  

--declare-cursor-transact-sql.md line: 179
DECLARE vend_cursor CURSOR  
    FOR SELECT * FROM Purchasing.Vendor  
OPEN vend_cursor  
FETCH NEXT FROM vend_cursor;  

--declare-cursor-transact-sql.md line: 189
SET NOCOUNT ON;  
  
DECLARE @vendor_id INT, @vendor_name NVARCHAR(50),  
    @message VARCHAR(80), @product NVARCHAR(50);  
  
PRINT '-------- Vendor Products Report --------';  
  
DECLARE vendor_cursor CURSOR FOR   
SELECT VendorID, Name  
FROM Purchasing.Vendor  
WHERE PreferredVendorStatus = 1  
ORDER BY VendorID;  
  
OPEN vendor_cursor  
  
FETCH NEXT FROM vendor_cursor   
INTO @vendor_id, @vendor_name  
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    PRINT ' '  
    SELECT @message = '----- Products From Vendor: ' +   
        @vendor_name  
  
    PRINT @message  
  
    -- Declare an inner cursor based     
    -- on vendor_id from the outer cursor.  
  
    DECLARE product_cursor CURSOR FOR   
    SELECT v.Name  
    FROM Purchasing.ProductVendor pv, Production.Product v  
    WHERE pv.ProductID = v.ProductID AND  
    pv.VendorID = @vendor_id  -- Variable value from the outer cursor  
  
    OPEN product_cursor  
    FETCH NEXT FROM product_cursor INTO @product  
  
    IF @@FETCH_STATUS <> 0   
        PRINT '         <<None>>'       
  
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
  
        SELECT @message = '         ' + @product  
        PRINT @message  
        FETCH NEXT FROM product_cursor INTO @product  
        END  
  
    CLOSE product_cursor  
    DEALLOCATE product_cursor  
        -- Get the next vendor.  
    FETCH NEXT FROM vendor_cursor   
    INTO @vendor_id, @vendor_name  
END   
CLOSE vendor_cursor;  
DEALLOCATE vendor_cursor;  


--declare-local-variable-transact-sql.md line: 34
DECLARE
{
  { @local_variable [AS] data_type [ = value ] }
  | { @cursor_variable_name CURSOR }
} [ ,...n ]
| { @table_variable_name [AS] <table_type_definition> }

<table_type_definition> ::=
    TABLE ( { <column_definition> | <table_constraint> | <table_index> } } [ ,...n ] )

<column_definition> ::=
    column_name { scalar_data_type | AS computed_column_expression }
    [ COLLATE collation_name ]
    [ [ DEFAULT constant_expression ] | IDENTITY [ (seed, increment ) ] ]
    [ ROWGUIDCOL ]
    [ <column_constraint> ]
    [ <column_index> ]

<column_constraint> ::=
{
    [ NULL | NOT NULL ]
    { PRIMARY KEY | UNIQUE }
      [ CLUSTERED | NONCLUSTERED ]
      [ WITH FILLFACTOR = fillfactor
        | WITH ( < index_option > [ ,...n ] )
      [ ON { filegroup | "default" } ]
  | [ CHECK ( logical_expression ) ] [ ,...n ]
}

<column_index> ::=
    INDEX index_name [ CLUSTERED | NONCLUSTERED ]
    [ WITH ( <index_option> [ ,... n ] ) ]
    [ ON { partition_scheme_name (column_name )
         | filegroup_name
         | default
         }
    ]
    [ FILESTREAM_ON { filestream_filegroup_name | partition_scheme_name | "NULL" } ]

<table_constraint> ::=
{
    { PRIMARY KEY | UNIQUE }
      [ CLUSTERED | NONCLUSTERED ]
      ( column_name [ ASC | DESC ] [ ,...n ]
        [ WITH FILLFACTOR = fillfactor
        | WITH ( <index_option> [ ,...n ] )
  | [ CHECK ( logical_expression ) ] [ ,...n ]
}

<table_index> ::=
{
    {
      INDEX index_name  [ UNIQUE ] [ CLUSTERED | NONCLUSTERED ]
         (column_name [ ASC | DESC ] [ ,... n ] )
    | INDEX index_name CLUSTERED COLUMNSTORE
    | INDEX index_name [ NONCLUSTERED ] COLUMNSTORE ( column_name [ ,... n ] )
    }
    [ WITH ( <index_option> [ ,... n ] ) ]
    [ ON { partition_scheme_name ( column_name )
         | filegroup_name
         | default
         }
    ]
    [ FILESTREAM_ON { filestream_filegroup_name | partition_scheme_name | "NULL" } ]
}

<index_option> ::=
{
  PAD_INDEX = { ON | OFF }
  | FILLFACTOR = fillfactor
  | IGNORE_DUP_KEY = { ON | OFF }
  | STATISTICS_NORECOMPUTE = { ON | OFF }
  | STATISTICS_INCREMENTAL = { ON | OFF }
  | ALLOW_ROW_LOCKS = { ON | OFF }
  | ALLOW_PAGE_LOCKS = { ON | OFF }
  | OPTIMIZE_FOR_SEQUENTIAL_KEY = { ON | OFF }
  | COMPRESSION_DELAY = { 0 | delay [ Minutes ] }
  | DATA_COMPRESSION = { NONE | ROW | PAGE | COLUMNSTORE | COLUMNSTORE_ARCHIVE }
       [ ON PARTITIONS ( { partition_number_expression | <range> }
       [ , ...n ] ) ]
  | XML_COMPRESSION = { ON | OFF }
      [ ON PARTITIONS ( { <partition_number_expression> | <range> }
      [ , ...n ] ) ] ]
}

--declare-local-variable-transact-sql.md line: 123
DECLARE
{ { @local_variable [AS] data_type } [ = value [ COLLATE <collation_name> ] ] } [ ,...n ]

--declare-local-variable-transact-sql.md line: 279
USE AdventureWorks2022;
GO
DECLARE @find VARCHAR(30);
/* Also allowed:
DECLARE @find VARCHAR(30) = 'Man%';
*/
SET @find = 'Man%';
SELECT p.LastName, p.FirstName, ph.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS ph ON p.BusinessEntityID = ph.BusinessEntityID
WHERE LastName LIKE @find;

--declare-local-variable-transact-sql.md line: 295
LastName            FirstName               Phone
------------------- ----------------------- -------------------------
Manchepalli         Ajay                    1 (11) 500 555-0174
Manek               Parul                   1 (11) 500 555-0146
Manzanares          Tomas                   1 (11) 500 555-0178

(3 row(s) affected)

--declare-local-variable-transact-sql.md line: 309
USE AdventureWorks2022;
GO
SET NOCOUNT ON;
GO
DECLARE @Group nvarchar(50), @Sales MONEY;
SET @Group = N'North America';
SET @Sales = 2000000;
SET NOCOUNT OFF;
SELECT FirstName, LastName, SalesYTD
FROM Sales.vSalesPerson
WHERE TerritoryGroup = @Group and SalesYTD >= @Sales;
--! OUTPUT
--declare-local-variable-transact-sql.md line: 327
USE AdventureWorks2022;
GO
DECLARE @MyTableVar TABLE (
    EmpID INT NOT NULL,
    OldVacationHours INT,
    NewVacationHours INT,
    ModifiedDate DATETIME);
UPDATE TOP (10) HumanResources.Employee
SET VacationHours = VacationHours * 1.25
OUTPUT INSERTED.BusinessEntityID,
       DELETED.VacationHours,
       INSERTED.VacationHours,
       INSERTED.ModifiedDate
INTO @MyTableVar;
--Display the result set of the table variable.
SELECT EmpID, OldVacationHours, NewVacationHours, ModifiedDate
FROM @MyTableVar;
GO
--Display the result set of the table.
--Note that ModifiedDate reflects the value generated by an
--AFTER UPDATE trigger.
SELECT TOP (10) BusinessEntityID, VacationHours, ModifiedDate
FROM HumanResources.Employee;
GO
--! index
--declare-local-variable-transact-sql.md line: 358
DECLARE @MyTableVar TABLE (
    EmpID INT NOT NULL,
    PRIMARY KEY CLUSTERED (EmpID),
    UNIQUE NONCLUSTERED (EmpID),
    INDEX CustomNonClusteredIndex NONCLUSTERED (EmpID)
);
GO

--declare-local-variable-transact-sql.md line: 370
SELECT *
FROM tempdb.sys.indexes
WHERE object_id < 0;
GO

--declare-local-variable-transact-sql.md line: 381
DECLARE @LocationTVP
AS LocationTableType;

--declare-local-variable-transact-sql.md line: 392
-- Uses AdventureWorks

DECLARE @find VARCHAR(30);
/* Also allowed:
DECLARE @find VARCHAR(30) = 'Man%';
*/
SET @find = 'Walt%';

SELECT LastName, FirstName, Phone
FROM DimEmployee
WHERE LastName LIKE @find;

--declare-local-variable-transact-sql.md line: 410
-- Uses AdventureWorks

DECLARE @lastName VARCHAR(30), @firstName VARCHAR(30);

SET @lastName = 'Walt%';
SET @firstName = 'Bryan';

SELECT LastName, FirstName, Phone
FROM DimEmployee
WHERE LastName LIKE @lastName AND FirstName LIKE @firstName;


--divide-equals-transact-sql.md line: 32
expression /= expression  

--divide-equals-transact-sql.md line: 50
DECLARE @myVariable DECIMAL(5,2);
SET @myVariable = 17.5;
SET @myVariable /= 2;
SELECT @myVariable AS ResultVariable;  


--divide-transact-sql.md line: 31
dividend / divisor  

--divide-transact-sql.md line: 55
-- Uses AdventureWorks  
  
SELECT s.BusinessEntityID AS SalesPersonID, FirstName, LastName, SalesQuota, SalesQuota/12 AS 'Sales Target Per Month'  
FROM Sales.SalesPerson AS s   
JOIN HumanResources.Employee AS e   
    ON s.BusinessEntityID = e.BusinessEntityID  
JOIN Person.Person AS p   
    ON e.BusinessEntityID = p.BusinessEntityID;  

--divide-transact-sql.md line: 68
  
SalesPersonID FirstName    LastName          SalesQuota  Sales Target Per Month  
------------- ------------ ----------------- ----------- ------------------  
274           Stephen      Jiang             NULL        NULL  
275           Michael      Blythe            300000.00   25000.00  
276           Linda        Mitchell          250000.00   20833.3333  
277           Jillian      Carson            250000.00   20833.3333  
  

--divide-transact-sql.md line: 82
-- Uses AdventureWorks  
  
SELECT FirstName, LastName, VacationHours/SickLeaveHours AS PersonalTimeRatio  
FROM DimEmployee;  
  


--else-if-else-transact-sql.md line: 30
IF Boolean_expression   
     { sql_statement | statement_block }   
[ ELSE   
     { sql_statement | statement_block } ]   

--else-if-else-transact-sql.md line: 54
IF 1 = 1 PRINT 'Boolean_expression is true.'  
ELSE PRINT 'Boolean_expression is false.' ;  

--else-if-else-transact-sql.md line: 61
IF 1 = 2 PRINT 'Boolean_expression is true.'  
ELSE PRINT 'Boolean_expression is false.' ;  
GO  

--else-if-else-transact-sql.md line: 70
USE AdventureWorks2022;  
GO  
IF   
(SELECT COUNT(*) FROM Production.Product WHERE Name LIKE 'Touring-3000%' ) > 5  
PRINT 'There are more than 5 Touring-3000 bicycles.'  
ELSE PRINT 'There are 5 or less Touring-3000 bicycles.' ;  
GO  

--else-if-else-transact-sql.md line: 83
USE AdventureWorks2022;  
GO  
DECLARE @AvgWeight DECIMAL(8,2), @BikeCount INT  
IF   
(SELECT COUNT(*) FROM Production.Product WHERE Name LIKE 'Touring-3000%' ) > 5  
BEGIN  
   SET @BikeCount =   
        (SELECT COUNT(*)   
         FROM Production.Product   
         WHERE Name LIKE 'Touring-3000%');  
   SET @AvgWeight =   
        (SELECT AVG(Weight)   
         FROM Production.Product   
         WHERE Name LIKE 'Touring-3000%');  
   PRINT 'There are ' + CAST(@BikeCount AS VARCHAR(3)) + ' Touring-3000 bikes.'  
   PRINT 'The average weight of the top 5 Touring-3000 bikes is ' + CAST(@AvgWeight AS VARCHAR(8)) + '.';  
END  
ELSE   
BEGIN  
SET @AvgWeight =   
        (SELECT AVG(Weight)  
         FROM Production.Product   
         WHERE Name LIKE 'Touring-3000%' );  
   PRINT 'Average weight of the Touring-3000 bikes is ' + CAST(@AvgWeight AS VARCHAR(8)) + '.' ;  
END ;  
GO  

--else-if-else-transact-sql.md line: 115
DECLARE @Number INT;  
SET @Number = 50;  
IF @Number > 100  
   PRINT 'The number is large.';  
ELSE   
   BEGIN  
      IF @Number < 10  
      PRINT 'The number is small.';  
   ELSE  
      PRINT 'The number is medium.';  
   END ;  
GO  

--else-if-else-transact-sql.md line: 135
-- Uses AdventureWorks  
  
DECLARE @maxWeight FLOAT, @productKey INTEGER  
SET @maxWeight = 100.00  
SET @productKey = 424  
IF @maxWeight <= (SELECT Weight FROM DimProduct WHERE ProductKey=@productKey)   
    (SELECT @productKey, EnglishDescription, Weight, 'This product is too heavy to ship and is only available for pickup.' FROM DimProduct WHERE ProductKey=@productKey)  
ELSE  
    (SELECT @productKey, EnglishDescription, Weight, 'This product is available for shipping or pickup.' FROM DimProduct WHERE ProductKey=@productKey)  


--end-begin-end-transact-sql.md line: 31
BEGIN   
     { sql_statement | statement_block }   
END   

--end-begin-end-transact-sql.md line: 49
-- Uses AdventureWorks  
  
DECLARE @Iteration INTEGER = 0  
WHILE @Iteration <10  
BEGIN  
    SELECT FirstName, MiddleName   
    FROM dbo.DimCustomer WHERE LastName = 'Adams';  
SET @Iteration += 1  
END;  


--equals-transact-sql.md line: 33
expression = expression  

--equals-transact-sql.md line: 63
-- Uses AdventureWorks  
  
SELECT DepartmentID, Name  
FROM HumanResources.Department  
WHERE GroupName = 'Manufacturing';  

--equals-transact-sql.md line: 73
  
DepartmentID Name  
------------ --------------------------------------------------  
7            Production  
8            Production Control  
  
(2 row(s) affected)  
  

--equals-transact-sql.md line: 87
-- Create table t1 and insert 3 rows.  
CREATE TABLE dbo.t1 (a INT NULL);  
INSERT INTO dbo.t1 VALUES (NULL),(0),(1);  
GO  
  
-- Print message and perform SELECT statements.  
PRINT 'Testing default setting';  
DECLARE @varname int;   
SET @varname = NULL;  
  
SELECT a  
FROM t1   
WHERE a = @varname;  
  
SELECT a   
FROM t1   
WHERE a <> @varname;  
  
SELECT a   
FROM t1   
WHERE a IS NULL;  
GO  
  
-- SET ANSI_NULLS to ON and test.  
PRINT 'Testing ANSI_NULLS ON';  
SET ANSI_NULLS ON;  
GO  
DECLARE @varname int;  
SET @varname = NULL  
  
SELECT a   
FROM t1   
WHERE a = @varname;  
  
SELECT a   
FROM t1   
WHERE a <> @varname;  
  
SELECT a   
FROM t1   
WHERE a IS NULL;  
GO  
  
-- SET ANSI_NULLS to OFF and test.  
PRINT 'Testing SET ANSI_NULLS OFF';  
SET ANSI_NULLS OFF;  
GO  
DECLARE @varname int;  
SET @varname = NULL;  
SELECT a   
FROM t1   
WHERE a = @varname;  
  
SELECT a   
FROM t1   
WHERE a <> @varname;  
  
SELECT a   
FROM t1   
WHERE a IS NULL;  
GO  
  
-- Drop table t1.  
DROP TABLE dbo.t1;  

--equals-transact-sql.md line: 156
Testing default setting  
a  
-----------  
NULL  
  
(1 row(s) affected)  
  
a  
-----------  
0  
1  
  
(2 row(s) affected)  
  
a  
-----------  
NULL  
  
(1 row(s) affected)  
  
Testing ANSI_NULLS ON  
a  
-----------  
  
(0 row(s) affected)  
  
a  
-----------  
  
(0 row(s) affected)  
  
a  
-----------  
NULL  
  
(1 row(s) affected)  
  
Testing SET ANSI_NULLS OFF  
a  
-----------  
NULL  
  
(1 row(s) affected)  
  
a  
-----------  
0  
1  
  
(2 row(s) affected)  
  
a  
-----------  
NULL  
  
(1 row(s) affected)  
  


--execute-transact-sql.md line: 48
-- Syntax for SQL Server 2019 and later versions
  
Execute a stored procedure or function  
[ { EXEC | EXECUTE } ]  
    {   
      [ @return_status = ]  
      { module_name [ ;number ] | @module_name_var }   
        [ [ @parameter = ] { value   
                           | @variable [ OUTPUT ]   
                           | [ DEFAULT ]   
                           }  
        ]  
      [ ,...n ]  
      [ WITH <execute_option> [ ,...n ] ]  
    }  
[;]  
  
Execute a character string  
{ EXEC | EXECUTE }   
    ( { @string_variable | [ N ]'tsql_string' } [ + ...n ] )  
    [ AS { LOGIN | USER } = ' name ' ]  
[;]  
  
Execute a pass-through command against a linked server  
{ EXEC | EXECUTE }  
    ( { @string_variable | [ N ] 'command_string [ ? ]' } [ + ...n ]  
        [ { , { value | @variable [ OUTPUT ] } } [ ...n ] ]  
    )   
    [ AS { LOGIN | USER } = ' name ' ]  
    [ AT linked_server_name ]  
    [ AT DATA_SOURCE data_source_name ]  
[;]  
  
<execute_option>::=  
{  
        RECOMPILE   
    | { RESULT SETS UNDEFINED }   
    | { RESULT SETS NONE }   
    | { RESULT SETS ( <result_sets_definition> [,...n ] ) }  
}   
  
<result_sets_definition> ::=   
{  
    (  
         { column_name   
           data_type   
         [ COLLATE collation_name ]   
         [ NULL | NOT NULL ] }  
         [,...n ]  
    )  
    | AS OBJECT   
        [ db_name . [ schema_name ] . | schema_name . ]   
        {table_name | view_name | table_valued_function_name }  
    | AS TYPE [ schema_name.]table_type_name  
    | AS FOR XML   
}  

--execute-transact-sql.md line: 113
-- Syntax for SQL Server 2017 and earlier  
  
Execute a stored procedure or function  
[ { EXEC | EXECUTE } ]  
    {   
      [ @return_status = ]  
      { module_name [ ;number ] | @module_name_var }   
        [ [ @parameter = ] { value   
                           | @variable [ OUTPUT ]   
                           | [ DEFAULT ]   
                           }  
        ]  
      [ ,...n ]  
      [ WITH <execute_option> [ ,...n ] ]  
    }  
[;]  
  
Execute a character string  
{ EXEC | EXECUTE }   
    ( { @string_variable | [ N ]'tsql_string' } [ + ...n ] )  
    [ AS { LOGIN | USER } = ' name ' ]  
[;]  
  
Execute a pass-through command against a linked server  
{ EXEC | EXECUTE }  
    ( { @string_variable | [ N ] 'command_string [ ? ]' } [ + ...n ]  
        [ { , { value | @variable [ OUTPUT ] } } [ ...n ] ]  
    )   
    [ AS { LOGIN | USER } = ' name ' ]  
    [ AT linked_server_name ]  
[;]  
  
<execute_option>::=  
{  
        RECOMPILE   
    | { RESULT SETS UNDEFINED }   
    | { RESULT SETS NONE }   
    | { RESULT SETS ( <result_sets_definition> [,...n ] ) }  
}   
  
<result_sets_definition> ::=   
{  
    (  
         { column_name   
           data_type   
         [ COLLATE collation_name ]   
         [ NULL | NOT NULL ] }  
         [,...n ]  
    )  
    | AS OBJECT   
        [ db_name . [ schema_name ] . | schema_name . ]   
        {table_name | view_name | table_valued_function_name }  
    | AS TYPE [ schema_name.]table_type_name  
    | AS FOR XML   
}  

--execute-transact-sql.md line: 173
-- In-Memory OLTP   

Execute a natively compiled, scalar user-defined function  
[ { EXEC | EXECUTE } ]   
    {   
      [ @return_status = ]   
      { module_name | @module_name_var }   
        [ [ @parameter = ] { value   
                           | @variable   
                           | [ DEFAULT ]   
                           }  
        ]   
      [ ,...n ]   
      [ WITH <execute_option> [ ,...n ] ]   
    }  
<execute_option>::=  
{  
    | { RESULT SETS UNDEFINED }   
    | { RESULT SETS NONE }   
    | { RESULT SETS ( <result_sets_definition> [,...n ] ) }  
}  

--execute-transact-sql.md line: 197
-- Syntax for Azure SQL Database   
  
Execute a stored procedure or function  
[ { EXEC | EXECUTE } ]  
    {   
      [ @return_status = ]  
      { module_name  | @module_name_var }   
        [ [ @parameter = ] { value   
                           | @variable [ OUTPUT ]   
                           | [ DEFAULT ]   
                           }  
        ]  
      [ ,...n ]  
      [ WITH RECOMPILE ]  
    }  
[;]  
  
Execute a character string  
{ EXEC | EXECUTE }   
    ( { @string_variable | [ N ]'tsql_string' } [ + ...n ] )  
    [ AS {  USER } = ' name ' ]  
[;]  
  
<execute_option>::=  
{  
        RECOMPILE   
    | { RESULT SETS UNDEFINED }   
    | { RESULT SETS NONE }   
    | { RESULT SETS ( <result_sets_definition> [,...n ] ) }  
}   
  
<result_sets_definition> ::=   
{  
    (  
         { column_name   
           data_type   
         [ COLLATE collation_name ]   
         [ NULL | NOT NULL ] }  
         [,...n ]  
    )  
    | AS OBJECT   
        [ db_name . [ schema_name ] . | schema_name . ]   
        {table_name | view_name | table_valued_function_name }  
    | AS TYPE [ schema_name.]table_type_name  
    | AS FOR XML  
  

--execute-transact-sql.md line: 247
-- Syntax for Azure Synapse Analytics and Parallel Data Warehouse  

-- Execute a stored procedure  
[ { EXEC | EXECUTE } ]  
    procedure_name   
        [ { value | @variable [ OUT | OUTPUT ] } ] [ ,...n ] }  
[;]  
  
-- Execute a SQL string  
{ EXEC | EXECUTE }  
    ( { @string_variable | [ N ] 'tsql_string' } [ +...n ] )  
[;]  

--execute-transact-sql.md line: 263
-- Syntax for Microsoft Fabric

-- Execute a stored procedure  
[ { EXEC | EXECUTE } ]  
    procedure_name   
        [ { value | @variable [ OUT | OUTPUT ] } ] [ ,...n ]  
        [ WITH <execute_option> [ ,...n ] ]  }  
[;]  
  
-- Execute a SQL string  
{ EXEC | EXECUTE }  
    ( { @string_variable | [ N ] 'tsql_string' } [ +...n ] )  
[;]  

<execute_option>::=  
{  
        RECOMPILE   
    | { RESULT SETS UNDEFINED }   
    | { RESULT SETS NONE }   
    | { RESULT SETS ( <result_sets_definition> [,...n ] ) }  
}   
--! execute 
--execute-transact-sql.md line: 456
USE master; EXEC ('USE AdventureWorks2022; SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee;');  

--execute-transact-sql.md line: 496
EXEC dbo.uspGetEmployeeManagers 6;  
GO  

--execute-transact-sql.md line: 503
EXEC dbo.uspGetEmployeeManagers @EmployeeID = 6;  
GO  

--execute-transact-sql.md line: 510
dbo.uspGetEmployeeManagers 6;  
GO  
--Or  
dbo.uspGetEmployeeManagers @EmployeeID = 6;  
GO  

--execute-transact-sql.md line: 521
DECLARE @CheckDate DATETIME;  
SET @CheckDate = GETDATE();  
EXEC dbo.uspGetWhereUsedProductID 819, @CheckDate;  
GO  
--! CURSOR
--execute-transact-sql.md line: 531
DECLARE tables_cursor CURSOR  
   FOR  
   SELECT s.name, t.name   
   FROM sys.objects AS t  
   JOIN sys.schemas AS s ON s.schema_id = t.schema_id  
   WHERE t.type = 'U';  
OPEN tables_cursor;  
DECLARE @schemaname sysname;  
DECLARE @tablename sysname;  
FETCH NEXT FROM tables_cursor INTO @schemaname, @tablename;  
WHILE (@@FETCH_STATUS <> -1)  
BEGIN;  
   EXECUTE ('ALTER INDEX ALL ON ' + @schemaname + '.' + @tablename + ' REBUILD;');  
   FETCH NEXT FROM tables_cursor INTO @schemaname, @tablename;  
END;  
PRINT 'The indexes on all tables have been rebuilt.';  
CLOSE tables_cursor;  
DEALLOCATE tables_cursor;  
GO  
  

--execute-transact-sql.md line: 559
DECLARE @retstat INT;  
EXECUTE @retstat = SQLSERVER1.AdventureWorks2022.dbo.uspGetEmployeeManagers @BusinessEntityID = 6;  

--execute-transact-sql.md line: 567
DECLARE @proc_name VARCHAR(30);  
SET @proc_name = 'sys.sp_who';  
EXEC @proc_name;  
  

--execute-transact-sql.md line: 577
IF OBJECT_ID(N'dbo.ProcTestDefaults', N'P')IS NOT NULL  
   DROP PROCEDURE dbo.ProcTestDefaults;  
GO  
-- Create the stored procedure.  
CREATE PROCEDURE dbo.ProcTestDefaults (  
@p1 SMALLINT = 42,   
@p2 CHAR(1),   
@p3 VARCHAR(8) = 'CAR')  
AS   
   SET NOCOUNT ON;  
   SELECT @p1, @p2, @p3  
;  
GO  

--execute-transact-sql.md line: 595
-- Specifying a value only for one parameter (@p2).  
EXECUTE dbo.ProcTestDefaults @p2 = 'A';  
-- Specifying a value for the first two parameters.  
EXECUTE dbo.ProcTestDefaults 68, 'B';  
-- Specifying a value for all three parameters.  
EXECUTE dbo.ProcTestDefaults 68, 'C', 'House';  
-- Using the DEFAULT keyword for the first parameter.  
EXECUTE dbo.ProcTestDefaults @p1 = DEFAULT, @p2 = 'D';  
-- Specifying the parameters in an order different from the order defined in the procedure.  
EXECUTE dbo.ProcTestDefaults DEFAULT, @p3 = 'Local', @p2 = 'E';  
-- Using the DEFAULT keyword for the first and third parameters.  
EXECUTE dbo.ProcTestDefaults DEFAULT, 'H', DEFAULT;  
EXECUTE dbo.ProcTestDefaults DEFAULT, 'I', @p3 = DEFAULT;  
  

--execute-transact-sql.md line: 617
EXEC sp_addlinkedserver 'SeattleSales', 'SQL Server'  
GO  
EXECUTE ( 'CREATE TABLE AdventureWorks2022.dbo.SalesTbl   
(SalesID int, SalesName varchar(10)) ; ' ) AT SeattleSales;  
GO  
--! WITH RECOMPILE can improve the procedure's processing performance becouse it could change execution plan.
--execute-transact-sql.md line: 628
EXECUTE dbo.Proc_Test_Defaults @p2 = 'A' WITH RECOMPILE;  
GO  

--execute-transact-sql.md line: 636
DECLARE @returnstatus NVARCHAR(15);  
SET @returnstatus = NULL;  
EXEC @returnstatus = dbo.ufnGetSalesOrderStatusText @Status = 2;  
PRINT @returnstatus;  
GO  

--execute-transact-sql.md line: 649
-- Setup the linked server.  
EXEC sp_addlinkedserver    
        @server='ORACLE',  
        @srvproduct='Oracle',  
        @provider='OraOLEDB.Oracle',   
        @datasrc='ORACLE10';  
  
EXEC sp_addlinkedsrvlogin   
    @rmtsrvname='ORACLE',  
    @useself='false',   
    @locallogin=null,   
    @rmtuser='scott',   
    @rmtpassword='tiger';  
  
EXEC sp_serveroption 'ORACLE', 'rpc out', true;  
GO  
--! Execute AT  
-- Execute several statements on the linked Oracle server.  
EXEC ( 'SELECT * FROM scott.emp') AT ORACLE;  
GO  
EXEC ( 'SELECT * FROM scott.emp WHERE MGR = ?', 7902) AT ORACLE;  
GO  
DECLARE @v INT;   
SET @v = 7902;  
EXEC ( 'SELECT * FROM scott.emp WHERE MGR = ?', @v) AT ORACLE;  
GO   

--execute-transact-sql.md line: 681
EXECUTE ('CREATE TABLE Sales.SalesTable (SalesID INT, SalesName VARCHAR(10));')  
AS USER = 'User1';  
GO  

--execute-transact-sql.md line: 692
-- Setup the linked server.  
EXEC sp_addlinkedserver 'SeattleSales', 'SQL Server'  
GO  
-- Execute the SELECT statement.  
EXECUTE ('SELECT ProductID, Name   
    FROM AdventureWorks2022.Production.Product  
    WHERE ProductID = ? ', 952) AT SeattleSales;  
GO  

--execute-transact-sql.md line: 708
EXEC uspGetEmployeeManagers 16  
WITH RESULT SETS  
(   
   ([Reporting Level] INT NOT NULL,  
    [ID of Employee] INT NOT NULL,  
    [Employee First Name] NVARCHAR(50) NOT NULL,  
    [Employee Last Name] NVARCHAR(50) NOT NULL,  
    [Employee ID of Manager] NVARCHAR(max) NOT NULL,  
    [Manager First Name] NVARCHAR(50) NOT NULL,  
    [Manager Last Name] NVARCHAR(50) NOT NULL )  
);  
  

--execute-transact-sql.md line: 728
--Create the procedure  
CREATE PROC Production.ProductList @ProdName NVARCHAR(50)  
AS  
-- First result set  
SELECT ProductID, Name, ListPrice  
    FROM Production.Product  
    WHERE Name LIKE @ProdName;  
-- Second result set   
SELECT Name, COUNT(S.ProductID) AS NumberOfOrders  
    FROM Production.Product AS P  
    JOIN Sales.SalesOrderDetail AS S  
        ON P.ProductID  = S.ProductID   
    WHERE Name LIKE @ProdName  
    GROUP BY Name;  
GO  
--! EXEC  WITH RESULT SETS ()  преобразование ответа в другой формат,  получение двух  select из процедуры интересно
-- Execute the procedure   
EXEC Production.ProductList '%tire%'  
WITH RESULT SETS   
(  
    (ProductID INT,   -- first result set definition starts here  
    Name NAME,  
    ListPrice MONEY)  
    ,                 -- comma separates result set definitions  
    (Name NAME,       -- second result set definition starts here  
    NumberOfOrders INT)  
);  
  
--! execute EXTERNAL
--execute-transact-sql.md line: 764
EXECUTE ( 'SELECT @@SERVERNAME' ) AT DATA_SOURCE my_sql_server;  
GO  

--execute-transact-sql.md line: 775
CREATE EXTERNAL DATA SOURCE SqlComputePool 
WITH (LOCATION = 'sqlcomputepool://controller-svc/default');
EXECUTE ( 'SELECT @@SERVERNAME' ) AT DATA_SOURCE SqlComputePool;  
GO  

--execute-transact-sql.md line: 787
CREATE EXTERNAL DATA SOURCE SqlDataPool 
WITH (LOCATION = 'sqldatapool://controller-svc/default');
EXECUTE ( 'SELECT @@SERVERNAME' ) AT DATA_SOURCE SqlDataPool;  
GO  

--execute-transact-sql.md line: 800
CREATE EXTERNAL DATA SOURCE SqlStoragePool
WITH (LOCATION = 'sqlhdfs://controller-svc/default');
EXECUTE ( 'SELECT @@SERVERNAME' ) AT DATA_SOURCE SqlStoragePool;  
GO  

--execute-transact-sql.md line: 813
EXEC proc1;  

--execute-transact-sql.md line: 819
EXEC ('EXEC ' + @var);  

--execute-transact-sql.md line: 825
CREATE sp_first AS EXEC sp_second; EXEC sp_third;  

--execute-transact-sql.md line: 832
EXEC ('SELECT * FROM sys.types');  

--execute-transact-sql.md line: 838
EXEC ('EXEC (''SELECT * FROM sys.types'')');  

--execute-transact-sql.md line: 844
DECLARE @stringVar NVARCHAR(100);  
SET @stringVar = N'SELECT name FROM' + ' sys.sql_logins';  
EXEC (@stringVar);  

--execute-transact-sql.md line: 854
-- Uses AdventureWorks  
  
CREATE PROC ProcWithParameters  
    @name NVARCHAR(50),  
@color NVARCHAR(15)  
AS   
SELECT ProductKey, EnglishProductName, Color FROM [dbo].[DimProduct]  
WHERE EnglishProductName LIKE @name  
AND Color = @color;  
GO  
  
-- Executing using positional parameters  
EXEC ProcWithParameters N'%arm%', N'Black';  
-- Executing using named parameters in order  
EXEC ProcWithParameters @name = N'%arm%', @color = N'Black';  
-- Executing using named parameters out of order  
EXEC ProcWithParameters @color = N'Black', @name = N'%arm%';  
GO  

--! EXISTS 
--exists-transact-sql.md line: 35
EXISTS ( subquery )  

--exists-transact-sql.md line: 56
-- Uses AdventureWorks  
  
SELECT DepartmentID, Name   
FROM HumanResources.Department   
WHERE EXISTS (SELECT NULL)  
ORDER BY Name ASC ;  

--exists-transact-sql.md line: 68
-- Uses AdventureWorks  
  
SELECT a.FirstName, a.LastName  
FROM Person.Person AS a  
WHERE EXISTS  
(SELECT *   
    FROM HumanResources.Employee AS b  
    WHERE a.BusinessEntityID = b.BusinessEntityID  
    AND a.LastName = 'Johnson') ;  
GO  

--exists-transact-sql.md line: 83
-- Uses AdventureWorks  
--! IN
SELECT a.FirstName, a.LastName  
FROM Person.Person AS a  
WHERE a.LastName IN  
(SELECT a.LastName  
    FROM HumanResources.Employee AS b  
    WHERE a.BusinessEntityID = b.BusinessEntityID  
    AND a.LastName = 'Johnson') ;  
GO  

--exists-transact-sql.md line: 98
FirstName                                          LastName
-------------------------------------------------- ----------
Barry                                              Johnson
David                                              Johnson
Willis                                             Johnson
  
(3 row(s) affected)

--exists-transact-sql.md line: 111
-- Uses AdventureWorks  
  
SELECT DISTINCT s.Name  
FROM Sales.Store AS s   
WHERE EXISTS  
(SELECT *  
    FROM Purchasing.Vendor AS v  
    WHERE s.Name = v.Name) ;  
GO  

--exists-transact-sql.md line: 125
-- Uses AdventureWorks  
--! ANY  
SELECT DISTINCT s.Name  
FROM Sales.Store AS s   
WHERE s.Name = ANY  
(SELECT v.Name  
    FROM Purchasing.Vendor AS v ) ;  
GO  

--exists-transact-sql.md line: 139
-- Uses AdventureWorks  
  
SELECT p.FirstName, p.LastName, e.JobTitle  
FROM Person.Person AS p   
JOIN HumanResources.Employee AS e  
   ON e.BusinessEntityID = p.BusinessEntityID   
WHERE EXISTS  
(SELECT *  
    FROM HumanResources.Department AS d  
    JOIN HumanResources.EmployeeDepartmentHistory AS edh  
       ON d.DepartmentID = edh.DepartmentID  
    WHERE e.BusinessEntityID = edh.BusinessEntityID  
    AND d.Name LIKE 'P%') ;  
GO  

--exists-transact-sql.md line: 158
-- Uses AdventureWorks  
  
SELECT p.FirstName, p.LastName, e.JobTitle  
FROM Person.Person AS p JOIN HumanResources.Employee AS e  
   ON e.BusinessEntityID = p.BusinessEntityID   
JOIN HumanResources.EmployeeDepartmentHistory AS edh  
   ON e.BusinessEntityID = edh.BusinessEntityID   
WHERE edh.DepartmentID IN  
(SELECT DepartmentID  
   FROM HumanResources.Department  
   WHERE Name LIKE 'P%') ;  
GO  

--exists-transact-sql.md line: 176
SELECT p.FirstName, p.LastName, e.JobTitle  
FROM Person.Person AS p   
JOIN HumanResources.Employee AS e  
   ON e.BusinessEntityID = p.BusinessEntityID   
WHERE NOT EXISTS  
(SELECT *  
   FROM HumanResources.Department AS d  
   JOIN HumanResources.EmployeeDepartmentHistory AS edh  
      ON d.DepartmentID = edh.DepartmentID  
   WHERE e.BusinessEntityID = edh.BusinessEntityID  
   AND d.Name LIKE 'P%')  
ORDER BY LastName, FirstName  
GO  

--exists-transact-sql.md line: 194
FirstName                      LastName                       Title
------------------------------ ------------------------------ ------------
Syed                           Abbas                          Pacific Sales Manager
Hazem                          Abolrous                       Quality Assurance Manager
Humberto                       Acevedo                        Application Specialist
Pilar                          Ackerman                       Shipping & Receiving Superviso
François                       Ajenstat                       Database Administrator
Amy                            Alberts                        European Sales Manager
Sean                           Alexander                      Quality Assurance Technician
Pamela                         Ansman-Wolfe                   Sales Representative
Zainal                         Arifin                         Document Control Manager
David                          Barber                         Assistant to CFO
Paula                          Barreto de Mattos              Human Resources Manager
Shai                           Bassli                         Facilities Manager
Wanida                         Benshoof                       Marketing Assistant
Karen                          Berg                           Application Specialist
Karen                          Berge                          Document Control Assistant
Andreas                        Berglund                       Quality Assurance Technician
Matthias                       Berndt                         Shipping & Receiving Clerk
Jo                             Berry                          Janitor
Jimmy                          Bischoff                       Stocker
Michael                        Blythe                         Sales Representative
David                          Bradley                        Marketing Manager
Kevin                          Brown                          Marketing Assistant
David                          Campbell                       Sales Representative
Jason                          Carlson                        Information Services Manager
Fernando                       Caro                           Sales Representative
Sean                           Chai                           Document Control Assistant
Sootha                         Charncherngkha                 Quality Assurance Technician
Hao                            Chen                           HR Administrative Assistant
Kevin                          Chrisulis                      Network Administrator
Pat                            Coleman                        Janitor
Stephanie                      Conroy                         Network Manager
Debra                          Core                           Application Specialist
Ovidiu                         Crãcium                        Sr. Tool Designer
Grant                          Culbertson                     HR Administrative Assistant
Mary                           Dempsey                        Marketing Assistant
Thierry                        DHers                         Tool Designer
Terri                          Duffy                          VP Engineering
Susan                          Eaton                          Stocker
Terry                          Eminhizer                      Marketing Specialist
Gail                           Erickson                       Design Engineer
Janice                         Galvin                         Tool Designer
Mary                           Gibson                         Marketing Specialist
Jossef                         Goldberg                       Design Engineer
Sariya                         Harnpadoungsataya              Marketing Specialist
Mark                           Harrington                     Quality Assurance Technician
Magnus                         Hedlund                        Facilities Assistant
Shu                            Ito                            Sales Representative
Stephen                        Jiang                          North American Sales Manager
Willis                         Johnson                        Recruiter
Brannon                        Jones                          Finance Manager
Tengiz                         Kharatishvili                  Control Specialist
Christian                      Kleinerman                     Maintenance Supervisor
Vamsi                          Kuppa                          Shipping & Receiving Clerk
David                          Liu                            Accounts Manager
Vidur                          Luthra                         Recruiter
Stuart                         Macrae                         Janitor
Diane                          Margheim                       Research & Development Enginee
Mindy                          Martin                         Benefits Specialist
Gigi                           Matthew                        Research & Development Enginee
Tete                           Mensa-Annan                    Sales Representative
Ramesh                         Meyyappan                      Application Specialist
Dylan                          Miller                         Research & Development Manager
Linda                          Mitchell                       Sales Representative
Barbara                        Moreland                       Accountant
Laura                          Norman                         Chief Financial Officer
Chris                          Norred                         Control Specialist
Jae                            Pak                            Sales Representative
Wanda                          Parks                          Janitor
Deborah                        Poe                            Accounts Receivable Specialist
Kim                            Ralls                          Stocker
Tsvi                           Reiter                         Sales Representative
Sharon                         Salavaria                      Design Engineer
Ken                            Sanchez                        Chief Executive Officer
José                           Saraiva                        Sales Representative
Mike                           Seamans                        Accountant
Ashvini                        Sharma                         Network Administrator
Janet                          Sheperdigian                   Accounts Payable Specialist
Candy                          Spoon                          Accounts Receivable Specialist
Michael                        Sullivan                       Sr. Design Engineer
Dragan                         Tomic                          Accounts Payable Specialist
Lynn                           Tsoflias                       Sales Representative
Rachel                         Valdez                         Sales Representative
Garrett                        Vargar                         Sales Representative
Ranjit                         Varkey Chudukatil              Sales Representative
Bryan                          Walton                         Accounts Receivable Specialist
Jian Shuo                      Wang                           Engineering Manager
Brian                          Welcker                        VP Sales
Jill                           Williams                       Marketing Specialist
Dan                            Wilson                         Database Administrator
John                           Wood                           Marketing Specialist
Peng                           Wu                             Quality Assurance Supervisor
  
(91 row(s) affected)

--exists-transact-sql.md line: 297
-- Uses AdventureWorks  
  
SELECT a.LastName, a.BirthDate  
FROM DimCustomer AS a  
WHERE EXISTS  
(SELECT *   
    FROM dbo.ProspectiveBuyer AS b  
    WHERE (a.LastName = b.LastName) AND (a.BirthDate = b.BirthDate)) ;  

--exists-transact-sql.md line: 311
-- Uses AdventureWorks  
  
SELECT a.LastName, a.BirthDate  
FROM DimCustomer AS a  
WHERE NOT EXISTS  
(SELECT *   
    FROM dbo.ProspectiveBuyer AS b  
    WHERE (a.LastName = b.LastName) AND (a.BirthDate = b.BirthDate)) ;  


--expressions-transact-sql.md line: 31
-- Syntax for SQL Server and Azure SQL Database  
  
{ constant | scalar_function | [ table_name. ] column | variable   
    | ( expression ) | ( scalar_subquery )   
    | { unary_operator } expression   
    | expression { binary_operator } expression   
    | ranking_windowed_function | aggregate_windowed_function  
}  

--expressions-transact-sql.md line: 42
-- Syntax for Azure Synapse Analytics and Parallel Data Warehouse  

-- Expression in a SELECT statement  
<expression> ::=   
{  
    constant   
    | scalar_function   
    | column  
    | variable  
    | ( expression  )  
    | { unary_operator } expression   
    | expression { binary_operator } expression   
}  
[ COLLATE Windows_collation_name ]  
  
-- Scalar Expression in a DECLARE, SET, IF...ELSE, or WHILE statement  
<scalar_expression> ::=  
{  
    constant   
    | scalar_function   
    | variable  
    | ( expression  )  
    | (scalar_subquery )  
    | { unary_operator } expression   
    | expression { binary_operator } expression   
}  
[ COLLATE { Windows_collation_name ]  
  

--expressions-transact-sql.md line: 115
USE AdventureWorks2022;  
GO  
SELECT ProductID, 1+2  
FROM Production.Product;  
GO  

--expressions-transact-sql.md line: 127
DELETE FROM dbo.MyTable 
WHERE
(c1 = '0000001' AND c2 = 'A000001') or
(c1 = '0000002' AND c2 = 'A000002') or
(c1 = '0000003' AND c2 = 'A000003') 
/* ... additional, similar expressions omitted for simplicity */

--expressions-transact-sql.md line: 137
DELETE FROM dbo.MyTable WHERE (c1 = '0000001' AND c2 = 'A000001');
DELETE FROM dbo.MyTable WHERE (c1 = '0000002' AND c2 = 'A000002');
DELETE FROM dbo.MyTable WHERE (c1 = '0000003' AND c2 = 'A000003');
/* ... refactored, individual DELETE statements omitted for simplicity  */

--! FETCH  NEXT | PRIOR | FIRST | LAST   | ABSOLUTE { n | @nvar } | RELATIVE { n | @nvar }
--fetch-transact-sql.md line: 33
FETCH   
          [ [ NEXT | PRIOR | FIRST | LAST   
                    | ABSOLUTE { n | @nvar }   
                    | RELATIVE { n | @nvar }   
               ]   
               FROM   
          ]   
{ { [ GLOBAL ] cursor_name } | @cursor_variable_name }   
[ INTO @variable_name [ ,...n ] ]   

--fetch-transact-sql.md line: 99
USE AdventureWorks2022;  
GO  
DECLARE contact_cursor CURSOR FOR  
SELECT LastName FROM Person.Person  
WHERE LastName LIKE 'B%'  
ORDER BY LastName;  
  
OPEN contact_cursor;  
  
-- Perform the first fetch.  
FETCH NEXT FROM contact_cursor;  
  
-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
WHILE @@FETCH_STATUS = 0  
BEGIN  
   -- This is executed as long as the previous fetch succeeds.  
   FETCH NEXT FROM contact_cursor;  
END  
  
CLOSE contact_cursor;  
DEALLOCATE contact_cursor;  
GO  

--fetch-transact-sql.md line: 127
USE AdventureWorks2022;  
GO  
-- Declare the variables to store the values returned by FETCH.  
DECLARE @LastName VARCHAR(50), @FirstName VARCHAR(50);  
  
DECLARE contact_cursor CURSOR FOR  
SELECT LastName, FirstName FROM Person.Person  
WHERE LastName LIKE 'B%'  
ORDER BY LastName, FirstName;  
  
OPEN contact_cursor;  
  
-- Perform the first fetch and store the values in variables.  
-- Note: The variables are in the same order as the columns  
-- in the SELECT statement.   
  
FETCH NEXT FROM contact_cursor  
INTO @LastName, @FirstName;  
  
-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
WHILE @@FETCH_STATUS = 0  
BEGIN  
  
   -- Concatenate and display the current values in the variables.  
   PRINT 'Contact Name: ' + @FirstName + ' ' +  @LastName  
  
   -- This is executed as long as the previous fetch succeeds.  
   FETCH NEXT FROM contact_cursor  
   INTO @LastName, @FirstName;  
END  
  
CLOSE contact_cursor;  
DEALLOCATE contact_cursor;  
GO  

--fetch-transact-sql.md line: 167
USE AdventureWorks2022;  
GO  
-- Execute the SELECT statement alone to show the   
-- full result set that is used by the cursor.  
SELECT LastName, FirstName FROM Person.Person  
ORDER BY LastName, FirstName;  
  
-- Declare the cursor.  
DECLARE contact_cursor SCROLL CURSOR FOR  
SELECT LastName, FirstName FROM Person.Person  
ORDER BY LastName, FirstName;  
  
OPEN contact_cursor;  
  
-- Fetch the last row in the cursor.  
FETCH LAST FROM contact_cursor;  
  
-- Fetch the row immediately prior to the current row in the cursor.  
FETCH PRIOR FROM contact_cursor;  
  
-- Fetch the second row in the cursor.  
FETCH ABSOLUTE 2 FROM contact_cursor;  
  
-- Fetch the row that is three rows after the current row.  
FETCH RELATIVE 3 FROM contact_cursor;  
  
-- Fetch the row that is two rows prior to the current row.  
FETCH RELATIVE -2 FROM contact_cursor;  
  
CLOSE contact_cursor;  
DEALLOCATE contact_cursor;  
GO  

--! GOTO
--goto-transact-sql.md line: 31
  
Define the label:   
label:   
Alter the execution:  
GOTO label   

--goto-transact-sql.md line: 54
DECLARE @Counter int;  
SET @Counter = 1;  
WHILE @Counter < 10  
BEGIN   
    SELECT @Counter  
    SET @Counter = @Counter + 1  
    IF @Counter = 4 GOTO Branch_One --Jumps to the first branch.  
    IF @Counter = 5 GOTO Branch_Two  --This will never execute.  
END  
Branch_One:  
    SELECT 'Jumping To Branch One.'  
    GOTO Branch_Three; --This will prevent Branch_Two from executing.  
Branch_Two:  
    SELECT 'Jumping To Branch Two.'  
Branch_Three:  
    SELECT 'Jumping To Branch Three.';  


--greater-than-or-equal-to-transact-sql.md line: 31
expression >= expression  

--greater-than-or-equal-to-transact-sql.md line: 54
-- Uses AdventureWorks  
  
SELECT DepartmentID, Name  
FROM HumanResources.Department  
WHERE DepartmentID >= 13  
ORDER BY DepartmentID;   

--greater-than-or-equal-to-transact-sql.md line: 65
DepartmentID Name  
------------ --------------------------------------------------  
13           Quality Assurance  
14           Facilities and Maintenance  
15           Shipping and Receiving  
16           Executive  
  
(4 row(s) affected)  
  


--greater-than-transact-sql.md line: 29
expression > expression  

--greater-than-transact-sql.md line: 47
--Uses AdventureWorks  
  
SELECT DepartmentID, Name  
FROM HumanResources.Department  
WHERE DepartmentID > 13  
ORDER BY DepartmentID;  
  

--greater-than-transact-sql.md line: 59
DepartmentID Name  
------------ --------------------------------------------------  
14           Facilities and Maintenance  
15           Shipping and Receiving  
16           Executive  
  
(3 row(s) affected)  
  

--greater-than-transact-sql.md line: 72
DECLARE @a INT = 45, @b INT = 40;  
SELECT IIF ( @a > @b, 'TRUE', 'FALSE' ) AS Result;  

--greater-than-transact-sql.md line: 79
Result  
------  
TRUE  
  
(1 row(s) affected)  
  


--if-else-transact-sql.md line: 31
IF Boolean_expression   
     { sql_statement | statement_block }   
[ ELSE   
     { sql_statement | statement_block } ]   

--if-else-transact-sql.md line: 56
IF DATENAME(weekday, GETDATE()) IN (N'Saturday', N'Sunday')
       SELECT 'Weekend';
ELSE 
       SELECT 'Weekday';

--if-else-transact-sql.md line: 68
-- Uses AdventureWorksDW  

DECLARE @maxWeight FLOAT, @productKey INTEGER  
SET @maxWeight = 100.00  
SET @productKey = 424  
IF @maxWeight <= (SELECT Weight from DimProduct WHERE ProductKey = @productKey)   
    SELECT @productKey AS ProductKey, EnglishDescription, Weight, 'This product is too heavy to ship and is only available for pickup.' 
        AS ShippingStatus
    FROM DimProduct WHERE ProductKey = @productKey
ELSE  
    SELECT @productKey AS ProductKey, EnglishDescription, Weight, 'This product is available for shipping or pickup.' 
        AS ShippingStatus
    FROM DimProduct WHERE ProductKey = @productKey


--in-transact-sql.md line: 33
test_expression [ NOT ] IN   
    ( subquery | expression [ ,...n ]  
    )   
--! IN like Where
--in-transact-sql.md line: 78
-- Uses AdventureWorks  
  
SELECT p.FirstName, p.LastName, e.JobTitle  
FROM Person.Person AS p  
JOIN HumanResources.Employee AS e  
    ON p.BusinessEntityID = e.BusinessEntityID  
WHERE e.JobTitle = 'Design Engineer'   
   OR e.JobTitle = 'Tool Designer'   
   OR e.JobTitle = 'Marketing Assistant';  
GO  

--in-transact-sql.md line: 93
-- Uses AdventureWorks  
  
SELECT p.FirstName, p.LastName, e.JobTitle  
FROM Person.Person AS p  
JOIN HumanResources.Employee AS e  
    ON p.BusinessEntityID = e.BusinessEntityID  
WHERE e.JobTitle IN ('Design Engineer', 'Tool Designer', 'Marketing Assistant');  
GO  

--in-transact-sql.md line: 106
FirstName   LastName      Title  
---------   ---------   ---------------------  
Sharon      Salavaria   Design Engineer                                     
Gail        Erickson    Design Engineer                                     
Jossef      Goldberg    Design Engineer                                     
Janice      Galvin      Tool Designer                                       
Thierry     DHers      Tool Designer                                       
Wanida      Benshoof    Marketing Assistant                                 
Kevin       Brown       Marketing Assistant                                 
Mary        Dempsey     Marketing Assistant                                 
  
(8 row(s) affected)  

--in-transact-sql.md line: 124
-- Uses AdventureWorks  
  
SELECT p.FirstName, p.LastName  
FROM Person.Person AS p  
    JOIN Sales.SalesPerson AS sp  
    ON p.BusinessEntityID = sp.BusinessEntityID  
WHERE p.BusinessEntityID IN  
   (SELECT BusinessEntityID  
   FROM Sales.SalesPerson  
   WHERE SalesQuota > 250000);  
GO  

--in-transact-sql.md line: 140
FirstName   LastName                                             
---------   --------   
Tsvi         Reiter                                              
Michael      Blythe                                              
Tete         Mensa-Annan                                         
  
(3 row(s) affected)  

--in-transact-sql.md line: 153
-- Uses AdventureWorks  
  
SELECT p.FirstName, p.LastName  
FROM Person.Person AS p  
    JOIN Sales.SalesPerson AS sp  
    ON p.BusinessEntityID = sp.BusinessEntityID  
WHERE p.BusinessEntityID NOT IN  
   (SELECT BusinessEntityID  
   FROM Sales.SalesPerson  
   WHERE SalesQuota > 250000);  
GO  

--in-transact-sql.md line: 172
-- Uses AdventureWorks  
  
SELECT * FROM FactInternetSalesReason   
WHERE SalesReasonKey   
IN (SELECT SalesReasonKey FROM DimSalesReason);   

--in-transact-sql.md line: 182
-- Uses AdventureWorks  
  
SELECT * FROM FactInternetSalesReason   
WHERE SalesReasonKey   
NOT IN (SELECT SalesReasonKey FROM DimSalesReason);  

--in-transact-sql.md line: 193
-- Uses AdventureWorks  
  
SELECT FirstName, LastName  
FROM DimEmployee  
WHERE FirstName IN ('Mike', 'Michael');  

--! QUERY NOTIFICATION
--kill-query-notification-subscription-transact-sql.md line: 31
KILL QUERY NOTIFICATION SUBSCRIPTION   
   { ALL | subscription_id }  

--kill-query-notification-subscription-transact-sql.md line: 60
KILL QUERY NOTIFICATION SUBSCRIPTION ALL ;  

--kill-query-notification-subscription-transact-sql.md line: 67
KILL QUERY NOTIFICATION SUBSCRIPTION 73 ;  

--! KILL STATS JOB 
--kill-stats-job-transact-sql.md line: 32
KILL STATS JOB job_id   

--kill-stats-job-transact-sql.md line: 53
KILL STATS JOB 53;  
GO  

--! Kill session
--kill-transact-sql.md line: 46
-- Syntax for SQL Server  
  
KILL { session ID [ WITH STATUSONLY ] | UOW [ WITH STATUSONLY | COMMIT | ROLLBACK ] }    


--kill-transact-sql.md line: 53
-- Syntax for Azure Synapse Analytics and Parallel Data Warehouse and Microsoft Fabric
  
KILL 'session_id'  
[;]   

--kill-transact-sql.md line: 69
 SELECT conn.session_id, host_name, program_name,
     nt_domain, login_name, connect_time, last_request_end_time 
FROM sys.dm_exec_sessions AS sess
JOIN sys.dm_exec_connections AS conn
    ON sess.session_id = conn.session_id;


--kill-transact-sql.md line: 121
"Msg 6120, Level 16, State 1, Line 1"  
"Status report cannot be obtained. Rollback operation for Process ID <session ID> is not in progress."

--kill-transact-sql.md line: 143
KILL 53;  
GO  

--kill-transact-sql.md line: 151
KILL 54;  
KILL 54 WITH STATUSONLY;  
GO  
  
--This is the progress report.  
spid 54: Transaction rollback in progress. Estimated rollback completion: 80% Estimated time left: 10 seconds.  

--kill-transact-sql.md line: 163
KILL 'D5499C66-E398-45CA-BF7E-DC9C194B48CF';  



--less-than-or-equal-to-transact-sql.md line: 32
expression <= expression  

--less-than-or-equal-to-transact-sql.md line: 54
-- Uses AdventureWorks  
  
SELECT DepartmentID, Name  
FROM HumanResources.Department  
WHERE DepartmentID <= 3  
ORDER BY DepartmentID;  

--less-than-or-equal-to-transact-sql.md line: 65
DepartmentID Name  
------------ --------------------------------------------------  
1            Engineering  
2            Tool Design  
3            Sales  
  
(3 row(s) affected)  
  


--less-than-transact-sql.md line: 30
expression < expression  

--less-than-transact-sql.md line: 48
-- Uses AdventureWorks  
  
SELECT DepartmentID, Name  
FROM HumanResources.Department  
WHERE DepartmentID < 3  
ORDER BY DepartmentID;

--less-than-transact-sql.md line: 59
DepartmentID Name  
------------ --------------------------------------------------  
1            Engineering  
2            Tool Design  
  
(2 row(s) affected)  
  

--less-than-transact-sql.md line: 71
DECLARE @a INT = 45, @b INT = 40;  
SELECT IIF ( @a < @b, 'TRUE', 'FALSE' ) AS Result;  

--less-than-transact-sql.md line: 78
Result  
------  
FALSE  
  
(1 row(s) affected)  
  


--like-transact-sql.md line: 44
match_expression [ NOT ] LIKE pattern [ ESCAPE escape_character ]

--like-transact-sql.md line: 50
match_expression [ NOT ] LIKE pattern

--like-transact-sql.md line: 95
-- Uses AdventureWorks

CREATE PROCEDURE FindEmployee @EmpLName CHAR(20)
AS
SELECT @EmpLName = RTRIM(@EmpLName) + '%';

SELECT p.FirstName,
    p.LastName,
    a.City
FROM Person.Person p
INNER JOIN Person.Address a
    ON p.BusinessEntityID = a.AddressID
WHERE p.LastName LIKE @EmpLName;
GO

EXEC FindEmployee @EmpLName = 'Barb';
GO

--like-transact-sql.md line: 119
-- Uses AdventureWorks
  
CREATE PROCEDURE FindEmployee @EmpLName VARCHAR(20)
AS
SELECT @EmpLName = RTRIM(@EmpLName) + '%';

SELECT p.FirstName,
    p.LastName,
    a.City
FROM Person.Person p
INNER JOIN Person.Address a
    ON p.BusinessEntityID = a.AddressID
WHERE p.LastName LIKE @EmpLName;
GO

EXEC FindEmployee @EmpLName = 'Barb';
GO

--like-transact-sql.md line: 141
FirstName      LastName            City
----------     -------------------- ---------------
Angela         Barbariol            Snohomish
David          Barber               Snohomish
(2 row(s) affected)

--like-transact-sql.md line: 155
-- ASCII pattern matching with char column
CREATE TABLE t (col1 CHAR(30));

INSERT INTO t
VALUES ('Robert King');

SELECT * FROM t
WHERE col1 LIKE '% King'; -- returns 1 row

-- Unicode pattern matching with nchar column
CREATE TABLE t (col1 NCHAR(30));

INSERT INTO t
VALUES ('Robert King');

SELECT * FROM t
WHERE col1 LIKE '% King'; -- no rows returned

-- Unicode pattern matching with nchar column and RTRIM
CREATE TABLE t (col1 NCHAR(30));

INSERT INTO t
VALUES ('Robert King');

SELECT * FROM t
WHERE RTRIM(col1) LIKE '% King'; -- returns 1 row

--like-transact-sql.md line: 193
-- Uses AdventureWorks
  
SELECT Name
FROM sys.system_views
WHERE Name LIKE 'dm%';
GO

--like-transact-sql.md line: 235
-- Uses AdventureWorks
  
SELECT p.FirstName,
    p.LastName,
    ph.PhoneNumber
FROM Person.PersonPhone AS ph
INNER JOIN Person.Person AS p
    ON ph.BusinessEntityID = p.BusinessEntityID
WHERE ph.PhoneNumber LIKE '415%'
ORDER BY p.LastName;
GO

--like-transact-sql.md line: 251
FirstName             LastName             Phone
-----------------     -------------------  ------------
Ruben                 Alonso               415-555-124
Shelby                Cook                 415-555-0121
Karen                 Hu                   415-555-0114
John                  Long                 415-555-0147
David                 Long                 415-555-0123
Gilbert               Ma                   415-555-0138
Meredith              Moreno               415-555-0131
Alexandra             Nelson               415-555-0174
Taylor                Patterson            415-555-0170
Gabrielle              Russell             415-555-0197
Dalton                 Simmons             415-555-0115
(11 row(s) affected)

--like-transact-sql.md line: 272
-- Uses AdventureWorks

SELECT p.FirstName,
    p.LastName,
    ph.PhoneNumber
FROM Person.PersonPhone AS ph
INNER JOIN Person.Person AS p
    ON ph.BusinessEntityID = p.BusinessEntityID
WHERE ph.PhoneNumber NOT LIKE '415%'
    AND p.FirstName = 'Gail'
ORDER BY p.LastName;
GO

--like-transact-sql.md line: 289
FirstName              LastName            Phone
---------------------- -------------------- -------------------
Gail                  Alexander            1 (11) 500 555-0120
Gail                  Butler               1 (11) 500 555-0191
Gail                  Erickson             834-555-0132
Gail                  Erickson             849-555-0139
Gail                  Griffin              450-555-0171
Gail                  Moore                155-555-0169
Gail                  Russell              334-555-0170
Gail                  Westover             305-555-0100
(8 row(s) affected)

--like-transact-sql.md line: 307
USE tempdb;
GO

IF EXISTS (
        SELECT TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_NAME = 'mytbl2'
        )
    DROP TABLE mytbl2;
GO

USE tempdb;
GO

CREATE TABLE mytbl2 (c1 SYSNAME);
GO

INSERT mytbl2
VALUES ('Discount is 10-15% off'),
    ('Discount is .10-.15 off');
GO
--! LIKE ESCAPE
SELECT c1
FROM mytbl2
WHERE c1 LIKE '%10-15!% off%' ESCAPE '!';
GO

--like-transact-sql.md line: 340
-- Uses AdventureWorks

SELECT BusinessEntityID,
    FirstName,
    LastName
FROM Person.Person
WHERE FirstName LIKE '[CS]heryl';
GO
--! regex [ae]
--like-transact-sql.md line: 353
-- Uses AdventureWorks
  
SELECT LastName,
    FirstName
FROM Person.Person
WHERE LastName LIKE 'Zh[ae]ng'
ORDER BY LastName ASC,
    FirstName ASC;
GO

--like-transact-sql.md line: 371
-- Uses AdventureWorks
  
SELECT FirstName,
    LastName,
    Phone
FROM DimEmployee
WHERE phone LIKE '612%'
ORDER BY LastName;

--like-transact-sql.md line: 386
-- Uses AdventureWorks
  
SELECT FirstName,
    LastName,
    Phone
FROM DimEmployee
WHERE phone NOT LIKE '612%'
ORDER BY LastName;

--like-transact-sql.md line: 401
-- Uses AdventureWorks
--! _  wildcard  
SELECT FirstName,
    LastName,
    Phone
FROM DimEmployee
WHERE phone LIKE '6_2%'
ORDER BY LastName;



--modulo-equals-transact-sql.md line: 33
expression %= expression  


--modulo-transact-sql.md line: 36
dividend % divisor  

--modulo-transact-sql.md line: 60
SELECT 38 / 5 AS Integer, 38 % 5 AS Remainder;

--modulo-transact-sql.md line: 67
-- Uses AdventureWorks  
  
SELECT TOP(100)ProductID, UnitPrice, OrderQty,  
   CAST((UnitPrice) AS INT) % OrderQty AS Modulo  
FROM Sales.SalesOrderDetail;  
GO  

--modulo-transact-sql.md line: 81
-- Uses AdventureWorks  
  
SELECT TOP(1) 3%2 FROM dimEmployee;  

--modulo-transact-sql.md line: 89
---------   
1         


--multiply-equals-transact-sql.md line: 33
expression *= expression  


--multiply-transact-sql.md line: 31
expression * expression  

--multiply-transact-sql.md line: 47
-- Uses AdventureWorks  
  
SELECT ProductID, Name, ListPrice, ListPrice * 1.15 AS NewPrice  
FROM Production.Product  
WHERE Name LIKE 'Mountain-%'  
ORDER BY ProductID ASC;  
GO  

--multiply-transact-sql.md line: 60
-- Uses AdventureWorks  
  
SELECT FirstName, LastName, BaseRate * VacationHours AS VacationPay  
FROM DimEmployee  
ORDER BY lastName ASC;  



--not-equal-to-transact-sql-traditional.md line: 30
expression <> expression  

--not-equal-to-transact-sql-traditional.md line: 48
-- Uses AdventureWorks  
  
SELECT ProductCategoryID, Name  
FROM Production.ProductCategory  
WHERE ProductCategoryID <> 3 AND ProductCategoryID <> 2;  

--not-equal-to-transact-sql-traditional.md line: 58
ProductCategoryID Name  
----------------- --------------------------------------------------  
1                 Bikes  
4                 Accessories  
  
(2 row(s) affected)  
  


--not-greater-than-transact-sql.md line: 30
expression !> expression  


--not-less-than-transact-sql.md line: 30
expression !< expression  


--not-transact-sql.md line: 31
[ NOT ] boolean_expression  

--not-transact-sql.md line: 61
-- Uses AdventureWorks  
  
SELECT ProductID, Name, Color, StandardCost  
FROM Production.Product  
WHERE ProductNumber LIKE 'BK-%' AND Color = 'Silver' AND NOT StandardCost > 400;  
GO  

--not-transact-sql.md line: 72
 ProductID   Name                     Color         StandardCost
 ---------   -------------------      ------      ------------
 984         Mountain-500 Silver, 40  Silver        308.2179
 985         Mountain-500 Silver, 42  Silver        308.2179
 986         Mountain-500 Silver, 44  Silver        308.2179
 987         Mountain-500 Silver, 48  Silver        308.2179
 988         Mountain-500 Silver, 52  Silver        308.2179
 (6 row(s) affected)

--not-transact-sql.md line: 86
-- Uses AdventureWorks  
  
SELECT ProductKey, CustomerKey, OrderDateKey, ShipDateKey  
FROM FactInternetSales  
WHERE SalesOrderNumber LIKE 'SO6%' AND NOT ProductKey < 400;  



--nullif-transact-sql.md line: 31
NULLIF ( expression , expression )  

--nullif-transact-sql.md line: 56
CREATE TABLE dbo.budgets  
(  
   dept            TINYINT   IDENTITY,  
   current_year    DECIMAL   NULL,  
   previous_year   DECIMAL   NULL  
);  
INSERT budgets VALUES(100000, 150000);  
INSERT budgets VALUES(NULL, 300000);  
INSERT budgets VALUES(0, 100000);  
INSERT budgets VALUES(NULL, 150000);  
INSERT budgets VALUES(300000, 250000);  
GO    
SET NOCOUNT OFF;  
SELECT AVG(NULLIF(COALESCE(current_year,  
   previous_year), 0.00)) AS [Average Budget]  
FROM budgets;  
GO  

--nullif-transact-sql.md line: 78
 Average Budget  
 --------------  
 212500.000000  
 (1 row(s) affected)

--nullif-transact-sql.md line: 88
USE AdventureWorks2022;  
GO  
SELECT ProductID, MakeFlag, FinishedGoodsFlag,   
   NULLIF(MakeFlag,FinishedGoodsFlag) AS [Null if Equal]  
FROM Production.Product  
WHERE ProductID < 10;  
GO  
  
SELECT ProductID, MakeFlag, FinishedGoodsFlag, [Null if Equal] =  
   CASE  
       WHEN MakeFlag = FinishedGoodsFlag THEN NULL  
       ELSE MakeFlag  
   END  
FROM Production.Product  
WHERE ProductID < 10;  
GO  

--nullif-transact-sql.md line: 110

Copy
CREATE TABLE budgets (  
   dept           TINYINT,  
   current_year   DECIMAL(10,2),  
   previous_year  DECIMAL(10,2)  
);  
  
INSERT INTO budgets VALUES(1, 100000, 150000);  
INSERT INTO budgets VALUES(2, NULL, 300000);  
INSERT INTO budgets VALUES(3, 0, 100000);  
INSERT INTO budgets VALUES(4, NULL, 150000);  
INSERT INTO budgets VALUES(5, 300000, 300000);  
  
SELECT dept, NULLIF(current_year,  
   previous_year) AS LastBudget  
FROM budgets;  

--nullif-transact-sql.md line: 132
 dept   LastBudget  
 ----   -----------  
 1      100000.00  
 2      null 
 3      0.00  
 4      null  
 5      null


--open-transact-sql.md line: 31
OPEN { { [ GLOBAL ] cursor_name } | cursor_variable_name }  

--open-transact-sql.md line: 58
DECLARE Employee_Cursor CURSOR FOR  
SELECT LastName, FirstName  
FROM AdventureWorks2022.HumanResources.vEmployee  
WHERE LastName like 'B%';  
  
OPEN Employee_Cursor;  
  
FETCH NEXT FROM Employee_Cursor;  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    FETCH NEXT FROM Employee_Cursor  
END;  
  
CLOSE Employee_Cursor;  
DEALLOCATE Employee_Cursor;  


--operator-precedence-transact-sql.md line: 38
DECLARE @MyNumber INT;  
SET @MyNumber = 4 - 2 + 27;  
-- Evaluates to 2 + 27 which yields an expression result of 29.  
SELECT @MyNumber;  

--operator-precedence-transact-sql.md line: 49
DECLARE @MyNumber INT;  
SET @MyNumber = 2 * 4 + 5;  
-- Evaluates to 8 + 5 which yields an expression result of 13.  
SELECT @MyNumber;  

--operator-precedence-transact-sql.md line: 58
DECLARE @MyNumber INT;  
SET @MyNumber = 2 * (4 + 5);  
-- Evaluates to 2 * 9 which yields an expression result of 18.  
SELECT @MyNumber;  

--operator-precedence-transact-sql.md line: 67
DECLARE @MyNumber INT;  
SET @MyNumber = 2 * (4 + (5 - 3) );  
-- Evaluates to 2 * (4 + 2) which then evaluates to 2 * 6, and   
-- yields an expression result of 12.  
SELECT @MyNumber;  



--or-transact-sql.md line: 32
boolean_expression OR boolean_expression  

--or-transact-sql.md line: 60
-- Uses AdventureWorks  
  
SELECT FirstName, LastName, Shift   
FROM HumanResources.vEmployeeDepartmentHistory  
WHERE Department = 'Quality Assurance'  
   AND (Shift = 'Evening' OR Shift = 'Night');  

--or-transact-sql.md line: 71
 FirstName    LastName         Shift 
 ------------ ---------------- ------- 
 Andreas      Berglund         Evening 
 Sootha       Charncherngkha   Night

--or-transact-sql.md line: 81
-- Uses AdventureWorks  
  
SELECT FirstName, LastName, BaseRate, HireDate   
FROM DimEmployee  
WHERE BaseRate < 10 OR HireDate >= '2001-01-01';  


--percent-character-wildcard-character-s-to-match-transact-sql.md line: 35
SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE 'Dan%';
GO

--percent-character-wildcard-character-s-to-match-transact-sql.md line: 46
SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE 'J%n';
GO


--print-transact-sql.md line: 34
PRINT msg_str | @local_variable | string_expr  

--print-transact-sql.md line: 66
IF @@OPTIONS & 512 <> 0  
    PRINT N'This user has SET NOCOUNT turned ON.';  
ELSE  
    PRINT N'This user has SET NOCOUNT turned OFF.';  
GO  

--print-transact-sql.md line: 77
-- Build the message text by concatenating  
-- strings and expressions.  
PRINT N'This message was printed on '  
    + RTRIM(CAST(GETDATE() AS NVARCHAR(30)))  
    + N'.';  
GO  
-- This example shows building the message text  
-- in a variable and then passing it to PRINT.  
-- This was required in SQL Server 7.0 or earlier.  
DECLARE @PrintMessage NVARCHAR(50);  
SET @PrintMessage = N'This message was printed on '  
    + RTRIM(CAST(GETDATE() AS NVARCHAR(30)))  
    + N'.';  
PRINT @PrintMessage;  
GO  

--print-transact-sql.md line: 100
IF DB_ID() = 1  
    PRINT N'The current database is master.';  
ELSE  
    PRINT N'The current database is not master.';  
GO  

--! RAISEERROR
--raiserror-transact-sql.md line: 46
RAISERROR ( { msg_id | msg_str | @local_variable }
    { , severity, state }
    [ , argument [ , ...n ] ] )
    [ WITH option [ , ...n ] ]

--raiserror-transact-sql.md line: 55
RAISERROR ( { msg_str | @local_variable }
    { , severity, state }
    [ , argument [ , ...n ] ] )
    [ WITH option [ , ...n ] ]

--raiserror-transact-sql.md line: 139
RAISERROR (15600, -1, -1, 'mysp_CreateCustomer');

--raiserror-transact-sql.md line: 145
Msg 15600, Level 15, State 1, Line 1
An invalid parameter or option was specified for procedure 'mysp_CreateCustomer'.

--raiserror-transact-sql.md line: 188
RAISERROR (N'This is message %s %d.', -- Message text.
           10, -- Severity,
           1, -- State,
           N'number', -- First argument.
           5); -- Second argument.
-- The message text returned is: This is message number 5.
GO

--raiserror-transact-sql.md line: 202
RAISERROR (N'<\<%*.*s>>', -- Message text.
           10, -- Severity,
           1, -- State,
           7, -- First argument used for width.
           3, -- Second argument used for precision.
           N'abcde'); -- Third argument supplies the string.
-- The message text returned is: <<    abc>>.
GO
RAISERROR (N'<\<%7.3s>>', -- Message text.
           10, -- Severity,
           1, -- State,
           N'abcde'); -- First argument supplies the string.
-- The message text returned is: <<    abc>>.
GO

--raiserror-transact-sql.md line: 232
BEGIN TRY
    -- RAISERROR with severity 11-19 will cause execution to
    -- jump to the CATCH block.
    RAISERROR ('Error raised in TRY block.', -- Message text.
               16, -- Severity.
               1 -- State.
               );
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH;

--raiserror-transact-sql.md line: 265
EXEC sp_addmessage @msgnum = 50005,
              @severity = 10,
              @msgtext = N'<\<%7.3s>>';
GO
RAISERROR (50005, -- Message id.
           10, -- Severity,
           1, -- State,
           N'abcde'); -- First argument supplies the string.
-- The message text returned is: <<    abc>>.
GO
EXEC sp_dropmessage @msgnum = 50005;
GO

--raiserror-transact-sql.md line: 284
DECLARE @StringVariable NVARCHAR(50);
SET @StringVariable = N'<\<%7.3s>>';

RAISERROR (@StringVariable, -- Message text.
           10, -- Severity,
           1, -- State,
           N'abcde'); -- First argument supplies the string.
-- The message text returned is: <<    abc>>.
GO


--reconfigure-transact-sql.md line: 32
RECONFIGURE [ WITH OVERRIDE ]    

--reconfigure-transact-sql.md line: 60
EXEC sp_configure 'recovery interval', 75    
RECONFIGURE WITH OVERRIDE;    
GO    




--return-transact-sql.md line: 34
RETURN [ integer_expression ]   

--return-transact-sql.md line: 60
CREATE PROCEDURE findjobs @nm sysname = NULL  
AS   
IF @nm IS NULL  
    BEGIN  
        PRINT 'You must give a user name'  
        RETURN  
    END  
ELSE  
    BEGIN  
        SELECT o.name, o.id, o.uid  
        FROM sysobjects o INNER JOIN master..syslogins l  
            ON o.uid = l.sid  
        WHERE l.name = @nm  
    END;  

--return-transact-sql.md line: 80
USE AdventureWorks2022;  
GO  
CREATE PROCEDURE checkstate @param VARCHAR(11)  
AS  
IF (SELECT StateProvince FROM Person.vAdditionalContactInfo WHERE ContactID = @param) = 'WA'  
    RETURN 1  
ELSE  
    RETURN 2;  
GO  

--return-transact-sql.md line: 94
DECLARE @return_status INT;  
EXEC @return_status = checkstate '2';  
SELECT 'Return Status' = @return_status;  
GO  

--return-transact-sql.md line: 103
 Return Status 
  
 ------------- 
  
 1

--return-transact-sql.md line: 113
DECLARE @return_status INT;  
EXEC @return_status = checkstate '6';  
SELECT 'Return Status' = @return_status;  
GO  

--return-transact-sql.md line: 122
 Return Status  
 -------------  
  
 2

--return-transact-sql.md line: 131
DECLARE @return_status INT  
EXEC @return_status = checkstate '12345678901';  
SELECT 'Return Status' = @return_status;  
GO  

--return-transact-sql.md line: 140
 Return Status  
 -------------  
  
 2


--rollback-transaction-transact-sql.md line: 38
--Applies to SQL Server and Azure SQL Database

ROLLBACK { TRAN | TRANSACTION }   
     [ transaction_name | @tran_name_variable  
     | savepoint_name | @savepoint_variable ]   
[ ; ]  

--rollback-transaction-transact-sql.md line: 47
-- Applies to Synpase Data Warehouse in Microsoft Fabric, Azure Synapse Analytics and Parallel Data Warehouse Database
  
ROLLBACK { TRAN | TRANSACTION } 
[ ; ]  

--rollback-transaction-transact-sql.md line: 112
USE tempdb;  
GO  
CREATE TABLE ValueTable ([value] INT);  
GO  
  
DECLARE @TransactionName VARCHAR(20) = 'Transaction1';  
  
BEGIN TRAN @TransactionName  
       INSERT INTO ValueTable VALUES(1), (2);  
ROLLBACK TRAN @TransactionName;  
  
INSERT INTO ValueTable VALUES(3),(4);  
  
SELECT [value] FROM ValueTable;  
  
DROP TABLE ValueTable;  

--rollback-transaction-transact-sql.md line: 131
value  
-----   
3    
4  


--rollback-work-transact-sql.md line: 33
ROLLBACK [ WORK ]  
[ ; ]  

--!  SAVE TRANSACTION
--save-transaction-transact-sql.md line: 35
SAVE { TRAN | TRANSACTION } { savepoint_name | @savepoint_variable }  
[ ; ]  

--save-transaction-transact-sql.md line: 65
USE AdventureWorks2022;  
GO  
IF EXISTS (SELECT name FROM sys.objects  
           WHERE name = N'SaveTranExample')  
    DROP PROCEDURE SaveTranExample;  
GO  
CREATE PROCEDURE SaveTranExample  
    @InputCandidateID INT  
AS  
    -- Detect whether the procedure was called  
    -- from an active transaction and save  
    -- that for later use.  
    -- In the procedure, @TranCounter = 0  
    -- means there was no active transaction  
    -- and the procedure started one.  
    -- @TranCounter > 0 means an active  
    -- transaction was started before the   
    -- procedure was called.  
    DECLARE @TranCounter INT;  
    SET @TranCounter = @@TRANCOUNT;  
    IF @TranCounter > 0  
        -- Procedure called when there is  
        -- an active transaction.  
        -- Create a savepoint to be able  
        -- to roll back only the work done  
        -- in the procedure if there is an  
        -- error.  
        SAVE TRANSACTION ProcedureSave;  
    ELSE  
        -- Procedure must start its own  
        -- transaction.  
        BEGIN TRANSACTION;  
    -- Modify database.  
    BEGIN TRY  
        DELETE HumanResources.JobCandidate  
            WHERE JobCandidateID = @InputCandidateID;  
        -- Get here if no errors; must commit  
        -- any transaction started in the  
        -- procedure, but not commit a transaction  
        -- started before the transaction was called.  
        IF @TranCounter = 0  
            -- @TranCounter = 0 means no transaction was  
            -- started before the procedure was called.  
            -- The procedure must commit the transaction  
            -- it started.  
            COMMIT TRANSACTION;  
    END TRY  
    BEGIN CATCH  
        -- An error occurred; must determine  
        -- which type of rollback will roll  
        -- back only the work done in the  
        -- procedure.  
        IF @TranCounter = 0  
            -- Transaction started in procedure.  
            -- Roll back complete transaction.  
            ROLLBACK TRANSACTION;  
        ELSE  
            -- Transaction started before procedure  
            -- called, do not roll back modifications  
            -- made before the procedure was called.  
            IF XACT_STATE() <> -1  
                -- If the transaction is still valid, just  
                -- roll back to the savepoint set at the  
                -- start of the stored procedure.  
                ROLLBACK TRANSACTION ProcedureSave;  
                -- If the transaction is uncommitable, a  
                -- rollback to the savepoint is not allowed  
                -- because the savepoint rollback writes to  
                -- the log. Just return to the caller, which  
                -- should roll back the outer transaction.  
  
        -- After the appropriate rollback, echo error  
        -- information to the caller.  
        DECLARE @ErrorMessage NVARCHAR(4000);  
        DECLARE @ErrorSeverity INT;  
        DECLARE @ErrorState INT;  
  
        SELECT @ErrorMessage = ERROR_MESSAGE();  
        SELECT @ErrorSeverity = ERROR_SEVERITY();  
        SELECT @ErrorState = ERROR_STATE();  
  
        RAISERROR (@ErrorMessage, -- Message text.  
                   @ErrorSeverity, -- Severity.  
                   @ErrorState -- State.  
                   );  
    END CATCH  
GO  


--scope-resolution-operator-transact-sql.md line: 22
DECLARE @hid hierarchyid;  
SELECT @hid = hierarchyid::GetRoot();  
PRINT @hid.ToString();  


--select-local-variable-transact-sql.md line: 38
SELECT { @local_variable { = | += | -= | *= | /= | %= | &= | ^= | |= } expression }
    [ ,...n ] [ ; ]

--select-local-variable-transact-sql.md line: 91
-- Uses AdventureWorks2022LT
DECLARE @var1 VARCHAR(30);
SELECT @var1 = 'Generic Name';

SELECT @var1 = [Name]
FROM SalesLT.Product
WHERE ProductID = 1000000; --Value does not exist
SELECT @var1 AS 'ProductName';

--select-local-variable-transact-sql.md line: 104
ProductName
------------------------------
Generic Name

--select-local-variable-transact-sql.md line: 116
-- Uses AdventureWorksLT
DECLARE @var1 VARCHAR(30);
SELECT @var1 = 'Generic Name';

SELECT @var1 = (SELECT [Name]
FROM SalesLT.Product
WHERE ProductID = 1000000); --Value does not exist

SELECT @var1 AS 'Company Name';

--select-local-variable-transact-sql.md line: 130
Company Name
----------------------------
NULL

--select-local-variable-transact-sql.md line: 140
SELECT @Var = <expression containing @Var>
FROM
...

--select-local-variable-transact-sql.md line: 154
DECLARE @List AS nvarchar(max);
SELECT @List = CONCAT(COALESCE(@List + ', ',''), p.LastName)
  FROM Person.Person AS p
  WHERE p.FirstName = 'William'
  ORDER BY p.BusinessEntityID;
SELECT @List;

--select-local-variable-transact-sql.md line: 165
(No column name)
---
Walker

--select-local-variable-transact-sql.md line: 173
DECLARE @List AS nvarchar(max);
SELECT @List = STRING_AGG(p.LastName,', ') WITHIN GROUP (ORDER BY p.BusinessEntityID) -- Within group не имеет смысла так как нет деления group by
  FROM Person.Person AS p
  WHERE p.FirstName = 'William';
SELECT @List;


--select-local-variable-transact-sql.md line: 183
(No column name)
---
Vong, Conner, Hapke, Monroe, Richter, Sotelo, Vong, Ngoh, White, Harris, Martin, Thompson, Martinez, Robinson, Clark, Rodriguez, Smith, Johnson, Williams, Jones, Brown, Davis, Miller, Moore, Taylor, Anderson, Thomas, Lewis, Lee, Walker


--set-local-variable-transact-sql.md line: 29
SET   
{ @local_variable  
    [ . { property_name | field_name } ] = { expression | udt_name { . | :: } method_name }  
}  
|  
{ @SQLCLR_local_variable.mutator_method  
}  
|  
{ @local_variable  
    {+= | -= | *= | /= | %= | &= | ^= | |= } expression  
}  
|   
  { @cursor_variable =   
    { @cursor_variable | cursor_name   
    | { CURSOR [ FORWARD_ONLY | SCROLL ]   
        [ STATIC | KEYSET | DYNAMIC | FAST_FORWARD ]   
        [ READ_ONLY | SCROLL_LOCKS | OPTIMISTIC ]   
        [ TYPE_WARNING ]   
    FOR select_statement   
        [ FOR { READ ONLY | UPDATE [ OF column_name [ ,...n ] ] } ]   
      }   
    }  
}   

--set-local-variable-transact-sql.md line: 57
SET @local_variable { = | += | -= | *= | /= | %= | &= | ^= | |= } expression  

--set-local-variable-transact-sql.md line: 191
DECLARE @myvar CHAR(20);  
SET @myvar = 'This is a test';  
SELECT @myvar;  
GO  

--set-local-variable-transact-sql.md line: 201
USE AdventureWorks2022;  
GO  
DECLARE @state CHAR(25);  
SET @state = N'Oregon';  
SELECT RTRIM(FirstName) + ' ' + RTRIM(LastName) AS Name, City  
FROM HumanResources.vEmployee  
WHERE StateProvinceName = @state;
GO 

--set-local-variable-transact-sql.md line: 215
/* Example one */  
DECLARE  @NewBalance  INT ;  
SET  @NewBalance  =  10;  
SET  @NewBalance  =  @NewBalance  *  10;  
SELECT  @NewBalance;
GO
  
/* Example Two */  
DECLARE @NewBalance INT = 10;  
SET @NewBalance *= 10;  
SELECT @NewBalance;
GO

--set-local-variable-transact-sql.md line: 233
DECLARE my_cursor CURSOR GLOBAL   
FOR SELECT * FROM Purchasing.ShipMethod  
DECLARE @my_variable CURSOR ;  
SET @my_variable = my_cursor ;   
--There is a GLOBAL cursor declared(my_cursor) and a LOCAL variable  
--(@my_variable) set to the my_cursor cursor.  

DEALLOCATE my_cursor;   
GO
--There is now only a LOCAL variable reference  
--(@my_variable) to the my_cursor cursor.

--set-local-variable-transact-sql.md line: 250
DECLARE @CursorVar CURSOR;  
  
SET @CursorVar = CURSOR SCROLL DYNAMIC  
FOR  
SELECT LastName, FirstName  
FROM AdventureWorks2022.HumanResources.vEmployee  
WHERE LastName like 'B%';  
  
OPEN @CursorVar;  
  
FETCH NEXT FROM @CursorVar;  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    FETCH NEXT FROM @CursorVar  
END;  
  
CLOSE @CursorVar;  
DEALLOCATE @CursorVar;
GO

--set-local-variable-transact-sql.md line: 275
USE AdventureWorks2022;  
GO  
DECLARE @rows INT;  
SET @rows = (SELECT COUNT(*) FROM Sales.Customer);  
SELECT @rows;
GO

--set-local-variable-transact-sql.md line: 287
DECLARE @p Point;  
SET @p.X = @p.X + 1.1;  
SELECT @p;  
GO  

--set-local-variable-transact-sql.md line: 299
DECLARE @p Point;  
SET @p=point.SetXY(23.5, 23.5);  
--! ASSEMBLY
--set-local-variable-transact-sql.md line: 307
CREATE ASSEMBLY mytest FROM 'c:\test.dll' WITH PERMISSION_SET = SAFE  
CREATE TYPE Point EXTERNAL NAME mytest.Point  
GO  
DECLARE @p Point = CONVERT(Point, '')  
SET @p.SetXY(22, 23);  

--set-local-variable-transact-sql.md line: 320
DECLARE @myvar CHAR(20);  
SET @myvar = 'This is a test';  
SELECT TOP 1 @myvar FROM sys.databases;

--set-local-variable-transact-sql.md line: 329
-- Uses AdventureWorks 
  
DECLARE @dept CHAR(25);  
SET @dept = N'Marketing';  
SELECT RTRIM(FirstName) + ' ' + RTRIM(LastName) AS Name  
FROM DimEmployee   
WHERE DepartmentName = @dept;  

--set-local-variable-transact-sql.md line: 342
/* Example one */  
DECLARE  @NewBalance INT;  
SET  @NewBalance  =  10;  
SET  @NewBalance  =  @NewBalance  *  10;  
SELECT TOP 1 @NewBalance FROM sys.tables;  
  
/* Example Two */  
DECLARE @NewBalance INT = 10;  
SET @NewBalance *= 10;  
SELECT TOP 1 @NewBalance FROM sys.tables;  

--set-local-variable-transact-sql.md line: 358
-- Uses AdventureWorks 
  
DECLARE @rows INT;  
SET @rows = (SELECT COUNT(*) FROM dbo.DimCustomer);  
SELECT TOP 1 @rows FROM sys.tables;  


--set-operators-except-and-intersect-transact-sql.md line: 43
{ <query_specification> | ( <query_expression> ) }   
{ EXCEPT | INTERSECT }  
{ <query_specification> | ( <query_expression> ) }  

--set-operators-except-and-intersect-transact-sql.md line: 97
-- Uses AdventureWorks  
  
SELECT ProductID   
FROM Production.Product ;  
--Result: 504 Rows  

--set-operators-except-and-intersect-transact-sql.md line: 107
-- Uses AdventureWorks  
  
SELECT ProductID   
FROM Production.Product  
INTERSECT  
SELECT ProductID   
FROM Production.WorkOrder ;  
--Result: 238 Rows (products that have work orders)  

--set-operators-except-and-intersect-transact-sql.md line: 120
-- Uses AdventureWorks  
  
SELECT ProductID   
FROM Production.Product  
EXCEPT  
SELECT ProductID   
FROM Production.WorkOrder ;  
--Result: 266 Rows (products without work orders)  

--set-operators-except-and-intersect-transact-sql.md line: 133
-- Uses AdventureWorks  
  
SELECT ProductID   
FROM Production.WorkOrder  
EXCEPT  
SELECT ProductID   
FROM Production.Product ;  
--Result: 0 Rows (work orders without products)  

--set-operators-except-and-intersect-transact-sql.md line: 147
-- Uses AdventureWorks  
  
SELECT CustomerKey   
FROM FactInternetSales;  
--Result: 60398 Rows  

--set-operators-except-and-intersect-transact-sql.md line: 157
-- Uses AdventureWorks  
  
SELECT CustomerKey   
FROM FactInternetSales    
INTERSECT   
SELECT CustomerKey   
FROM DimCustomer   
WHERE DimCustomer.Gender = 'F'  
ORDER BY CustomerKey;  
--Result: 9133 Rows (Sales to customers that are female.)  

--set-operators-except-and-intersect-transact-sql.md line: 172
-- Uses AdventureWorks  
  
SELECT CustomerKey   
FROM FactInternetSales    
EXCEPT   
SELECT CustomerKey   
FROM DimCustomer   
WHERE DimCustomer.Gender = 'F'  
ORDER BY CustomerKey;  
--Result: 9351 Rows (Sales to customers that are not female.)  


--set-operators-union-transact-sql.md line: 45
{ <query_specification> | ( <query_expression> ) }   
{ UNION [ ALL ]   
  { <query_specification> | ( <query_expression> ) } 
  [ ...n ] }

--set-operators-union-transact-sql.md line: 71
-- Uses AdventureWorks  
  
IF OBJECT_ID ('dbo.Gloves', 'U') IS NOT NULL  
DROP TABLE dbo.Gloves;  
GO  
-- Create Gloves table.  
SELECT ProductModelID, Name  
INTO dbo.Gloves  
FROM Production.ProductModel  
WHERE ProductModelID IN (3, 4);  
GO  
  
-- Here is the simple union.  
-- Uses AdventureWorks  
  
SELECT ProductModelID, Name  
FROM Production.ProductModel  
WHERE ProductModelID NOT IN (3, 4)  
UNION  
SELECT ProductModelID, Name  
FROM dbo.Gloves  
ORDER BY Name;  
GO  
--! UNION ALL - Includes duplicates. UNION - Excludes duplicates.
--set-operators-union-transact-sql.md line: 100
-- Uses AdventureWorks  
  
IF OBJECT_ID ('dbo.ProductResults', 'U') IS NOT NULL  
DROP TABLE dbo.ProductResults;  
GO  
IF OBJECT_ID ('dbo.Gloves', 'U') IS NOT NULL  
DROP TABLE dbo.Gloves;  
GO  
-- Create Gloves table.  
SELECT ProductModelID, Name  
INTO dbo.Gloves  
FROM Production.ProductModel  
WHERE ProductModelID IN (3, 4);  
GO  
  
-- Uses AdventureWorks  
  
SELECT ProductModelID, Name  
INTO dbo.ProductResults  
FROM Production.ProductModel  
WHERE ProductModelID NOT IN (3, 4)  
UNION  
SELECT ProductModelID, Name  
FROM dbo.Gloves;  
GO  
  
SELECT ProductModelID, Name   
FROM dbo.ProductResults;  

--set-operators-union-transact-sql.md line: 134
-- Uses AdventureWorks  
  
IF OBJECT_ID ('dbo.Gloves', 'U') IS NOT NULL  
DROP TABLE dbo.Gloves;  
GO  
-- Create Gloves table.  
SELECT ProductModelID, Name  
INTO dbo.Gloves  
FROM Production.ProductModel  
WHERE ProductModelID IN (3, 4);  
GO  
  
/* INCORRECT */  
-- Uses AdventureWorks  
  
SELECT ProductModelID, Name  
FROM Production.ProductModel  
WHERE ProductModelID NOT IN (3, 4)  
ORDER BY Name  
UNION  
SELECT ProductModelID, Name  
FROM dbo.Gloves;  
GO  
  
/* CORRECT */  
-- Uses AdventureWorks  
  
SELECT ProductModelID, Name  
FROM Production.ProductModel  
WHERE ProductModelID NOT IN (3, 4)  
UNION  
SELECT ProductModelID, Name  
FROM dbo.Gloves  
ORDER BY Name;  
GO  

--set-operators-union-transact-sql.md line: 177
-- Uses AdventureWorks  
  
IF OBJECT_ID ('dbo.EmployeeOne', 'U') IS NOT NULL  
DROP TABLE dbo.EmployeeOne;  
GO  
IF OBJECT_ID ('dbo.EmployeeTwo', 'U') IS NOT NULL  
DROP TABLE dbo.EmployeeTwo;  
GO  
IF OBJECT_ID ('dbo.EmployeeThree', 'U') IS NOT NULL  
DROP TABLE dbo.EmployeeThree;  
GO  
  
SELECT pp.LastName, pp.FirstName, e.JobTitle   
INTO dbo.EmployeeOne  
FROM Person.Person AS pp JOIN HumanResources.Employee AS e  
ON e.BusinessEntityID = pp.BusinessEntityID  
WHERE LastName = 'Johnson';  
GO  
SELECT pp.LastName, pp.FirstName, e.JobTitle   
INTO dbo.EmployeeTwo  
FROM Person.Person AS pp JOIN HumanResources.Employee AS e  
ON e.BusinessEntityID = pp.BusinessEntityID  
WHERE LastName = 'Johnson';  
GO  
SELECT pp.LastName, pp.FirstName, e.JobTitle   
INTO dbo.EmployeeThree  
FROM Person.Person AS pp JOIN HumanResources.Employee AS e  
ON e.BusinessEntityID = pp.BusinessEntityID  
WHERE LastName = 'Johnson';  
GO  
-- Union ALL  
SELECT LastName, FirstName, JobTitle  
FROM dbo.EmployeeOne  
UNION ALL  
SELECT LastName, FirstName ,JobTitle  
FROM dbo.EmployeeTwo  
UNION ALL  
SELECT LastName, FirstName,JobTitle   
FROM dbo.EmployeeThree;  
GO  
  
SELECT LastName, FirstName,JobTitle  
FROM dbo.EmployeeOne  
UNION   
SELECT LastName, FirstName, JobTitle   
FROM dbo.EmployeeTwo  
UNION   
SELECT LastName, FirstName, JobTitle   
FROM dbo.EmployeeThree;  
GO  
  
SELECT LastName, FirstName,JobTitle   
FROM dbo.EmployeeOne  
UNION ALL  
(  
SELECT LastName, FirstName, JobTitle   
FROM dbo.EmployeeTwo  
UNION  
SELECT LastName, FirstName, JobTitle   
FROM dbo.EmployeeThree  
);  
GO  
  

--set-operators-union-transact-sql.md line: 248
-- Uses AdventureWorks  
  
SELECT CustomerKey   
FROM FactInternetSales    
UNION   
SELECT CustomerKey   
FROM DimCustomer   
ORDER BY CustomerKey;  

--set-operators-union-transact-sql.md line: 262
-- Uses AdventureWorks  
  
-- INCORRECT  
SELECT CustomerKey   
FROM FactInternetSales    
ORDER BY CustomerKey  
UNION   
SELECT CustomerKey   
FROM DimCustomer  
ORDER BY CustomerKey;  
  
-- CORRECT   
USE AdventureWorksPDW2012;  
  
SELECT CustomerKey   
FROM FactInternetSales    
UNION   
SELECT CustomerKey   
FROM DimCustomer   
ORDER BY CustomerKey;  

--set-operators-union-transact-sql.md line: 288
-- Uses AdventureWorks  
  
-- INCORRECT   
SELECT CustomerKey   
FROM FactInternetSales   
WHERE CustomerKey >= 11000  
ORDER BY CustomerKey   
UNION   
SELECT CustomerKey   
FROM DimCustomer   
ORDER BY CustomerKey;  
  
-- CORRECT  
USE AdventureWorksPDW2012;  
  
SELECT CustomerKey   
FROM FactInternetSales   
WHERE CustomerKey >= 11000  
UNION   
SELECT CustomerKey   
FROM DimCustomer   
ORDER BY CustomerKey;  

--set-operators-union-transact-sql.md line: 320
-- Uses AdventureWorks  
  
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer  
UNION ALL   
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer  
UNION ALL   
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer;  
  
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer  
UNION   
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer  
UNION   
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer;  
  
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer  
UNION ALL  
(  
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer  
UNION   
SELECT CustomerKey, FirstName, LastName  
FROM DimCustomer  
);  

--! SHUTDOWN
--shutdown-transact-sql.md line: 31
SHUTDOWN [ WITH NOWAIT ]   


--slash-star-comment-transact-sql.md line: 33
/*  
text_of_comment  
*/  

--slash-star-comment-transact-sql.md line: 54
DECLARE @comment AS VARCHAR(20);  
GO  
/*  
SELECT @comment = '/*';  
*/ */ -- нужен второй */  иначе генерит ошибку
SELECT @@VERSION;  
GO   

--slash-star-comment-transact-sql.md line: 66
DECLARE @comment AS VARCHAR(20);  
GO  
/*  
SELECT @comment = '/*';  
*/ */  
SELECT @@VERSION;  
GO  

--slash-star-comment-transact-sql.md line: 79
USE AdventureWorks2022;  
GO  
/*  
This section of the code joins the Person table with the Address table,   
by using the Employee and BusinessEntityAddress tables in the middle to   
get a list of all the employees in the AdventureWorks2022 database   
and their contact information.  
*/  
SELECT p.FirstName, p.LastName, a.AddressLine1, a.AddressLine2, a.City, a.PostalCode  
FROM Person.Person AS p  
JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID   
JOIN Person.BusinessEntityAddress AS ea ON e.BusinessEntityID = ea.BusinessEntityID  
JOIN Person.Address AS a ON ea.AddressID = a.AddressID;  
GO  


--some-any-transact-sql.md line: 32
scalar_expression { = | <> | != | > | >= | !> | < | <= | !< }   
     { SOME | ANY } ( subquery )   
--! SOME
--some-any-transact-sql.md line: 73
CREATE TABLE T1  
(ID INT) ;  
GO  
INSERT T1 VALUES (1) ;  
INSERT T1 VALUES (2) ;  
INSERT T1 VALUES (3) ;  
INSERT T1 VALUES (4) ;  

--some-any-transact-sql.md line: 85
IF 3 < SOME (SELECT ID FROM T1)  
PRINT 'TRUE'   
ELSE  
PRINT 'FALSE' ;  

--some-any-transact-sql.md line: 94
IF 3 < ALL (SELECT ID FROM T1)  
PRINT 'TRUE'   
ELSE  
PRINT 'FALSE' ;  

--some-any-transact-sql.md line: 105
-- Uses AdventureWorks
--! SOME and ANY equivalent
CREATE PROCEDURE ManyDaysToComplete @OrderID INT, @NumberOfDays INT  
AS  
IF   
@NumberOfDays < SOME  
   (  
    SELECT DaysToManufacture  
    FROM Sales.SalesOrderDetail  
    JOIN Production.Product   
    ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID   
    WHERE SalesOrderID = @OrderID  
   )  
PRINT 'At least one item for this order can''t be manufactured in specified number of days.'
ELSE   
PRINT 'All items for this order can be manufactured in the specified number of days or less.' ;


--some-any-transact-sql.md line: 127
EXECUTE ManyDaysToComplete 49080, 2 ;  

--some-any-transact-sql.md line: 135
EXECUTE ManyDaysToComplete 49080, 1 ;  


--sql-server-utilities-statements-backslash.md line: 39
<first section of string> \  
<continued section of string>  

--sql-server-utilities-statements-backslash.md line: 62
SELECT 'abc\  
def' AS [ColumnResult];  

--sql-server-utilities-statements-backslash.md line: 69
 ColumnResult  
 ------------  
 abcdef

--sql-server-utilities-statements-backslash.md line: 79
SELECT 0xabc\
def AS [ColumnResult];  

--sql-server-utilities-statements-backslash.md line: 86
 ColumnResult  
 ------------  
 0xABCDEF


--sql-server-utilities-statements-go.md line: 31
GO [count]  

--sql-server-utilities-statements-go.md line: 50
USE AdventureWorks2022;  
GO  
DECLARE @MyMsg VARCHAR(50)  
SELECT @MyMsg = 'Hello, World.'  
GO -- @MyMsg is not valid after this GO ends the batch.  
  
-- Yields an error because @MyMsg not declared in this batch.  
PRINT @MyMsg  
GO  
  
SELECT @@VERSION;  
-- Yields an error: Must be EXEC sp_who if not first statement in   
-- batch.  
sp_who  
GO  

--sql-server-utilities-statements-go.md line: 74
-- Yields an error because ; is not permitted after GO  
SELECT @@VERSION;  
GO;  

--sql-server-utilities-statements-go.md line: 88
USE AdventureWorks2022;  
GO  
DECLARE @NmbrPeople INT  
SELECT @NmbrPeople = COUNT(*)  
FROM Person.Person;  
PRINT 'The number of people as of ' +  
      CAST(GETDATE() AS CHAR(20)) + ' is ' +  
      CAST(@NmbrPeople AS CHAR(10));  
GO  

--sql-server-utilities-statements-go.md line: 102
SELECT DB_NAME();  
SELECT USER_NAME();  
GO 2  


--string-comparison-assignment.md line: 25
expression = expression

--string-comparison-assignment.md line: 49
SELECT LastName,
    FirstName
FROM Person.Person
WHERE LastName = 'Johnson';

--string-comparison-assignment.md line: 58
DECLARE @LNameBin BINARY (100) = 0x5A68656E67;

SELECT LastName,
    FirstName
FROM Person.Person
WHERE LastName = CONVERT(VARCHAR, @LNameBin);

--string-comparison-assignment.md line: 71
DECLARE @dbname VARCHAR(100);

SET @dbname = 'Adventure';

--string-comparison-assignment.md line: 81
CREATE TABLE #tmp (c1 VARCHAR(10));
GO

INSERT INTO #tmp VALUES ('abc ');

INSERT INTO #tmp VALUES ('abc');
GO

SELECT DATALENGTH(c1) AS 'EqualWithSpace', * FROM #tmp
WHERE c1 = 'abc ';

SELECT DATALENGTH(c1) AS 'EqualNoSpace  ', * FROM #tmp
WHERE c1 = 'abc';

SELECT DATALENGTH(c1) AS 'GTWithSpace   ', * FROM #tmp
WHERE c1 > 'ab ';

SELECT DATALENGTH(c1) AS 'GTNoSpace     ', * FROM #tmp
WHERE c1 > 'ab';

SELECT DATALENGTH(c1) AS 'LTWithSpace   ', * FROM #tmp
WHERE c1 < 'abd ';

SELECT DATALENGTH(c1) AS 'LTNoSpace     ', * FROM #tmp
WHERE c1 < 'abd';

SELECT DATALENGTH(c1) AS 'LikeWithSpace ', * FROM #tmp
WHERE c1 LIKE 'abc %';

SELECT DATALENGTH(c1) AS 'LikeNoSpace   ', * FROM #tmp
WHERE c1 LIKE 'abc%';
GO

DROP TABLE #tmp;
GO


--string-concatenation-equal-transact-sql.md line: 29
expression += expression  

--string-concatenation-equal-transact-sql.md line: 47
SELECT 'Adventure' += 'Works'  

--string-concatenation-equal-transact-sql.md line: 55
DECLARE @v1 VARCHAR(40);  
SET @v1 = 'This is the original.';  
SET @v1 += ' More text.';  
PRINT @v1;  

--string-concatenation-equal-transact-sql.md line: 69
DECLARE @x VARCHAR(4000) = REPLICATE('x', 4000)
DECLARE @z VARCHAR(8000) = REPLICATE('z',8000)
DECLARE @y VARCHAR(max);
 
SET @y = '';
SET @y += @x + @z;
SELECT LEN(@y) AS Y; -- 8000
 
SET @y = '';
SET @y = @y + @x + @z;
SELECT LEN(@y) AS Y; -- 12000
 
SET @y = '';
SET @y = @y +(@x + @z);
SELECT LEN(@y) AS Y; -- 8000
-- or
SET @y = '';
SET @y = @x + @z + @y;
SELECT LEN(@y) AS Y; -- 8000
GO

--string-concatenation-equal-transact-sql.md line: 93
 Y       
 ------- 
 8000 
  
 (1 row(s) affected) 
  
    
 Y       
 ------- 
 12000 
  
 (1 row(s) affected) 

 Y       
 ------- 
 8000 
  
 (1 row(s) affected) 
  
 Y       
 ------- 
 8000 
  
 (1 row(s) affected)

--! binary vs varchar concatenation
--string-concatenation-transact-sql.md line: 32
expression + expression  

--string-concatenation-transact-sql.md line: 44
DECLARE @mybin1 VARBINARY(5), @mybin2 VARBINARY(5)  
SET @mybin1 = 0xFF  
SET @mybin2 = 0xA5  
-- No CONVERT or CAST function is required because this example   
-- concatenates two binary strings.  
SELECT @mybin1 + @mybin2  
-- A CONVERT or CAST function is required because this example  
-- concatenates two binary strings plus a space.  
SELECT CONVERT(VARCHAR(5), @mybin1) + ' '   
   + CONVERT(VARCHAR(5), @mybin2)  
-- Here is the same conversion using CAST.  
SELECT CAST(@mybin1 AS VARCHAR(5)) + ' '   
   + CAST(@mybin2 AS VARCHAR(5))  

--string-concatenation-transact-sql.md line: 73
-- Uses AdventureWorks  
  
SELECT (LastName + ', ' + FirstName) AS Name  
FROM Person.Person  
ORDER BY LastName ASC, FirstName ASC;  

--string-concatenation-transact-sql.md line: 84
-- Uses AdventureWorks  
  
SELECT 'The order is due on ' + CONVERT(VARCHAR(12), DueDate, 101)  
FROM Sales.SalesOrderHeader  
WHERE SalesOrderID = 50001;  
GO  

--string-concatenation-transact-sql.md line: 95
 ------------------------------------------------  
 The order is due on 04/23/2007  
 (1 row(s) affected)

--string-concatenation-transact-sql.md line: 104
-- Uses AdventureWorks  
  
SELECT (LastName + ',' + SPACE(1) + SUBSTRING(FirstName, 1, 1) + '.') AS Name, e.JobTitle  
FROM Person.Person AS p  
    JOIN HumanResources.Employee AS e  
    ON p.BusinessEntityID = e.BusinessEntityID  
WHERE e.JobTitle LIKE 'Vice%'  
ORDER BY LastName ASC;  
GO  

--string-concatenation-transact-sql.md line: 118
 Name               Title  
 -------------      ---------------`  
 Duffy, T.          Vice President of Engineering  
 Hamilton, J.       Vice President of Production  
 Welcker, B.        Vice President of Sales  

 (3 row(s) affected)

--string-concatenation-transact-sql.md line: 131
DECLARE @x VARCHAR(8000) = REPLICATE('x', 8000)
DECLARE @y VARCHAR(max) = REPLICATE('y', 8000)
DECLARE @z VARCHAR(8000) = REPLICATE('z',8000)
SET @y = @x + @z + @y
-- The result of following select is 16000
SELECT LEN(@y) AS y
GO

--string-concatenation-transact-sql.md line: 142
 y        
 -------  
 16000  
  
 (1 row(s) affected)

--string-concatenation-transact-sql.md line: 154
-- Uses AdventureWorks  
  
SELECT (LastName + ', ' + SUBSTRING(FirstName, 1, 1) + '.') AS Name, Title  
FROM DimEmployee  
WHERE Title LIKE '%Vice Pres%'  
ORDER BY LastName ASC;  

--string-concatenation-transact-sql.md line: 165
Name               Title                                           
-------------      ---------------  
Duffy, T.          Vice President of Engineering  
Hamilton, J.       Vice President of Production  
Welcker, B.        Vice President of Sales  



--subtract-equals-transact-sql.md line: 31
expression -= expression  


--subtract-transact-sql.md line: 34
expression - expression  

--subtract-transact-sql.md line: 54
-- Uses AdventureWorks  
  
SELECT MAX(TaxRate) - MIN(TaxRate) AS 'Tax Rate Difference'  
FROM Sales.SalesTaxRate  
WHERE StateProvinceID IS NOT NULL;  
GO  

--subtract-transact-sql.md line: 70
-- Uses the AdventureWorks sample database
DECLARE @altstartdate DATETIME;  
SET @altstartdate = CONVERT(DATETIME, 'January 10, 1900 3:00 AM', 101);  
SELECT @altstartdate - 1.5 AS 'Subtract Date';  

--subtract-transact-sql.md line: 79
 Subtract Date  
 -----------------------  
 1900-01-08 15:00:00.000  

 (1 row(s) affected)

--subtract-transact-sql.md line: 92
-- Uses AdventureWorks  
  
SELECT MAX(BaseRate) - MIN(BaseRate) AS BaseRateDifference  
FROM DimEmployee;  

--! throw
--throw-transact-sql.md line: 28
THROW [ { error_number | @local_variable },  
        { message | @local_variable },  
        { state | @local_variable } ]   
[ ; ]  

--throw-transact-sql.md line: 75
THROW 51000, 'The record does not exist.', 1;  

--throw-transact-sql.md line: 81
Msg 51000, Level 16, State 1, Line 1  
 
The record does not exist.

--throw-transact-sql.md line: 91
USE tempdb;  
GO  
CREATE TABLE dbo.TestRethrow  
(    ID INT PRIMARY KEY  
);  
BEGIN TRY  
    INSERT dbo.TestRethrow(ID) VALUES(1);  
--  Force error 2627, Violation of PRIMARY KEY constraint to be raised.  
    INSERT dbo.TestRethrow(ID) VALUES(1);  
END TRY  
BEGIN CATCH  
  
    PRINT 'In catch block.';  
    THROW;  
END CATCH;  
  

--throw-transact-sql.md line: 112
In catch block. 
Msg 2627, Level 14, State 1, Line 1  
Violation of PRIMARY KEY constraint 'PK__TestReth__3214EC272E3BD7D3'. Cannot insert duplicate key in object 'dbo.TestRethrow'.  
The statement has been terminated.

--throw-transact-sql.md line: 123
EXEC sys.sp_addmessage  
     @msgnum   = 60000  
    ,@severity = 16  
    ,@msgtext  = N'This is a test message with one numeric parameter (%d), one string parameter (%s), and another string parameter (%s).'  
    ,@lang = 'us_english';   
GO  
  
DECLARE @msg NVARCHAR(2048) = FORMATMESSAGE(60000, 500, N'First string', N'second string');   
  
THROW 60000, @msg, 1;  

--throw-transact-sql.md line: 138
Msg 60000, Level 16, State 1, Line 2  
This is a test message with one numeric parameter (500), one string parameter (First string), and another string parameter (second string).




--transactions-sql-data-warehouse.md line: 39
BEGIN TRANSACTION [;]  
COMMIT [ TRAN | TRANSACTION | WORK ] [;]  
ROLLBACK [ TRAN | TRANSACTION | WORK ] [;]  
SET AUTOCOMMIT { ON | OFF } [;]  
SET IMPLICIT_TRANSACTIONS { ON | OFF } [;]  

--transactions-sql-data-warehouse.md line: 110
BEGIN TRANSACTION;  
DELETE FROM HumanResources.JobCandidate  
    WHERE JobCandidateID = 13;  
COMMIT;  

--transactions-sql-data-warehouse.md line: 120
CREATE TABLE ValueTable (id INT);  
BEGIN TRANSACTION;  
       INSERT INTO ValueTable VALUES(1);  
       INSERT INTO ValueTable VALUES(2);  
ROLLBACK;  

--transactions-sql-data-warehouse.md line: 131
SET AUTOCOMMIT ON;  

--transactions-sql-data-warehouse.md line: 137
SET AUTOCOMMIT OFF;  

--transactions-sql-data-warehouse.md line: 143
SET AUTOCOMMIT OFF;  
CREATE TABLE ValueTable (id INT);  
INSERT INTO ValueTable VALUES(1);  
INSERT INTO ValueTable VALUES(2);  
COMMIT;  


--! try-catch
--try-catch-transact-sql.md line: 40
BEGIN TRY  
     { sql_statement | statement_block }  
END TRY  
BEGIN CATCH  
     [ { sql_statement | statement_block } ]  
END CATCH  
[ ; ]  

--try-catch-transact-sql.md line: 106
-- Verify that the stored procedure does not already exist.  
IF OBJECT_ID ( 'usp_GetErrorInfo', 'P' ) IS NOT NULL   
    DROP PROCEDURE usp_GetErrorInfo;  
GO  
--!  Create procedure to retrieve error information.  
-- Create procedure to retrieve error information.  
CREATE PROCEDURE usp_GetErrorInfo  
AS  
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
GO  
  
BEGIN TRY  
    -- Generate divide-by-zero error.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE usp_GetErrorInfo;  
END CATCH;   

--try-catch-transact-sql.md line: 161
BEGIN TRY  
    -- Table does not exist; object name resolution  
    -- error not caught.  
    SELECT * FROM NonexistentTable;  
END TRY  
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
       ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH  

--try-catch-transact-sql.md line: 178
-- Verify that the stored procedure does not exist.  
IF OBJECT_ID ( N'usp_ExampleProc', N'P' ) IS NOT NULL   
    DROP PROCEDURE usp_ExampleProc;  
GO  
  
-- Create a stored procedure that will cause an   
-- object resolution error.  
CREATE PROCEDURE usp_ExampleProc  
AS  
    SELECT * FROM NonexistentTable;  
GO  
  
BEGIN TRY  
    EXECUTE usp_ExampleProc;  
END TRY  
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  

--try-catch-transact-sql.md line: 211
BEGIN TRY  
    -- Generate a divide-by-zero error.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
GO  

--try-catch-transact-sql.md line: 231
BEGIN TRANSACTION;  
  
BEGIN TRY  
    -- Generate a constraint violation error.  
    DELETE FROM Production.Product  
    WHERE ProductID = 980;  
END TRY  
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO  

--try-catch-transact-sql.md line: 260
-- Check to see whether this stored procedure exists.  
IF OBJECT_ID (N'usp_GetErrorInfo', N'P') IS NOT NULL  
    DROP PROCEDURE usp_GetErrorInfo;  
GO  
  
-- Create procedure to retrieve error information.  
CREATE PROCEDURE usp_GetErrorInfo  
AS  
    SELECT   
         ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  
GO  
  
-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
-- when the constraint violation occurs.   
SET XACT_ABORT ON;  
  
BEGIN TRY  
    BEGIN TRANSACTION;  
        -- A FOREIGN KEY constraint exists on this table. This   
        -- statement will generate a constraint violation error.  
        DELETE FROM Production.Product  
            WHERE ProductID = 980;  
  
    -- If the DELETE statement succeeds, commit the transaction.  
    COMMIT TRANSACTION;  
END TRY  
BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE usp_GetErrorInfo;  
  
    -- Test XACT_STATE:  
        -- If 1, the transaction is committable.  
        -- If -1, the transaction is uncommittable and should   
        --     be rolled back.  
        -- XACT_STATE = 0 means that there is no transaction and  
        --     a commit or rollback operation would generate an error.  
  
    -- Test whether the transaction is uncommittable.  
    IF (XACT_STATE()) = -1  
    BEGIN  
        PRINT  
            N'The transaction is in an uncommittable state.' +  
            'Rolling back transaction.'  
        ROLLBACK TRANSACTION;  
    END;  
  
    -- Test whether the transaction is committable.
    -- You may want to commit a transaction in a catch block if you want to commit changes to statements that ran prior to the error.
    IF (XACT_STATE()) = 1  
    BEGIN  
        PRINT  
            N'The transaction is committable.' +  
            'Committing transaction.'  
        COMMIT TRANSACTION;     
    END;  
END CATCH;  
GO  


--unary-operators-negative.md line: 37
- numeric_expression  

--unary-operators-negative.md line: 55
USE tempdb;  
GO  
DECLARE @MyNumber DECIMAL(10,2);  
SET @MyNumber = -123.45;  
SELECT @MyNumber AS NegativeValue;  
GO  

--unary-operators-negative.md line: 66
NegativeValue  
---------------------------------------  
-123.45  
  
(1 row(s) affected)  
  

--unary-operators-negative.md line: 78
USE tempdb;  
GO  
DECLARE @Num1 INT;  
SET @Num1 = 5;  
SELECT @Num1 AS VariableValue, -@Num1 AS NegativeValue;  
GO  

--unary-operators-negative.md line: 89
VariableValue NegativeValue  
------------- -------------  
5             -5  
  
(1 row(s) affected)  
  

--unary-operators-negative.md line: 103
USE ssawPDW;  
  
SELECT TOP (1) - 17 FROM DimEmployee;  

--unary-operators-negative.md line: 111
-17  

--unary-operators-negative.md line: 118
USE ssawPDW;  
  
SELECT TOP (1) - ( - 17) FROM DimEmployee;  

--unary-operators-negative.md line: 126
17  

--unary-operators-negative.md line: 133
USE ssawPDW;  
  
SELECT - BaseRate FROM DimEmployee;  


--unary-operators-positive.md line: 40
+ numeric_expression  

--unary-operators-positive.md line: 61
DECLARE @MyNumber DECIMAL(10,2);  
SET @MyNumber = +123.45;  
SELECT @MyNumber;  
GO  

--unary-operators-positive.md line: 70
-----------   
123.45            
  
(1 row(s) affected)  

--unary-operators-positive.md line: 80
USE tempdb;  
GO  
DECLARE @Num1 INT;  
SET @Num1 = -5;  
SELECT +@Num1, ABS(@Num1);  
GO  

--unary-operators-positive.md line: 91
----------- -----------  
-5          5  
  
(1 row(s) affected)  


--use-transact-sql.md line: 31
USE { database_name }   
[;]  

--use-transact-sql.md line: 55
USE AdventureWorks2022;  
GO  


--variables-transact-sql.md line: 34
-- Create the table.
CREATE TABLE TestTable (cola INT, colb CHAR(3));
GO
SET NOCOUNT ON;
GO
-- Declare the variable to be used.
DECLARE @MyCounter INT;

-- Initialize the variable.
SET @MyCounter = 0;

-- Test the variable to see if the loop is finished.
WHILE (@MyCounter < 26)
BEGIN;
   -- Insert a row into the table.
   INSERT INTO TestTable VALUES
       -- Use the variable to provide the integer value
       -- for cola. Also use it to generate a unique letter
       -- for each row. Use the ASCII function to get the
       -- integer value of 'a'. Add @MyCounter. Use CHAR to
       -- convert the sum back to the character @MyCounter
       -- characters after 'a'.
       (@MyCounter,
        CHAR( ( @MyCounter + ASCII('a') ) )
       );
   -- Increment the variable to count this iteration
   -- of the loop.
   SET @MyCounter = @MyCounter + 1;
END;
GO
SET NOCOUNT OFF;
GO
-- View the data.
SELECT cola, colb
FROM TestTable;
GO
DROP TABLE TestTable;
GO

--variables-transact-sql.md line: 82
DECLARE @MyCounter INT;

--variables-transact-sql.md line: 88
DECLARE @LastName NVARCHAR(30), @FirstName NVARCHAR(20), @StateProvince NCHAR(2);

--variables-transact-sql.md line: 93
USE AdventureWorks2022;
GO
DECLARE @MyVariable INT;
SET @MyVariable = 1;
-- Terminate the batch by using the GO keyword.
GO 
-- @MyVariable has gone out of scope and no longer exists.

-- This SELECT statement generates a syntax error because it is
-- no longer legal to reference @MyVariable.
SELECT BusinessEntityID, NationalIDNumber, JobTitle
FROM HumanResources.Employee
WHERE BusinessEntityID = @MyVariable;
--! sp_executesql
--variables-transact-sql.md line: 111
DECLARE @MyVariable INT;
SET @MyVariable = 1;
EXECUTE sp_executesql N'SELECT @MyVariable'; -- this produces an error

--variables-transact-sql.md line: 123
USE AdventureWorks2022;
GO
-- Declare two variables.
DECLARE @FirstNameVariable NVARCHAR(50),
   @PostalCodeVariable NVARCHAR(15);

-- Set their values.
SET @FirstNameVariable = N'Amy';
SET @PostalCodeVariable = N'BA5 3HX';

-- Use them in the WHERE clause of a SELECT statement.
SELECT LastName, FirstName, JobTitle, City, StateProvinceName, CountryRegionName
FROM HumanResources.vEmployee
WHERE FirstName = @FirstNameVariable
   OR PostalCode = @PostalCodeVariable;
GO

--variables-transact-sql.md line: 144
USE AdventureWorks2022;
GO
DECLARE @EmpIDVariable INT;

SELECT @EmpIDVariable = MAX(EmployeeID)
FROM HumanResources.Employee;
GO
--! return scalar value
--variables-transact-sql.md line: 159
USE AdventureWorks2022;
GO
DECLARE @EmpIDVariable INT;

SELECT @EmpIDVariable = BusinessEntityID
FROM HumanResources.Employee
ORDER BY BusinessEntityID DESC;

SELECT @EmpIDVariable;
GO

--! wait for
--waitfor-transact-sql.md line: 36
  
WAITFOR   
{  
    DELAY 'time_to_pass'   
  | TIME 'time_to_execute'   
  | [ ( receive_statement ) | ( get_conversation_group_statement ) ]   
    [ , TIMEOUT timeout ]  
}  

--waitfor-transact-sql.md line: 105
EXECUTE sp_add_job @job_name = 'TestJob';  
BEGIN  
    WAITFOR TIME '22:20';  
    EXECUTE sp_update_job @job_name = 'TestJob',  
        @new_name = 'UpdatedJob';  
END;  
GO  

--waitfor-transact-sql.md line: 118
BEGIN  
    WAITFOR DELAY '02:00';  
    EXECUTE sp_helpdb;  
END;  
GO  

--waitfor-transact-sql.md line: 129
IF OBJECT_ID('dbo.TimeDelay_hh_mm_ss','P') IS NOT NULL  
    DROP PROCEDURE dbo.TimeDelay_hh_mm_ss;  
GO  
CREATE PROCEDURE dbo.TimeDelay_hh_mm_ss   
    (  
    @DelayLength char(8)= '00:00:00'  
    )  
AS  
DECLARE @ReturnInfo VARCHAR(255)  
IF ISDATE('2000-01-01 ' + @DelayLength + '.000') = 0  
    BEGIN  
        SELECT @ReturnInfo = 'Invalid time ' + @DelayLength   
        + ',hh:mm:ss, submitted.';  
        -- This PRINT statement is for testing, not use in production.  
        PRINT @ReturnInfo   
        RETURN(1)  
    END  
BEGIN  
    WAITFOR DELAY @DelayLength  
    SELECT @ReturnInfo = 'A total time of ' + @DelayLength + ',   
        hh:mm:ss, has elapsed! Your time is up.'  
    -- This PRINT statement is for testing, not use in production.  
    PRINT @ReturnInfo;  
END;  
GO  
/* This statement executes the dbo.TimeDelay_hh_mm_ss procedure. */  
EXEC TimeDelay_hh_mm_ss '00:00:10';  
GO  

--! while
--while-transact-sql.md line: 33
-- Syntax for SQL Server and Azure SQL Database and Microsoft Fabric
  
WHILE Boolean_expression   
     { sql_statement | statement_block | BREAK | CONTINUE }  
  

--while-transact-sql.md line: 41
-- Syntax for Azure Azure Synapse Analytics and Parallel Data Warehouse  
  
WHILE Boolean_expression   
     { sql_statement | statement_block | BREAK }  
  

--while-transact-sql.md line: 72
USE AdventureWorks2022;  
GO  
WHILE (SELECT AVG(ListPrice) FROM Production.Product) < $300  
BEGIN  
   UPDATE Production.Product  
      SET ListPrice = ListPrice * 2  
   SELECT MAX(ListPrice) FROM Production.Product  
   IF (SELECT MAX(ListPrice) FROM Production.Product) > $500  
      BREAK  
   ELSE  
      CONTINUE  
END  
PRINT 'Too much for the market to bear';  

--while-transact-sql.md line: 91
DECLARE @EmployeeID as NVARCHAR(256)
DECLARE @Title as NVARCHAR(50)

DECLARE Employee_Cursor CURSOR FOR  
SELECT LoginID, JobTitle   
FROM AdventureWorks2022.HumanResources.Employee  
WHERE JobTitle = 'Marketing Specialist';  
OPEN Employee_Cursor;  
FETCH NEXT FROM Employee_Cursor INTO @EmployeeID, @Title;  
WHILE @@FETCH_STATUS = 0  
   BEGIN  
      Print '   ' + @EmployeeID + '      '+  @Title 
      FETCH NEXT FROM Employee_Cursor INTO @EmployeeID, @Title;  
   END;  
CLOSE Employee_Cursor;  
DEALLOCATE Employee_Cursor;  
GO 

--while-transact-sql.md line: 116
-- Uses AdventureWorks  
  
WHILE ( SELECT AVG(ListPrice) FROM dbo.DimProduct) < $300  
BEGIN  
    UPDATE dbo.DimProduct  
        SET ListPrice = ListPrice * 2;  
    SELECT MAX ( ListPrice) FROM dbo.DimProduct  
    IF ( SELECT MAX (ListPrice) FROM dbo.DimProduct) > $500  
        BREAK;  
END  

--! wildcard [^a] [^0-9A-z] m[n-z] etc;
--wildcard-character-s-not-to-match-transact-sql.md line: 32
-- Uses AdventureWorks  
  
SELECT TOP 5 FirstName, LastName  
FROM Person.Person  
WHERE FirstName LIKE 'Al[^a]%';   

--wildcard-character-s-not-to-match-transact-sql.md line: 41
FirstName     LastName
---------     --------
Alex          Adams
Alexandra     Adams
Allison       Adams
Alisha        Alan
Alexandra     Alexander

--wildcard-character-s-not-to-match-transact-sql.md line: 54
SELECT [object_id], OBJECT_NAME(object_id) AS [object_name], name, column_id 
FROM sys.columns 
WHERE name LIKE '[^0-9A-z]%';

--wildcard-character-s-not-to-match-transact-sql.md line: 62
object_id     object_name   name    column_id
---------     -----------   ----    ---------
1591676718    JunkTable     _xyz    1


--wildcard-character-s-to-match-transact-sql.md line: 34
SELECT name FROM sys.databases
WHERE name LIKE 'm[n-z]%';

--wildcard-character-s-to-match-transact-sql.md line: 40
name
-----
model
msdb

--wildcard-character-s-to-match-transact-sql.md line: 52
-- Uses AdventureWorks  
  
SELECT e.BusinessEntityID, p.FirstName, p.LastName, a.PostalCode  
FROM HumanResources.Employee AS e  
INNER JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID  
INNER JOIN Person.BusinessEntityAddress AS ea ON e.BusinessEntityID = ea.BusinessEntityID  
INNER JOIN Person.Address AS a ON a.AddressID = ea.AddressID  
WHERE a.PostalCode LIKE '[0-9][0-9][0-9][0-9]';  

--wildcard-character-s-to-match-transact-sql.md line: 65
EmployeeID      FirstName      LastName      PostalCode  
----------      ---------      ---------     ----------  
290             Lynn           Tsoflias      3000  

--wildcard-character-s-to-match-transact-sql.md line: 75
SELECT [object_id], OBJECT_NAME(object_id) AS [object_name], name, column_id 
FROM sys.columns 
WHERE name LIKE '[0-9!@#$.,;_]%';

--wildcard-character-s-to-match-transact-sql.md line: 83
object_id     object_name	                      name	column_id
---------     -----------                         ----  ---------
615673241     vSalesPersonSalesByFiscalYears	  2002	5
615673241     vSalesPersonSalesByFiscalYears	  2003	6
615673241     vSalesPersonSalesByFiscalYears	  2004	7
1591676718    JunkTable                           _xyz  1


--wildcard-match-one-character-transact-sql.md line: 33
SELECT name FROM sys.databases
WHERE name LIKE 'm_d%';

--wildcard-match-one-character-transact-sql.md line: 38
name
-----
model
msdb

--wildcard-match-one-character-transact-sql.md line: 51
-- USE AdventureWorks2022;
  
SELECT FirstName, LastName  
FROM Person.Person  
WHERE FirstName LIKE '_an'  
ORDER BY FirstName;  

--wildcard-match-one-character-transact-sql.md line: 62
SELECT name FROM sys.database_principals
WHERE name LIKE 'db_%';

--wildcard-match-one-character-transact-sql.md line: 69
SELECT name FROM sys.database_principals
WHERE name LIKE 'db[_]%';

--wildcard-match-one-character-transact-sql.md line: 75
name
-------------
db_owner
db_accessadmin
db_securityadmin
...



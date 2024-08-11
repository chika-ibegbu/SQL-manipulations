SELECT * FROM HumanResources.Department
SELECT * FROM Production.ProductCostHistory
SELECT * FROM Production.Product
SELECT * FROM Sales.Currency
Select * from Sales.CountryRegionCurrency

  --lIST OF PRODUCT
SELECT Name, ProductID,ReorderPoint,listPrice
FROM Production.Product

SELECT DISTINCT reorderPoint
FROM Production.Product

--ORDER BY (Sort)

SELECT JobTitle, BirthDate, MaritalStatus, Gender, NationalIDNumber
FROM HumanResources.Employee
Order by Jobtitle

-- AVERAGE PRICE OF PRODUCT
SELECT Name, AVG(listprice)
FROM Production.Product
GROUP by Name
ORDER by Name Desc

---COLOR GROUPING OF PRODUCT
SELECT color,
       AVG(listprice) AS 'Average list Price', 
       SUM(listprice) AS 'Total list Price',
       MAX(listprice) AS 'Maximum list Price',
       MIN(listprice) AS 'Minimum list Price'
FROM [Production].[Product]
GROUP by Color
ORDER by Color Desc

-------SQL JOIN----

SELECT Product.ProductID,Product.Name as 'Product Name',ProductSubcategory.Name as 'Product SubCategory',ProductCategory.Name as 'Product Category',Product.ListPrice
FROM Production.Product
left JOIN Production.ProductSubcategory
ON Product.ProductsubcategoryID = ProductSubcategory.ProductSubcategoryID
left JOIN Production.ProductCategory
ON Productcategory.ProductCategoryID=ProductSubcategory.ProductSubcategoryID
WHERE Product.listprice > 0.00
And ProductSubcategory.Name  is not null

---SQL CASE STATEMENT------

SELECT productID, Name, ListPrice,
CASE
    WHEN ListPrice > 1000 then ' price is expensive'
	ELSE 'product is okay to buy'
	END as PriceCategory
FROM Production.product

SELECT productID, Name, ListPrice,
CASE
    WHEN ListPrice < 100 then ' price is cheap'
	WHEN ListPrice > 500 then ' price is not very cheap'
	WHEN ListPrice > 1000 then ' price is expensive'
	ELSE 'product is okay to buy'
	END as PriceCategory
FROM Production.product


---COUNT OF PRODUCT CATEGORY

SELECT COUNT(P.[Name]) as Product, PSC.[Name] as ProductSubCategory,PC.[Name] as ProductCategory
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PSC
ON P.ProductsubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC
ON PC.ProductCategoryID=PSC.ProductSubcategoryID
WHERE P.ProductSubcategoryID is not null
Group by PSC.[Name],PC.[Name]


---------------------------------------------STORED PROCEDURE------------------------------------------
CREATE PROCEDURE GetDepartDetails
AS
SELECT Name AS DepartmentName, GroupName AS DepartmentCategory
FROM HumanResources.Department

Exec GetDepartDetails

CREATE PROCEDURE GetCurrency
AS
Begin
SELECT * 
FROM Sales.Currency SC
Left join Sales.CountryRegionCurrency SCR
on SC.CurrencyCode = SCR.CurrencyCode
where SCR.currencycode is not null
Order by SC.CurrencyCode
End

Exec GetCurrency 


CREATE PROCEDURE Getcur1 @currency nvarchar(40)='%'
AS
Begin
SELECT * 
FROM Sales.Currency SC
Left join Sales.CountryRegionCurrency SCR
on SC.CurrencyCode = SCR.CurrencyCode
where SCR.currencycode like @currency;
END

Exec Getcur1 'AED%'

--------------------------------------Create a TABLE-----------
----Account Table
CREAT TABLE Account
(AccountID int not null primary key,
CurrentBalance int,
AccountTypeID tinyint,
AccountStatusTypeID tinyint,
InterestSavingsRateID tinyint)
go 

INTO INTO Account values
(1, 2500, 11, 21, 31),
(2, 1200, 22, 22, 32),
(3, 3000, 33, 23, 33),
(4, 8000, 44, 24, 34),
(5, 1800, 55, 25, 35)
select *from Account
go
-------Employee Table
CREATE TABLE Employee
(EmployeeID int not null primary key,
EmployeeFirstName varchar(25),
EmployeeMiddleinitial char(1),
EmployeeLastName varchar(25),
EmployeeIsManager bit)
go

insert into Employee values
(36, 'Frank', 'A', 'TRUMP', 0),
(37, 'Justin', 'B', 'ROY', 1),
(38, 'Segun', 'W', 'PETER', 1),
(39, 'Suraju', 'D', 'PUTIN', 1),
(40, 'Oputa', 'E', 'MACRON', 0),
(41, 'Frankie', 'Z', 'JOE', 0),
(42, 'Flyboy', 'Q', 'TRUDEAU', 1),
(48, 'Kenneth', 'R', 'BIDEN', 1),
(49, 'Renee', 'P', 'KERR', 1),
(50, 'Chika', 'V', 'IBEGBU', 0)
select * from Employee
go
 
---TRIGGER FOR EMPLOYEE TABLE
Create trigger TRG_Insert_AccT ON Employee
AFTER INSERT, UPDATE
AS
UPDATE Employee SET EmployeeLastName = UPPER(EmployeeLastName)
WHERE EmployeeLastName in (SELECT EmployeeLastName from inserted);

UPDATE Employee SET EmployeeLastName = 'promise' WHERE EmployeeLastName= 'PUTIN'
UPDATE Employee SET EmployeeLastName = 'boyo' WHERE EmployeeLastName= 'BIDEN'

SELECT * FROM EMPLOYEE


----------VIEW-------
CREATE VIEW ItemsProduced 
AS
SELECT ProductID,NAME,color,listPrice,Standardcost
FROM Production.Product

CREATE VIEW TopEmpl
AS
Select top 50 NationalIDNumber, LoginID,JobTitle,HireDate,VacationHours
from HumanResources.Employee
order by NationalIDNumber desc

*/


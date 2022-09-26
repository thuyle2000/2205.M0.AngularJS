/* demo SELECT Sql */
--0. open data [db2205M0] de lam viec
use db2205M0
go


--1. demo SQL without FROM
SELECT LEFT('FPT APTECH Academy', 10)
SELECT RIGHT('FPT APTECH Academy', 7)
GO

-- khai bao bien schoolName
DECLARE @schoolName VARCHAR(30) 
-- gan gia tri cho bien
SET @schoolName= 'FPT APTECH Academy'
SELECT LEFT(@schoolName, 3)
SELECT RIGHT(@schoolName, 7)
SELECT SUBSTRING(@schoolName, 5,6)

-- khai bao cac bien so nguyen x,y va gan gia tri ban dau cho cac bien nay trong 1 lenh
DECLARE @x int = 172, @y int =50
SELECT @x as [x], @y as [y], @x+@y [x+y], @x-@y [x-y], @x*@y [x*y], @x%@y [x%y]
GO

--2. SELECT with * : xem toan bo ds sinh vien
SELECT * FROM tbStudent
GO
 
--3. SELECT column : xem toan bo ds SV bao gom cac cot id, name va email
SELECT id, fullname, email FROM tbStudent 
GO

--4. SELECT with new column name in resultset
SELECT id AS N'Mã số', fullname AS N'Họ tên', email FROM tbStudent 
SELECT id  N'Mã số', fullname  N'Họ tên', email FROM tbStudent 
GO

--5. SELECT with expressions
SELECT * FROM tbStudent

SELECT id, fullname, 
	CASE 
		WHEN gender=1 THEN 'Nam'
		ELSE 'Nu'
	END 'gender'
FROM tbStudent

SELECT id, fullname, 
	CASE 
		WHEN gender=1 THEN 'Nam'
		ELSE 'Nu'
	END 'gender',
	email, dob,
	DATEDIFF(YY, dob, GETDATE())  'age'
FROM tbStudent
GO

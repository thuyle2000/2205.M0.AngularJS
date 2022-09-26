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

--6. SELECT with DISTINCT
-- xem ds sinh vien da du thi (ma sinh vien)
SELECT * FROM tbExam
SELECT student_id FROM tbExam 
SELECT student_id FROM tbExam ORDER BY student_id
SELECT DISTINCT student_id FROM tbExam ORDER BY student_id

--7. SELECT WITH TOP
-- xem ds 2 sinh vien co diem thi cao nhat cua mon LBEP
SELECT * FROM tbExam 
SELECT * FROM tbExam WHERE module_id LIKE 'LBEP'
SELECT * FROM tbExam WHERE module_id LIKE 'LBEP' ORDER BY mark
SELECT * FROM tbExam WHERE module_id LIKE 'LBEP' ORDER BY 4 DESC

SELECT TOP 2 * FROM tbExam WHERE module_id LIKE 'LBEP' 
SELECT TOP 2 * FROM tbExam WHERE module_id LIKE 'LBEP' ORDER BY 4 DESC
SELECT TOP 2 WITH TIES * FROM tbExam WHERE module_id LIKE 'LBEP' ORDER BY 4 DESC

--8. SELECT INTO
-- Luu danh sach thi mon LBEP vo bang tbExamLBEP
SELECT * from tbExam WHERE module_id LIKE 'LBEP'

SELECT * INTO tbExamLBEP from tbExam WHERE module_id LIKE 'LBEP' -- INTO: luu kq bang tbExamLBEP
SELECT * from tbExamLBEP


--9. SELECT WHERE
-- xem ds sinh vien
SELECT * FROM tbStudent

-- xem ds sinh vien nam
SELECT * FROM tbStudent WHERE gender=1
SELECT id, fullname, email, dob FROM tbStudent WHERE gender=1

-- xem ds sinh vien co ho 'Nguyen'
SELECT * FROM tbStudent 
SELECT * FROM tbStudent WHERE fullname LIKE 'Nguyen%'

-- xem ds sinh vien co ky tu thu 2 trong email la chu 'a'
SELECT * FROM tbStudent 
SELECT * FROM tbStudent WHERE email LIKE '%a%'
SELECT * FROM tbStudent WHERE email LIKE '_a%'

-- xem ds sinh vien co ky tu thu 2 trong email la chu 'a' hoac 'h'
SELECT * FROM tbStudent 
SELECT * FROM tbStudent WHERE email LIKE '_a%' OR email LIKE '_h%'
SELECT * FROM tbStudent WHERE email LIKE '_[ah]%'

-- xem ds sinh vien co ky tu thu 2 trong email khong la chu 'a', va cung ko la chu 'h'
SELECT * FROM tbStudent 
SELECT * FROM tbStudent WHERE email NOT LIKE '_a%' AND email NOT LIKE '_h%'
SELECT * FROM tbStudent WHERE email LIKE '_[^ah]%'
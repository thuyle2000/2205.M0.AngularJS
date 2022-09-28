/* DEMO VE VIEW */
--1. open CSDL
use db2205M0
go

--2. tao view chua ds sinh vien nam [vwSchoolBoy]
CREATE VIEW vwSchoolBoy AS
	SELECT * FROM tbStudent WHERE gender=1
GO

-- xem ds sinh vien nam 
SELECT * FROM vwSchoolBoy
GO

--3. tao view chua ds sinh vien nu [vwSchoolGirl]
CREATE VIEW vwSchoolGirl AS
	SELECT * FROM tbStudent WHERE gender=0
GO

-- xem ds sinh vien nu
SELECT * FROM vwSchoolGirl
GO

--4. tao view chua chua ket qua thi, bao gom ho ten sv va ten mon thi [vwExam]: noi 3 bang tbExam, tbStudent va tbModule
CREATE VIEW [vwExam] AS
	SELECT a.id, 
		   a.student_id, b.fullname, a.module_id, c.module_name, 
		   a.mark
		   FROM tbExam [a] JOIN tbStudent [b] ON a.student_id=b.id
					       JOIN tbModule [c] ON a.module_id= c.id
GO

-- test view: xem ket qua thi voi day du thong tin ho ten va ten mon thi
SELECT * FROM vwExam

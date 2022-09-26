/* Demo lenh truy van nang cao */
--0. open CSDL
USE  db2205M0
GO

--1. in ds sinh vien co diem thi mon LBEP cao nhat
-- cach 1: ap dung select top 1 with ties
SELECT * FROM tbExam 
	WHERE module_id LIKE 'LBEP'
	ORDER BY mark DESC

SELECT TOP 1 * FROM tbExam 
	WHERE module_id LIKE 'LBEP'
	ORDER BY mark DESC

SELECT TOP 1 WITH TIES * FROM tbExam 
	WHERE module_id LIKE 'LBEP'
	ORDER BY mark DESC

--cach 2: ap dung sub-query
SELECT MAX(mark) FROM tbExam WHERE module_id LIKE 'LBEP'

SELECT * FROM tbExam
	WHERE module_id LIKE 'LBEP' AND
		  mark = (SELECT MAX(mark) FROM tbExam WHERE module_id LIKE 'LBEP')

GO

-- xem ds cac mon hoc
SELECT * FROM tbModule

--2. xem ket qua thi cua mon 'thiet ke web voi Angular'
SELECT id FROM tbModule WHERE module_name LIKE '%angular%'
SELECT * FROM tbExam 
	WHERE module_id LIKE (SELECT id FROM tbModule WHERE module_name LIKE '%angular%');

--3. xem ds sinh vien du thi mon Angular
SELECT student_id FROM tbExam 
	WHERE module_id LIKE (SELECT id FROM tbModule WHERE module_name LIKE '%angular%')

SELECT DISTINCT student_id FROM tbExam 
	WHERE module_id LIKE (SELECT id FROM tbModule WHERE module_name LIKE '%angular%')

SELECT * FROM tbStudent 
	WHERE id IN (SELECT DISTINCT student_id FROM tbExam 
					WHERE module_id LIKE (SELECT id FROM tbModule 
													WHERE module_name LIKE '%angular%'))
GO

--3. xem ds sinh vien chua du thi mon Angular
SELECT * FROM tbStudent 
	WHERE id NOT IN (SELECT DISTINCT student_id FROM tbExam 
					WHERE module_id LIKE (SELECT id FROM tbModule 
													WHERE module_name LIKE '%angular%'))
GO
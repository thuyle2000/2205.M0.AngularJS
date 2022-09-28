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




--4.  xem ket qua thi mon C bao gom ho ten sinh vien : ap dung phep ket JOIN
SELECT diem.*, sv.fullname
	FROM tbExam [diem] JOIN tbStudent [sv] ON diem.student_id = sv.id
	WHERE module_id LIKE 'LBEP'

SELECT diem.id,  diem.student_id, sv.fullname, diem.mark
	FROM tbExam [diem] JOIN tbStudent [sv] ON diem.student_id = sv.id
	WHERE module_id LIKE 'LBEP'


--5. xem ds sinh vien chua thi mon C
-- ds sv da thi mon C
SELECT * FROM tbStudent 
	WHERE id IN (SELECT DISTINCT student_id FROM tbExam 
					WHERE module_id LIKE (SELECT id FROM tbModule 
													WHERE module_name LIKE '%lap trinh C%'))

SELECT DISTINCT sv.*
	FROM (tbStudent [sv] JOIN tbExam [diem] ON sv.id = diem.student_id) 
						 JOIN tbModule [mon] ON mon.id = diem.module_id
	WHERE mon.module_name LIKE '%lap trinh C%'
GO


-- ds sv chua thi mon C
-- ds sv da thi (mark <> null) va chua thi mon C (mark=null)
SELECT  d.fullname, c.*  from tbStudent [d] LEFT JOIN  
	(SELECT a.id, b.module_name,  a.mark, a.student_id 
		FROM tbExam [a] JOIN tbModule [b] ON a.module_id = b.id
			WHERE module_name LIKE '%Lap trinh C%') [c]
	ON d.id = c.student_id
	ORDER BY c.mark

-- ds sv chua thi mon C (mark=null)
SELECT  d.fullname, c.*  from tbStudent [d] LEFT JOIN  
	(SELECT a.id, b.module_name,  a.mark, a.student_id 
		FROM tbExam [a] JOIN tbModule [b] ON a.module_id = b.id
			WHERE module_name LIKE '%Lap trinh C%') [c]
	ON d.id = c.student_id
	WHERE c.mark is NULL
	ORDER BY c.mark

-- ds sv da thi mon C (mark=null)
SELECT DISTINCT d.fullname,c.module_name,  c.student_id  
	from tbStudent [d] LEFT JOIN  
	(SELECT b.module_name,  a.mark, a.student_id 
		FROM tbExam [a] JOIN tbModule [b] ON a.module_id = b.id
			WHERE module_name LIKE '%Lap trinh C%') [c]
	ON d.id = c.student_id
	WHERE c.mark is NOT NULL



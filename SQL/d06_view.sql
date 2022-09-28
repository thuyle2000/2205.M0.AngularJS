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

--5. Them 1 nu sinh vo view nu sinh
SELECT * FROM vwSchoolGirl
INSERT vwSchoolGirl VALUES
('ST30','H`nie', 0, 'hnie@gmail.com','1998-07-30', 'ST14')

SELECT * FROM vwSchoolGirl
SELECT * FROM tbStudent
GO

--5. Sua nam sinh cua nu sinh 'Nguyen Minh Tri' co ma so sv la ST15 thanh '1998-06-15'
UPDATE vwSchoolGirl SET dob='1998-06-15' WHERE id='ST15'

SELECT * FROM vwSchoolGirl
SELECT * FROM tbStudent
GO

--6. xoa du lieu sinh vien 'H`nie' trong view nu sinh 
DELETE FROM vwSchoolGirl WHERE id='ST30'

SELECT * FROM vwSchoolGirl
SELECT * FROM tbStudent
GO

--7. Sua lai phan dinh nghia view nu sinh: bo sung them cot tuoi, bo cot gioi tinh
ALTER VIEW vwSchoolGirl AS
	SELECT id, fullname 'ho ten', email, 
		   dob 'ngay sinh', DATEDIFF(YY,dob, GETDATE()) 'tuoi', 
		   leader_id [truong nhom] 
	FROM tbStudent 
	WHERE gender=0
GO

-- Test lai view nu sinh
SELECT * FROM vwSchoolGirl
GO

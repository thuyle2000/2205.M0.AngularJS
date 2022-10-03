--open database 
use db2205M0
go


-- xem lai du lieu trong db
select * from tbBatch
select * from tbModule
select * from tbStudent
select * from tbExam
go

-- bo sung them cot ma lop hoc cho bang sinh vien, default la T1.2205.M0
ALTER TABLE tbStudent
	ADD batch_no VARCHAR(10) NOT NULL DEFAULT 'T1.2205.M0'
GO

-- xem lai danh sach sinh vien
select * from tbStudent

-- cap nhat lai ma lop hoc -> T1.2205.M1 cho 1 so sinh vien
UPDATE tbStudent SET batch_no='T1.2205.M1'
	WHERE id IN ('ST11','ST16', 'ST18', 'ST08', 'ST30', 'ST12','ST14')
GO


-- xem lai danh sach sinh vien
select * from tbStudent

-- cap nhat lai ma lop hoc -> A1.2205.M0 cho 1 so sinh vien
UPDATE tbStudent SET batch_no='A1.2205.M0'
	WHERE id IN ('ST02','ST04', 'ST07', 'ST13', 'ST15', 'ST17')
GO

-- xem ds sv theo ma lop hoc
SELECT * FROM tbStudent ORDER BY batch_no
SELECT batch_no, COUNT(*) [no. of students] FROM tbStudent GROUP BY batch_no
SELECT * FROM tbBatch
GO

-- xem danh sach cac lop hoc
SELECT * FROM tbBatch
-- bo sung them cot si so toi da cho bang lop hoc
ALTER TABLE tbBatch 
	ADD capacity INT NOT NULL DEFAULT 8
GO 



-- khi chua cai dat trigger => co the them sv thu 9 vo lop T1.2205.M0
INSERT tbStudent VALUES
('ST40','Pham Van A', 1, 'apham@gmail.com','2000-08-15','ST14','T1.2205.M0')
GO

/*-----------------*/
/*  INSERT TRIGGER */
/*-----------------*/
-- ngan chan viec cho dang ky qua nhieu vo 1 lop hoc vuot qua kha nang cua co so vat chat cho phep => tao trigger insert/update tren bang Sinh vien
CREATE TRIGGER tgStudentBatch 
   ON  tbStudent 
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- dem so luong sv trong lop hoc ma sv moi dang ky vo 
	DECLARE @dem INT, @maLop VARCHAR(10)

	-- lay ma so lop hoc cua sv moi dang ky
	SELECT @maLop=batch_no FROM inserted 
	-- dem so sv trong lop hoc nay (bao gom ca sv moi)
 	SELECT @dem = COUNT(*) FROM tbStudent WHERE batch_no LIKE @maLop

	-- kiem tra so luong sv co vuot qua si so cho phep ko ?
	DECLARE @siso INT
	SELECT @siso = capacity FROM tbBatch WHERE batch_no LIKE @maLop
	IF (@dem > @siso)
	BEGIN
		print 'Loi: So luong sv dang ky da vuot qua si so cho phep cua lop hoc ! Tu choi thao tac! '

		ROLLBACK -- huy lenh INSERT | UPDATE
	END

END
GO

-- Test case 1: Them 1 sv vo lop T1.2205.M0 : LOI vi vuot qua si so cua lop  !
INSERT tbStudent VALUES
('ST41','Pham Van B', 1, 'bpham@gmail.com','2000-08-15','ST14','T1.2205.M0')
GO

-- Test case 2: Them 1 sv vo lop T1.2205.M1 : OK !
INSERT tbStudent VALUES
('ST41','Pham Van B', 1, 'bpham@gmail.com','2000-08-15','ST14','T1.2205.M1')
GO


/*-----------------*/
/*  UPDATE TRIGGER */
/*-----------------*/
-- khong cho phep thay ten khoa hoc trong bang lop hoc
CREATE TRIGGER tgBatchCourse 
   ON  tbBatch 
   AFTER UPDATE
AS 
BEGIN
	IF UPDATE(course)
	BEGIN
		PRINT 'LOI: Khong the doi ten khoa hoc ! Tu choi thao tac !'
		ROLLBACK -- Tu choi thao tac update
	END
END

-- Test case 1: LOI khi sua ten khoa hoc
UPDATE tbBatch SET course = 'new course' WHERE batch_no = 'T1.2205.M0'
SELECT * FROM tbBatch

-- Test case 2: sua si so lop hoc : OK
UPDATE tbBatch SET capacity=6 WHERE batch_no = 'A1.2206.A0'
SELECT * FROM tbBatch
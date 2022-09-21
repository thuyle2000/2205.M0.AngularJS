-- demo ve cach tao bang trong 1 csdl
-- 1. tao CSDL [db2205M0] de lam vi du demo cho tat ca cac bai hoc cua mon DMS
CREATE DATABASE db2205M0
GO

--2. open CSDL [db2205M0] de lam viec: tao bang, chen du lieu vo bang.
USE db2205M0
GO

/* 
3. tao bang lop hoc tbBatch, bao gom cac cot:
  ma lop: chuoi 10 ky tu - not null - khoa chinh - nonclustered index, 
  chuong trinh: chuoi 20 ky tu, 
  thoi gian bat dau: date, 
  hoc phi:  so nguyen >=0 va <=10000, not null,  default: 1000
*/
CREATE TABLE tbBatch
(
	batch_no varchar(10) NOT NULL PRIMARY KEY NONCLUSTERED,
	course varchar(20),
	[start_date] DATE,
	fee int NOT NULL DEFAULT 1000 
);
GO

-- bo sung them rang buoc kiem tra: hoc phi phai >=0 va <=10000
ALTER TABLE tbBatch
	ADD CONSTRAINT CK_BATCH_FEE Check (fee >=0 AND fee <=10000)
GO

-- Them du lieu cho bang lop hoc
SET DATEFORMAT DMY
INSERT tbBatch(batch_no,course, [start_date], fee ) VALUES
('T1.2205.M0','ACCP 7023', '16-05-2022', 1200)

SELECT * FROM tbBatch

-- Them nhieu bo du lieu cho bang lop hoc
SET DATEFORMAT DMY
INSERT tbBatch(batch_no,course, [start_date], fee ) VALUES
('T1.2205.M1','ACCP 7023', '19-05-2022', 1200),
('A1.2205.M0','Arena 7749', '01-05-2022', 1500),
('A1.2206.A0','ACCP 6715', '09-06-2022', 1250)

SELECT * FROM tbBatch
GO

/* 
4. tao bang chua danh sach cac mon hoc tbModule, bao gom cac cot:
  ma mon hoc: chuoi 5 ky tu - not null - khoa chinh - nonclustered index, 
  ten mon hoc: chuoi 40 ky tu, 
  tong so gio hoc: so nguyen >0 va <60, not null, default: 40 
  hoc phi:  so nguyen >=0 va <=500, not null,  default: 100
*/
CREATE TABLE tbModule 
(
	id varchar(5) NOT NULL PRIMARY KEY NONCLUSTERED,
	module_name varchar(40),
	[hours] tinyint NOT NULL DEFAULT 40 CHECK ([hours] >0 AND [hours] <60),
	[module_fee] smallint NOT NULL DEFAULT 100 CHECK ([module_fee] BETWEEN 0 AND 500)
)
GO

-- Them du lieu cho bang mon hoc : insert nhieu mon hoc cung 1 luc (vi chen du lieu cho tat ca cac cot nen co the bo qua danh sach cot sau ten bang)
INSERT tbModule VALUES
('LBEP', 'Tu Duy Logic voi Lap trinh C', 58, 200),
('HCJS', 'Thiet ke Web voi HTML5, CSS3 va JS', 58, 250),
('AJS', 'Thiet ke web voi framework Angular', 24, 180),
('PRJ1', 'Eproject I', 24, 180),
('DDD', 'Phat Trien, Thiet Ke CSDL', 10, 50),
('DMS', 'Quan Tri CSQL SQLserver 2019', 54, 250)

SELECT * FROM tbModule
GO


/* 
5. tao bang chua danh sach sinh vien tbStudent, bao gom cac cot:
  ma sinh vien: chuoi 15 ky tu - not null - khoa chinh - nonclustered index, 
  ho ten: chuoi 40 ky tu - not null, 
  gioi tinh: bit - not null - default 1 (true),
  email:  chuoi 40 ky tu - not null - duy nhat,
  ngay sinh : date
  ma so nhom truong : chuoi 15 ky tu
*/
CREATE TABLE tbStudent 
(
	id varchar(15) NOT NULL PRIMARY KEY NONCLUSTERED,
	fullname varchar(40) NOT NULL,
	gender bit NOT NULL DEFAULT 1,
	email varchar(40) NOT NULL UNIQUE,
	dob DATE,
	leader_id varchar(15)
)

-- Them du lieu vo bang sinh vien
SET DATEFORMAT DMY
INSERT tbStudent VALUES
('ST01','Nguyen Luu Gia Bao',1,'baonguyen@gmail.com','03-09-1996', NULL),
('ST02','Ma Hoang Thuy Tien',0,'tienma@gmail.com','02-12-2003', 'ST01'),
('ST03','Nguyen Huu Phuoc',1,'phuocnguyen@fpt.edu.vn','25-12-2000', NULL),
('ST04','Nguyen Phuoc Thinh',1,'thinhnguyen@fpt.edu.vn','18-09-2003', 'ST03'),
('ST05','Nguyen Minh Tri',1,'tringuyen@fpt.edu.vn','28-10-2004', 'ST03'),
('ST06','Pham van Phu',1,'phupham@fpt.edu.vn','02-09-2003', 'ST03'),
('ST07','Pham Hung Quoc Vinh',1,'hungpham@fpt.edu.vn','13-09-2002', NULL),
('ST08','Nguyen Le Tien Dung',1,'dungnguyen@fpt.edu.vn','15-08-2004', 'ST07'),
('ST09','Ho Thong Vien',1,'vienho@fpt.edu.vn','15-04-2004', 'ST07'),
('ST10','Ngo Quoc Viet',1,'vietngo@fpt.edu.vn','02-03-1996', NULL),
('ST11','Luong Thanh Hop',1,'hopluong@fpt.edu.vn','02-03-2003', 'ST10'),
('ST12','Bui Tuan Anh',1,'anhbui@fpt.edu.vn','01-01-1999', NULL),
('ST13','Vu Dai Vinh Quang',1,'quangvu@fpt.edu.vn','01-01-2003', 'ST12'),
('ST14','Nguyen Tien Ngoc',1,'ngocnguyen@fpt.edu.vn','13-12-2003', NULL),
('ST15','Nguyen Minh Tri',0,'tringuyen2@fpt.edu.vn','22-11-2003', 'ST14'),
('ST16','Vo Hung Viet Nhat',0,'nhatvo@fpt.edu.vn','22-10-2003', 'ST14'),
('ST17','Ho Dang Viet Tien',1,'tienho@fpt.edu.vn','20-06-2003', null),
('ST18','Lam Vinh Hao',1,'haolam@fpt.edu.vn','22-10-2004', 'ST17'),
('ST19','Nguyen Phu Hao',1,'haophu@fpt.edu.vn','05-10-2003', 'ST17')


SELECT * FROM tbStudent
GO

/* 
6. tao bang chua diem ket qua thi cac mon hoc tbExam, bao gom cac cot:
  ma so bai thi : so thu tu tang tu dong, bat dau la so 1, nhay 1 so - not null- khoa chinh- noncluster index,
  ma mon hoc: chuoi 5 ky tu - not null - khoa ngoai - tham chieu du lieu cua ma mon hoc thuoc bang mon hoc, 
  ma sinh vien: chuoi 15 ky tu - not null - khoa ngoai - tham chieu du lieu cua ma sinh vien thuoc bang sinh vien, 
  diem ket qua: so nguyen >=0 va <=100
*/

CREATE TABLE tbExam 
(
	id int identity(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
	student_id varchar(15) NOT NULL,
	module_id varchar(5) NOT NULL,
	mark tinyint CHECK (mark BETWEEN 0 AND 100),
	CONSTRAINT FK_ex_student FOREIGN KEY(student_id) REFERENCES tbStudent(id),
	CONSTRAINT FK_ex_module FOREIGN KEY(module_id) REFERENCES tbModule(id),
)
GO

-- nhap diem ket qua thi mon C cho vai sinh vien
INSERT tbExam (student_id, module_id, mark) VALUES
('ST01', 'LBEP', 90),
('ST01', 'LBEP', 50),
('ST03', 'LBEP', 30),
('ST03', 'LBEP', 100),
('ST10', 'LBEP', 100),
('ST10', 'LBEP', 55),
('ST14', 'LBEP', 39),
('ST14', 'LBEP', 93),
('ST14', 'LBEP', 100)
GO

-- nhap diem ket qua thi mon thiet ke Web cho vai sinh vien
INSERT tbExam (student_id, module_id, mark) VALUES
('ST01', 'HCJS', 60),
('ST01', 'HCJS', 90),
('ST03', 'HCJS', 60),
('ST03', 'HCJS', 85),
('ST10', 'HCJS', 95),
('ST10', 'HCJS', 70),
('ST14', 'HCJS', 30),
('ST14', 'HCJS', 99),
('ST14', 'HCJS', 100),
('ST15', 'HCJS', 60),
('ST15', 'HCJS', 75)

GO

SELECT * FROM tbExam
GO


-- 7. tao foreign key tren cot leader_id cua bang sinh vien tham chieu du cua cot id thuoc bang sinh vien (con goi la tham chieu vong )
ALTER TABLE tbStudent
	ADD CONSTRAINT FK_student FOREIGN KEY (leader_id) REFERENCES tbStudent(id)
GO

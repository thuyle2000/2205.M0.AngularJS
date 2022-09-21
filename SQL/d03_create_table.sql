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
GO
SELECT * FROM tbBatch

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
GO
GO


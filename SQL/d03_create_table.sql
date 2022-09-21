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
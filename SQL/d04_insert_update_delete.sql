-- open database db2205M0
use db2205M0
go

-- xem ds sinh vien trong bang tbStudent
select * from tbStudent

-- xem danh sach cac lop hoc luu trong bang tbBatch
select * from tbBatch

-- xem ds cac mon hoc luu trong bang tbModule
select * from tbModule

-- xem bang diem kq thi trong bang tbexam
select * from tbExam
go

-- sua diem cua bai thi ma so 18 (co ma sv:ST14, ma mon hoc: HCJS ) tu 100 -> 89
UPDATE tbExam SET mark = 89 WHERE id=18
GO


-- liet ke cac bai thi mon HCJS duoi 40 diem
SELECT * from tbExam 
	WHERE module_id LIKE 'HCJS' AND mark < 40

-- cong them 2 diem cho cac bai thi mon HCJS co so diem duoi 40
UPDATE tbExam SET mark = mark+2 
	WHERE module_id LIKE 'HCJS' AND mark < 40

-- liet ke cac bai thi mon HCJS duoi 40 diem
SELECT * from tbExam 
	WHERE module_id LIKE 'HCJS' AND mark < 40
GO

-- xem lai bang ket qua thi
SELECT * FROM tbExam
GO

-- xoa bai thi co ma so 13
DELETE FROM tbExam WHERE id=13
GO

-- nhap diem ket qua thi mon angular cho vai sinh vien
INSERT tbExam (student_id, module_id, mark) VALUES
('ST01', 'AJS', 50),
('ST02', 'AJS', 32),
('ST02', 'AJS', 64),
('ST03', 'AJS', 56),
('ST03', 'AJS', 90),
('ST04', 'AJS', 34),
('ST04', 'AJS', 70),
('ST05', 'AJS', 30),
('ST05', 'AJS', 99),
('ST06', 'AJS', 100),
('ST07', 'AJS', 40),
('ST08', 'AJS', 28),
('ST08', 'AJS', 82),
('ST09', 'AJS', 54),
('ST10', 'AJS', 36),
('ST10', 'AJS', 63),
('ST11', 'AJS', 75)
GO
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

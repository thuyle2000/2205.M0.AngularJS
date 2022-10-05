--open database
use db2205M0
go

-- xem ds sinh vien
SELECT * FROM tbStudent

-- tao clustered index tren cot email cua bang sinh vien
CREATE CLUSTERED INDEX [ixEmail] ON tbStudent(email)
GO
-- xem ds sinh vien
SELECT * FROM tbStudent


-- tao non-clustered index tren cot ho ten sinh vien va ngay sinh
CREATE INDEX [ixStudentName] ON tbStudent(fullname, dob DESC)
GO

-- xem ds lop hoc
select * FROM tbBatch

-- xem ds mon hoc
SELECT * FROM tbModule

-- tao unique index tren cot ten mon hoc cua bang mon hoc : vi muon ten mon hoc ko duoc trung nhau
CREATE UNIQUE INDEX [ixModuleName] ON tbModule(module_name)
GO

-- test case 1: them mon hoc moi (XML,'XML va JSON') : OK
INSERT tbModule VALUES ('XML', 'XML & JSON', 20, 200)
GO

-- test case 2: them mon hoc moi (PRJ2,'Eproject I') : LOI vi ten mon hoc trung nhau !
INSERT tbModule VALUES ('PRJ2', 'Eproject I', 24, 250)
GO







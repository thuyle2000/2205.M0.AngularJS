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
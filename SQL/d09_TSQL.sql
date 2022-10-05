-- open database
use db2205M0
go

-- tao synonym (them 1 ten moi) [lophoc] cho bang [tbBatch]
CREATE SYNONYM [dbo].[LopHoc] FOR [localhost].[db2205M0].[dbo].[tbBatch]
GO

-- xoa synonym
DROP SYNONYM [dbo].[LopHoc]
GO

-- tao lai synonym (them 1 ten moi) [lophoc] cho bang [tbBatch]
CREATE SYNONYM [dbo].[LopHoc] FOR [thuylm].[db2205M0].[dbo].[tbBatch]
GO

-- sau khi tao synonyms [dbo].[lophoc], truy van du lieu tu doi tuong nay
select * from dbo.lophoc
select * from lophoc
select * from tbBatch
GO

-- demo tao function trong SQL SERVER
/*
  ham xep loai ket qua thi dua vao thang diem 0-100:
- A [100-90], B[89-80], C[79-65], D[64-40], E[<40]
*/
CREATE FUNCTION [fnRange] 
( @diem INT )
RETURNS VARCHAR(30)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @XepLoai VARCHAR(30)

	-- Add the T-SQL statements to compute the return value here
	IF (@diem >=90)
		SET @Xeploai = 'A - Xuat sac'
	ELSE IF (@diem >=80)
		SET @Xeploai = 'B - Gioi'
	ELSE IF (@diem >=65)
		SET @Xeploai = 'C - Kha'
	ELSE IF (@diem >=40)
		SET @Xeploai = 'D - Trung Binh'
	ELSE
	    SET @Xeploai = 'E - Khong dat yeu cau'

	-- Return the result of the function
	RETURN @XepLoai
END
GO


-- test case : xem ket qua thi cua sinh vien, bao gom cot phan loai
SELECT * FROM tbExam  -- chua co cot phan loai
SELECT *, dbo.fnRange(mark) [Ranking] FROM tbExam
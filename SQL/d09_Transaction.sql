-- open database
use db2205M0
go

-- demo transaction with commit
BEGIN TRAN
	SELECT * FROM tbBatch
	-- them du lieu vo bang lop hoc
	INSERT tbBatch VALUES ('T1.2207.M0', 'ACCP 7024','2002-07-12', 1250, 7)
	SELECT * FROM tbBatch
	COMMIT	-- xac nhan hoan tat transaction
GO

-- xem ds lop hoc
SELECT * FROM tbBatch
GO

-- demo transaction with rollback
BEGIN TRAN
	SELECT * FROM tbBatch
	-- them du lieu vo bang lop hoc
	INSERT tbBatch VALUES ('T1.2207.M1', 'ACCP 7024','2002-07-19', 1250, 7)
	SELECT * FROM tbBatch
	ROLLBACK	-- huy transaction
GO

SELECT * FROM tbBatch
GO
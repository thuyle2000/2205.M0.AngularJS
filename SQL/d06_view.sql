/* DEMO VE VIEW */
--1. open CSDL
use db2205M0
go

--2. tao view chua ds sinh vien nam [vwSchoolBoy]
CREATE VIEW vwSchoolBoy AS
	SELECT * FROM tbStudent WHERE gender=1
GO

-- xem ds sinh vien nam 
SELECT * FROM vwSchoolBoy
GO

--3. tao view chua ds sinh vien nu [vwSchoolGirl]
CREATE VIEW vwSchoolGirl AS
	SELECT * FROM tbStudent WHERE gender=0
GO

-- xem ds sinh vien nu
SELECT * FROM vwSchoolGirl
/*  Demo extended procedure  */
exec xp_logininfo
GO

exec xp_fileexist 'F:\hoa-lan.jpg'
go

exec xp_fileexist 'F:\student'
go

exec xp_dirtree 'F:\student\2205-M0'
go


/*  
 *  Demo custom (user-defined) store procedure  
 */
 -- open database [db2205M0] de lam viec
 use db2205M0
 go

 /*=================================================
	1. tao stored procedure [up_Student], thuc hien :
		- in ra ds sv theo thu tu gioi tinh va ma so
		- dem va in ra so sv nam , nu
  ==================================================*/
CREATE PROCEDURE up_Student AS
BEGIN
    -- in ra ds sv theo thu tu gioi tinh va ma so
	SELECT * FROM tbStudent ORDER BY gender, id

	-- dem va in ra so luong sv nam , nu
	SELECT CASE gender WHEN 1 THEN 'Male'
					   ELSE 'Female'
		   END 'gender',			    
		   COUNT(*) [total of students ] 
	   FROM tbStudent GROUP BY gender

END
GO
-- Test case:
exec up_Student
GO


 /*=================================================
	2. tao stored procedure [up_increaseFee], thuc hien :
		- in ra ds cac mon hoc theo thu tu hoc phi giam dan
		- tang hoc phi tat ca cac mon +10USD
		- in ra ds cac mon hoc sau khi thuc hien viec tang hoc phi
  ==================================================*/
  CREATE PROC up_increaseFee AS
  BEGIN
	-- in ra ds cac mon hoc theo thu tu hoc phi giam dan
	SELECT * FROM tbModule ORDER BY module_fee DESC

	-- tang hoc phi tat ca cac mon +10USD
	UPDATE tbModule SET module_fee += 10

	-- in ra ds cac mon hoc sau khi thuc hien viec tang hoc phi
	SELECT * FROM tbModule ORDER BY module_fee DESC
  END
  GO

  -- test case
  exec up_increaseFee
  GO

  /*=================================================
	3. tao stored procedure [up_ChangeFee], thay doi 'hoc phi' cua 1 'mon hoc bat ky'
			=> store co 2 tham so input: ma mon hoc va hoc phi moi
			=> thuc hien:
		- in ra thong tin cua mon hoc muon thay doi bieu gia
		- cap nhat gia hoc phi moi
		- in lai thong tin cua mon hoc sau khi thay doi bieu gia
  ==================================================*/
  CREATE PROC [up_ChangeFee] 
	  @MaMH varchar(5),			-- tham so input thu 1
	  @HocPhiMoi smallint = 50	-- tham so input thu 2, default =50 neu khi goi store ko cung cap tham so thu 2
  AS
  BEGIN
	-- in ra thong tin cua mon hoc muon thay doi bieu gia
	SELECT * FROM tbModule WHERE id LIKE @MaMH

	-- cap nhat gia hoc phi moi
	UPDATE tbModule SET module_fee = @HocPhiMoi WHERE id LIKE @MaMH

	-- in lai thong tin cua mon hoc sau khi thay doi bieu gia
	SELECT * FROM tbModule WHERE id LIKE @MaMH
  END
  GO

  -- test case 1: doi hoc phi mon AJS -> 160
  exec up_ChangeFee 'AJS', 160
  GO

 -- test case 2: doi hoc phi mon DDD -> 50 (don gia default)
  exec up_ChangeFee 'DDD'
  GO

  /*=================================================
	4. tao stored procedure [up_ChangeHour], thay doi 'tong so gio hoc' cua 'mon hoc bat ky'
			=> store co 2 tham so input: ten mon hoc va tong so gio hoc moi,
			            1 tham so output: tong so mon hoc da duoc thay doi gio hoc
			=> thuc hien:
					- in ra thong tin cua cac mon hoc truoc khi thay doi thoi gian hoc
					- cap nhat thoi gian hoc moi (co the tang hoac giam)
					- in lai thong tin cua mon hoc sau khi thay doi thoi gian hoc
  ==================================================*/
CREATE PROC [up_ChangeHour]
		@TenMH varchar(30) ,	-- tham so thu 1
		@TongGio smallInt ,		-- tham so thu 2
		@TongMH int OUTPUT			-- tham so thu 3  : chua so luong mon hoc da duoc thay doi gio hoc
  AS
  BEGIN
	-- in ra thong tin cua cac mon hoc truoc khi thay doi thoi gian hoc
	SELECT * FROM tbModule

	-- cap nhat thoi gian hoc moi (co the tang hoac giam)
	UPDATE tbModule SET hours +=@TongGio WHERE module_name LIKE '%'+ @TenMH +'%'

	-- cap nhat bien dem tong so dong trong bang tbModule bi thay doi do lenh UPDATE
	SET @TongMH = @@ROWCOUNT

	-- in ra thong tin cua cac mon hoc sau khi thay doi thoi gian hoc
	SELECT * FROM tbModule
  END
  GO

  SELECT * FROM tbModule

   -- test case 1:  tang gio hoc mon Angular them 6h
  DECLARE @soMH tinyint
  EXEC up_ChangeHour 'angular', 6, @soMH OUTPUT
  SELECT @soMH 'So Mon Hoc da duoc thay doi gio hoc'
  GO

  -- test case 2:  giam gio hoc cua cac mon thiet ke Web xuong 4h
  DECLARE @soMH tinyint
  EXEC up_ChangeHour 'web', -4, @soMH OUTPUT
  SELECT @soMH 'So Mon Hoc da duoc thay doi gio hoc'
  GO
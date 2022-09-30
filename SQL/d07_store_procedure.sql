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

 /*
	1. tao stored procedure [up_Student], thuc hien :
		- in ra ds sv theo thu tu gioi tinh va ma so
		- dem va in ra so sv nam , nu
*/
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



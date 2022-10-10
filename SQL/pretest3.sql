/*-----  PRETEST 3 -----*/

/*-------------------------------------------------------------------
1. Create a database named dbPretest3 with the following specifications :
a. Primary file group with the data file dbpretest3.mdf. The size, maximum size, and file growth should be 5, unlimited and 20 respectively.
b. Log file dbpretest3_log.ldf. The size, maximum size, and file growth should be 2, 50, and 10% respectively.
---------------------------------------------------------------------*/
CREATE DATABASE dbPretest3
ON Primary
(name='dbPretest3', filename='F:\Data\dbpretest3.mdf', size=5, maxsize=unlimited, filegrowth=20)
LOG ON
(name='dbPretest3_log', filename='F:\Data\dbpretest3_log.ldf', size=2, maxsize=50, filegrowth=10%)
GO

USE dbPretest3
GO

/*-------------------------------------------------------------------
2a. Create the table tbEmpDetails as follows: 
	Field Name	Data Type constraint Description
	Emp_Id		varchar(5) Primary Key Stores employee identification number
	FullName	varchar(30) Not null Stores full name of the employee
	PhoneNumber varchar(20) Not null Stores phone number of the employee
	Designation varchar(30) Manager or Staff Stores designation or job role of the employee
	Salary		money >=0 and <=3000 Stores salary of the employee
	Join_date	datetime Stores date of joining for the employee
---------------------------------------------------------------------*/
CREATE TABLE tbEmpDetails(
	Emp_Id varchar(5) not null Primary Key nonclustered,
	FullName varchar(30) Not null,
	PhoneNumber varchar(20) Not null,
	Designation varchar(30) CHECK (Designation IN('Manager','Staff')),
	Salary money CHECK(Salary>=0 and Salary<=3000),
	Join_date datetime 
)

GO
/*-------------------------------------------------------------------
2b.Create the table tbLeaveDetails as follows:
Field Name Data Type constraint Description
Leave_ID	identity Primary Key
Emp_Id		varchar(5) foreign Key
LeaveTaken	int >0 and <15 Stores the number of leaves taken by the employee
FromDate	datetime Date from when leave was availed
ToDate		Datetime >fromdate Date upto which leave was taken
Reason		Varchar(50) Not null Reason for the leave
---------------------------------------------------------------------*/
CREATE TABLE tbLeaveDetails (
	Leave_ID int identity PRIMARY KEY NONCLUSTERED, 
	Emp_Id varchar(5) foreign Key REFERENCES tbEmpDetails(Emp_Id),
	LeaveTaken int CHECK(LeaveTaken BETWEEN 1 and 14),
	FromDate Date,
	ToDate Date,
	Reason Varchar(50) Not null ,
	CHECK (FromDate < ToDate)
)

GO

/*-------------------------------------------------------------------
3. Insert at least five records to each table
---------------------------------------------------------------------*/
SET DATEFORMAT dmy
INSERT tbEmpDetails VALUES
('E01','Anh Mot', '111','Manager',1000, '01/04/2020'),
('E02','Chi Hai', '222','Staff', 200,'01/05/2020'),
('E03','Chi Ba', '233','Staff',599, '01/04/2020'),
('E04','Anh Tu', '444','Manager',2000, '01/06/2020'),
('E05','Chi Nam', '555 666','Staff',600, '01/06/2020')

SELECT * FROM tbEmpDetails
GO

SET DATEFORMAT dmy
INSERT tbLeaveDetails VALUES
('E01',2,'01/03/2022','02/03/2022','nghi benh'),
('E01',2,'01/05/2022','02/05/2022','nghi benh'),
('E03',5,'01/03/2022','05/03/2022','nghi phep nam'),
('E04',4,'01/04/2022','04/04/2022','nghi dam cuoi'),
('E02',2,'01/06/2022','02/06/2022','nghi om')

SELECT * FROM tbLeaveDetails
GO


/*-------------------------------------------------------------------
4.Create a clustered index IX_Fullname for fullname column on tbEmployeeDetails table.
  Create an index IX_EmpID for Emp_ID column on tbLeaveDetails table
---------------------------------------------------------------------*/
CREATE CLUSTERED INDEX IX_Fullname ON tbEmpDetails(fullname)

CREATE INDEX IX_EmpID ON tbLeaveDetails(Emp_Id)

GO
/*-------------------------------------------------------------------
5.Create a view vwManager to retrieve the number of leaves taken by employees having designation as Manager
Note: this view will need to check for domain integrity and encryption.
---------------------------------------------------------------------*/
CREATE VIEW vwManager WITH ENCRYPTION
AS
SELECT b.Emp_Id, b.FullName, b.Designation, a.FromDate, a.ToDate, a.LeaveTaken, a.Reason
	FROM tbLeaveDetails [a] JOIN tbEmpDetails [b] ON a.Emp_Id = b.Emp_Id
	WHERE b.Designation LIKE 'Manager'
WITH CHECK OPTION
GO

-- TEST CASE
select * from vwManager
GO
sp_helptext vwManager
GO


/*-------------------------------------------------------------------
6.Create a store procedure uspChangeSalary to increase salary of an employee by a given value (Hint: using input parameters)
---------------------------------------------------------------------*/
CREATE PROC uspChangeSalary
@maNV varchar(5), @muctang money -- tham so input
AS
	-- xem luong cb cua nv truoc khi tang
	SELECT * FROM tbEmpDetails WHERE Emp_Id LIKE @maNV

	-- tang luong cho nv co ma so @manv
	UPDATE tbEmpDetails SET Salary += @muctang WHERE Emp_Id LIKE @maNV

	-- xem lai luong cb cua nv sau khi duoc tang
	SELECT * FROM tbEmpDetails WHERE Emp_Id LIKE @maNV
GO

-- TEST CASE  : tang 300 tien luong cho nv co ma so E04
EXEC uspChangeSalary 'E04', 300
GO


/*-------------------------------------------------------------------
7.Create a trigger tgInsertLeave for table tbLeaveDetails which will perform rollback transaction if total of leaves taken by employees in a year greater than 15 and display appropriate error message.
---------------------------------------------------------------------*/
CREATE TRIGGER tgInsertLeave ON tbLeaveDetails
AFTER INSERT, UPDATE AS
BEGIN
	DECLARE @manv Varchar(5), @sonn int, @nam int
	SELECT @manv= Emp_Id, @nam = YEAR(FromDate) 
		FROM inserted --lay ma so nhan vien xin nghi phep

	SELECT @sonn=SUM(LeaveTaken) 
		FROM tbLeaveDetails 
		WHERE Emp_Id LIKE @manv AND YEAR(FromDate)=@nam

	IF (@sonn > 14)
	BEGIN
		print 'Tong so ngay nghi phep trong nam ko the lon hon 14. Tu choi thao tac !'
		ROLLBACK -- huy thao tac INSERT/UPDATE
	END
END
GO

-- test case 1: tinh huong thanh cong
INSERT tbLeaveDetails VALUES
('E03',5,'01/05/2022','06/05/2022','nghi phep nam')
GO

SELECT * FROM tbLeaveDetails
GO

-- test case 2: tinh huong that bai
INSERT tbLeaveDetails VALUES
('E03',6,'01/08/2022','07/08/2022','nghi phep nam')
GO

SELECT * FROM tbLeaveDetails
GO

/*-------------------------------------------------------------------
8.Create a trigger tgUpdateEmploee for table tbEmployeeDetails which removes the employee if new salary is reset to zero.
---------------------------------------------------------------------*/
--CREATE TRIGGER tgUpdateEmploee

GO
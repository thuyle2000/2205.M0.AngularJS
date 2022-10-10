/*	PRETEST 4 */

/*
Create a database named dbPretest4 with the following specifications :
	a. Primary file group with the data file dbPretest4.mdf. The size, maximum size,
	and file growth should be 8, unlimited and 20 respectively.
	b. Log file dbPretest4_log.ldf. The size, maximum size, and file growth should be
	8, 50, and 10% respectively.
*/

CREATE DATABASE [dbPretest4]
ON Primary
(name='dbPretest4', filename='F:\Data\dbPretest4.mdf', size=8, maxsize=unlimited, filegrowth=20)
LOG ON
(name='dbPretest4_log', filename='F:\Data\dbPretest4_log.ldf', size=8, maxsize=50, filegrowth=10%)
GO


-- open database
USE dbPretest4
GO


/*
2. Create the tables tbStudents
FieldName	Data Type	Constraint
stID		varchar(5)	Primary Key
stName		varchar(50) Not null
stAge		tinyint		>=14 and <=70
stGender	bit			Default 1
*/
CREATE TABLE tbStudents (
	stID	varchar(5)	Primary Key NONCLUSTERED,
	stName	varchar(50) Not null,
	stAge	tinyint		CHECK(stAge >=14 and stAge<=70),
	stGender	bit 	Default 1 Not null
)
GO

/* Create table tbProjects
Field Name	Data Type	Constraint
pID			Varchar(5)	Primary Key
pName		Varchar(50)	Not null, unique
pType		Varchar(5)	‘EDU’ or ‘DEP’ or ‘GOV’
pStartDate	Date		Not null, Default current-date
*/
CREATE TABLE tbProjects (
	pID	Varchar(5) not null	Primary Key NONCLUSTERED,
	pName Varchar(50) Not null unique,
	pType Varchar(5) CHECK( pType IN ('EDU', 'DEP', 'GOV')),
	pStartDate	Date Not null Default GETDATE()
)
GO

/* Create table tbStudentProject
Field Name	Data Type		Constraint
studentID	Varchar(5)		Not null, foreign key
projectID	Varchar(5)		Not null, foreign key
joinedDate	date			Not null, Default current-date
rate		tinyint			From 1 to 5
Primary key: studentID + projectID
*/
CREATE TABLE tbStudentProject (
	studentID	Varchar(5)	Not null foreign key REFERENCES tbStudents(stID),
	projectID	Varchar(5)	Not null foreign key REFERENCES tbProjects(pID),
	joinedDate	date		Not null Default GETDATE(),
	rate		tinyint		CHECK(rate BETWEEN	1 AND 5)
	PRIMARY KEY NONCLUSTERED (studentID, projectID) 
)
GO
/*
3. Insert some records to each tbStudents:
Student ID Student Name Age Gender
S01 Tom Hanks 18 1
S02 Phil Collins 18 1
S03 Jennifer Aniston 19 0
S04 Jane Fonda 20 0
S05 Cristiano Ronaldo 24 1
*/
insert tbStudents values
('S01', 'Tom Hanks', 18, 1),
('S02', 'Phil Collins' ,18, 1),
('S03', 'Jennifer Aniston', 19, 0),
('S04', 'Jane Fonda', 20, 0),
('S05' ,'Cristiano Ronaldo', 24, 1)
select * from tbStudents
GO

/*
b. tbProjects
Project ID Project Name Project Type Start Date
P20 Social Network GOV 12/01/2020
P21 React Navtive + NodeJS EDU 22/08/2020
P22 Google Map API DEP 15/10/2019
P23 nCovid Vaccine GOV 16/05/2020
*/
set dateformat dmy
insert tbProjects values
('P20' ,'Social Network', 'GOV' ,'12/01/2020'),
('P21', 'React Navtive + NodeJS' ,'EDU', '22/08/2020'),
('P22' ,'Google Map API' ,'DEP' ,'15/10/2019'),
('P23', 'nCovid Vaccine' ,'GOV', '16/05/2020')
select * from tbProjects
go

/*
c. tbStudentProject
Student ID Project ID Join Date Rate
S01 P20 12/02/2020 4
S01 P21 12/03/2020 5
S02 P20 16/02/2020 3
S02 P22 01/09/2020 5
S04 P21 12/04/2020 4
S04 P22 01/10/2020 3
S04 P20 16/10/2020 3
S03 P23 04/07/2020 5
*/
set dateformat dmy
insert tbStudentProject values
('S01' ,'P20', '12/02/2020', 4),
('S01' ,'P21', '12/03/2020', 5),
('S02' ,'P20', '16/02/2020', 3),
('S02' ,'P22', '01/09/2020', 5),
('S04' ,'P21', '12/04/2020', 4),
('S04' ,'P22', '01/10/2020', 3),
('S04' ,'P20', '16/10/2020', 3),
('S03' ,'P23', '04/07/2020', 5)

select * from tbStudentProject
go


/* 4. 
	Create a clustered index ‘IX_stname’ for  stname column on tbStudents table.
	Create an index ‘IX_pID’ for projectID column on tbStudentProject table
*/
CREATE CLUSTERED INDEX IX_stname ON tbStudents(stname)
GO

CREATE INDEX IX_pID ON tbStudentProject (projectID)
GO

/*
5. Create a view ‘vwStudentProject’ to display the list of students joined to projects had
start-date before ‘Jun-01-2020’, including following information :
StudentID, Student name, Student Age, Project name, Start date, Join date and Rate.
Note: this view will need to check for domain integrity and encryption.
*/
CREATE VIEW vwStudentProject WITH ENCRYPTION
AS
SELECT
	b.stID [student ID], b.stName [student name], b.stAge [student age], 
	c.pName [project name], c.pStartDate [start date], a.joinedDate [join date], a.rate
	   FROM tbStudentProject a JOIN tbStudents b ON a.studentID = b.stID 
                               JOIN tbProjects c ON a.projectID = c.pID
	   WHERE c.pStartDate <= '2020/06/01'
	   WITH CHECK OPTION -- domain integrity
GO

-- test view
select * from vwStudentProject
sp_helptext vwStudentProject
GO

/*
6. Create a stored procedure ‘upRating’ with an input parameter ‘student-name’, and
output parameter ‘avg-rate’
- If ‘student-name’ is null, displays all the projects that all students have worked for
Otherwise, displays information about that students and the corresponding projects
they have joined.
- Procedure also returns the average rate mark (avg-mark) that students joined into
projects.
*/
CREATE PROC upRating
	@avg_rate float output, 
	@studentname varchar(30) = null
AS 
BEGIN
	IF @studentname is NULL
	BEGIN
		SELECT
				b.stID [student ID], b.stName [student name], b.stAge [student age], 
				c.pName [project name], c.pStartDate [start date], a.joinedDate [join date], a.rate
			FROM tbStudentProject a JOIN tbStudents b ON a.studentID = b.stID 
									JOIN tbProjects c ON a.projectID = c.pID

	    -- tinh diem binh quan cua cac du an ma cac sinh vien tham gia
		SELECT @avg_rate = AVG(rate) FROM tbStudentProject
	END
	ELSE
	BEGIN
		SELECT
			b.stID [student ID], b.stName [student name], b.stAge [student age], 
			c.pName [project name], c.pStartDate [start date], a.joinedDate [join date], a.rate
		FROM tbStudentProject a JOIN tbStudents b ON a.studentID = b.stID 
								JOIN tbProjects c ON a.projectID = c.pID
		WHERE b.stName LIKE '%'+ @studentname +'%'

		-- tinh diem binh quan cua cac du an ma sinh vien tham gia
		SELECT @avg_rate = AVG(rate) FROM tbStudentProject a JOIN tbStudents b ON a.studentID=b.stID
			WHERE b.stName LIKE '%'+ @studentname +'%'
	END
END
GO

-- test case 1: ko cung cap ten sinh vien
declare @diemtb float
exec upRating @diemtb output
select @diemtb 'Diem BQ cua cac du an'
go

-- test case 2: xem danh sach cac du an cua sinh vien co ten la Tom
declare @diemtb float 
exec upRating @diemtb output, 'tom'
select @diemtb 'Diem BQ cua cac du an'
go

-- test case 3: xem danh sach cac du an cua sinh vien co ten la fonda
declare @diemtb float 
exec upRating @diemtb output, 'fonda'
select @diemtb 'Diem BQ cua cac du an'
go

select * from tbStudentProject
select avg(rate) from tbStudentProject
select avg(rate*1.0) from tbStudentProject where projectID like 'p20'
GO

/*
7. Create trigger ‘tgDeleteStudent’, it will remove all projects that student have worked
for whenever a DEL statement triggered on table 'tbStudents'.
*/
CREATE TRIGGER tgDeleteStudent ON tbStudents
INSTEAD OF DELETE AS
BEGIN 
	-- xoa cac du an ma sv muon xoa dang tham gia
	DELETE FROM tbStudentProject WHERE studentID IN (SELECT stID FROM deleted)

	-- xoa cac sinh vien can delete ra khoa bang sinh vien
	DELETE FROM tbStudents WHERE stID IN (SELECT stID FROM deleted)
END
GO

-- test case
SELECT * FROM tbStudents
SELECT * FROM tbStudentProject 
DELETE FROM tbStudents WHERE stName LIKE '%fonda'

SELECT * FROM tbStudents
SELECT * FROM tbStudentProject 
GO

-- Good lucks !

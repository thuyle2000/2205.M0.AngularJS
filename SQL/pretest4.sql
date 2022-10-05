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
	stID	varchar(5)	Primary Key,
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
	pID	Varchar(5) not null	Primary Key,
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
	PRIMARY KEY (studentID, projectID)
)
GO

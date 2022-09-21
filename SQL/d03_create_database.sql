--1. tao 1 csdl [dbDemo1] bang cau lenh co ban nhat, su dung cac tham mac dinh cua he thong
CREATE DATABASE dbDemo1
go

/*2. tao csdl [dbDemo2], mo ta chi tiet cac tham so cho tap tin data va log
   - data file: name: dDdemo2, filename: dbDemo2.mdf, size=10M, max size=ko gioi han, kt tang: 50M
   - log file: name: dDdemo2_log, filename: dbDemo2_log.ldf, size=10M, max size=100, kt tang: 60M
*/
CREATE DATABASE dbDemo2
ON Primary
(name='dbDemo2', filename='F:\Data\dbDemo2.mdf', size=10, maxsize=unlimited, filegrowth=50)
LOG ON
(name='dbDemo2_log', filename='F:\Data\dbDemo2_log.ldf', size=10, maxsize=100, filegrowth=60)
GO

/*3.  Demo ve filegroup
 
   tao csdl [dbDemo3], voi cac tham so chi tiet cho tap tin data va log
   - data file: 
       * primary group
		- name: dDdemo3, filename: dbDemo3.mdf, size=10M, max size=ko gioi han, kt tang: 50M
		
	   * demo group
	    - name: dDdemo3_b, filename: dbDemo3_b.ndf, size=8M, max size=ko gioi han
		- name: dDdemo3_c, filename: dbDemo3_c.ndf

   - log file: name: dDdemo3_log, filename: dbDemo3_log.ldf, size=10M, kt tang: 60M
*/
CREATE DATABASE dbDemo3
ON Primary
	(name='dbDemo3', filename='F:\Data\dbDemo3.mdf', size=10, maxsize=unlimited, filegrowth=50),
FILEGROUP Demo
	(name='dbDemo3_b', filename='F:\Data\dbDemo3_b.ndf', size=8, maxsize=unlimited),
	(name='dbDemo3_c', filename='F:\Data\dbDemo3_c.ndf')
LOG ON
	(name='dbDemo3_log', filename='F:\Data\dbDemo3_log.ldf', size=10, filegrowth=60)
GO

-- xoa cac database vua duoc tao ra
USE master
GO
DROP DATABASE dbDemo2
go
DROP DATABASE dbDemo1
go
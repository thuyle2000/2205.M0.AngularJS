USE [master]
GO
/****** Object:  Database [dbExample]    
Script Date: 9/16/2022 11:06:51 AM ******/
CREATE DATABASE [dbExample]
GO

USE [dbExample]
GO

/****** Object:  Table [dbo].[tbBatch]    Script Date: 9/16/2022 11:06:51 AM ******/

CREATE TABLE [dbo].[tbBatch](
	[id] [varchar](10) NOT NULL,
	[course] [varchar](20) NOT NULL,
	[start_date] [date] NULL,
 CONSTRAINT [PK_tbBatch] PRIMARY KEY CLUSTERED ([id])
 ) 
GO

/****** Object:  Table [dbo].[tbExam]    Script Date: 9/16/2022 11:06:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbExam](
	[exam_id] [int] IDENTITY(1,1) NOT NULL,
	[module_id] [varchar](10) NOT NULL,
	[student_id] [varchar](10) NOT NULL,
	[obj_mark] [tinyint] NULL,
	[asm_mark] [tinyint] NULL,
 CONSTRAINT [PK_tbExam] PRIMARY KEY CLUSTERED ( [exam_id] ASC)
) 
GO

/****** Object:  Table [dbo].[tbModule]    
Script Date: 9/16/2022 11:06:52 AM ******/

CREATE TABLE [dbo].[tbModule](
	[id] [varchar](10) NOT NULL,
	[name] [varchar](40) NULL,
	[fee] [int] NOT NULL,
	[hours] [int] NOT NULL,
 CONSTRAINT [PK_tbModule] PRIMARY KEY CLUSTERED ([id] ASC) 
) 
GO

/****** Object:  Table [dbo].[tbStudent]    Script Date: 9/16/2022 11:06:52 AM ******/

CREATE TABLE [dbo].[tbStudent](
	[id] [varchar](10) NOT NULL,
	[name] [varchar](40) NOT NULL,
	[gender] [bit] NULL,
	[birthday] [date] NULL,
	[email] [varchar](40) NOT NULL,
	[tel] [varchar](40) NOT NULL,
	[address] [varchar](40) NULL,
	[leader_id] [varchar](10) NULL,
	[batch_id] [varchar](10) NULL,
 CONSTRAINT [PK_tbStudent] PRIMARY KEY CLUSTERED (	[id]  )
) 
GO

INSERT [dbo].[tbBatch] ([id], [course], [start_date]) VALUES (N'A1.2205.A0', N'Arena 7400', NULL)
INSERT [dbo].[tbBatch] ([id], [course], [start_date]) VALUES (N'T1.2205.M0', N'Aptech 7023', CAST(N'2022-05-11' AS Date))
INSERT [dbo].[tbBatch] ([id], [course], [start_date]) VALUES (N'T1.2205.M1', N'Aptech 7023', CAST(N'2022-05-18' AS Date))



INSERT [dbo].[tbModule] ([id], [name], [fee], [hours]) VALUES (N'AJS', N'AngularJS - Angular2', 100, 20)
INSERT [dbo].[tbModule] ([id], [name], [fee], [hours]) VALUES (N'DDD', N'Database Design & Development', 80, 8)
INSERT [dbo].[tbModule] ([id], [name], [fee], [hours]) VALUES (N'HCJS', N'HTML5 - CSS3 - Javascript', 200, 60)
INSERT [dbo].[tbModule] ([id], [name], [fee], [hours]) VALUES (N'LBEP
', N'Logic Building Elementary Programming', 200, 52)
INSERT [dbo].[tbModule] ([id], [name], [fee], [hours]) VALUES (N'PRJ1', N'eProject Semester 1', 120, 20)



INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S01', N'Nguyen Le Tien Dung', 1, CAST(N'2003-01-03' AS Date), N'dungnguyen@fpt.edu.vn', N'123-345', N'Quan 1', N'S01', N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S02', N'Pham Hung QuocVinh', 1, CAST(N'1997-08-02' AS Date), N'vinhpham@fpt.edu.vn', N'123-455', N'Quan 3', NULL, N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S03', N'Ho thong Vien', 1, CAST(N'2004-05-08' AS Date), N'vienho@fpt.edu.vn', N'120-2345', N'Quan Tan Phu', N'S02', N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S04', N'Ma hoang Thuy Tien', 0, CAST(N'2003-05-02' AS Date), N'tienma@fpt.edu.vn', N'113-786', N'Quan Nha Be', N'S05', N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S05', N'Nguyen Luu Gia Bao', 1, CAST(N'1996-11-21' AS Date), N'baonguyen@fpt.edu.vn', N'120-5678', N'Quan 8', NULL, N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S06', N'Ho Quan', 1, CAST(N'2003-08-03' AS Date), N'quanho@fpt.edu.vn', N'124-8789', N'Quan 7', N'S05', N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S07', N'Ngo Quoc Viet', 1, CAST(N'1996-03-02' AS Date), N'vietngo@fpt.edu.vn', N'133-980', N'Quan 12', NULL, N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S08', N'Luong Thanh Hop', 1, CAST(N'2005-06-09' AS Date), N'hopluong@fpt.edu.vn', N'130-876', N'Quan 12', N'S07', N'T1.2205.M0')
INSERT [dbo].[tbStudent] ([id], [name], [gender], [birthday], [email], [tel], [address], [leader_id], [batch_id]) VALUES (N'S09', N'Phi Quang Duc', 1, CAST(N'1999-10-28' AS Date), N'ducphi@fpt.edu.vn', N'123-564', N'Huyen Binh Chanh', N'S07', N'T1.2205.M1')



ALTER TABLE [dbo].[tbExam]  WITH CHECK ADD  CONSTRAINT [FK_exam_module] FOREIGN KEY([module_id])
REFERENCES [dbo].[tbModule] ([id])
GO

ALTER TABLE [dbo].[tbExam] CHECK CONSTRAINT [FK_exam_module]
GO

ALTER TABLE [dbo].[tbExam]  WITH CHECK ADD  CONSTRAINT [FK_exam_student] FOREIGN KEY([student_id])
REFERENCES [dbo].[tbStudent] ([id])
GO
ALTER TABLE [dbo].[tbExam] CHECK CONSTRAINT [FK_exam_student]
GO

ALTER TABLE [dbo].[tbStudent]  WITH CHECK ADD  CONSTRAINT [FK_Leader] FOREIGN KEY([leader_id])
REFERENCES [dbo].[tbStudent] ([id])
GO
ALTER TABLE [dbo].[tbStudent] CHECK CONSTRAINT [FK_Leader]
GO


ALTER TABLE [dbo].[tbStudent]  WITH CHECK ADD  CONSTRAINT [FK_student_batch] FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbBatch] ([id])
GO

ALTER TABLE [dbo].[tbStudent] CHECK CONSTRAINT [FK_student_batch]
GO




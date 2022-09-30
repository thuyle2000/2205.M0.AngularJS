-- test extended procedure
exec xp_logininfo
GO

exec xp_fileexist 'F:\hoa-lan.jpg'
go

exec xp_fileexist 'F:\student'
go

exec xp_dirtree 'F:\student\2205-M0'
go
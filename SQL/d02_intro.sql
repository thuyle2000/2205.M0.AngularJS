--open database dbExample
use dbExample
go

-- xem danh sach cac mon hoc
select * from tbModule

-- xem danh sach cac mon hoc [co so gio hoc > 40]
select * from tbModule where [hours] > 40


-- xem danh sach cac mon hoc [co so gio hoc tu 20 -> 40]
select * from tbModule 
		 where ([hours] >= 20) and ([hours]<=40)

-- cung cau hoi tren, ap dung vi tu BETWEEN AND
select * from tbModule 
		 where ([hours] between 20 and 40 )

go

-- xem danh sach sinh vien
select * from tbStudent

-- xem danh sach sinh vien, co chua tu 'an' trong phan ho ten (ap dung vi tu LIKE)
select * from tbStudent where [name] like '%an%'

-- xem danh sach sinh vien o quan 7 va quan 12
select * from tbStudent 
	where [address] like 'quan 7' or address like 'quan 12'
-- cung cau hoi tren, ap dung vi tu IN
select * from tbStudent 
	where [address] IN ('quan 7', 'quan 12')

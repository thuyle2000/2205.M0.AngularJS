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


-- xem danh sach sinh vien co ngay sinh nhat trong thang 10
select * from tbStudent where MONTH(birthday) = 10

-- xem ds sinhvien co ngay sinh nhat sap dien ra
select * from tbStudent 
	where MONTH(birthday) >= MONTH(GETDATE())

select id, UPPER(name) student_name, birthday 
	from tbStudent 
	where MONTH(birthday) >= MONTH(GETDATE())

go

-- tao bien chua thang hien tai
declare @thang int
set @thang = MONTH(GETDATE()); -- gan gia tri cho bien @thang
select id, UPPER(name) student_name, birthday 
	from tbStudent 
	where MONTH(birthday) >= @thang
go


-- xem ds sinh vien, bao gom ma so, ho ten , ngay sinh, tuoi, gioi tinh
select  id, [name], birthday, gender from tbStudent

--a. them cot tuoi
select  id, [name], birthday, DATEDIFF(YY, birthday, GETDATE()) [Age], gender 
	from tbStudent

--b. chuyen noi dung cot gender: 1-> male, 0-> female
select  id, [name], birthday, DATEDIFF(YY, birthday, GETDATE()) [Age], 
		case gender
			when 1 then 'male'
			else 'female'
		end [gender]
	from tbStudent;
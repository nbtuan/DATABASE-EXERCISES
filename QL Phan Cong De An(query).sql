
--Kiểm tra trùng tên database:
IF (EXISTS (SELECT * FROM sys.sysdatabases WHERE NAME = 'QLPCDA'))
	DROP DATABASE QLPCDA;

create database QLPCDA

go
use QLPCDA

----Tạo bảng:
create table DEAN
(
	tenDA nvarchar(20),
	maDA char(10) primary key,
	ddiem_DA nvarchar(20),
	phong char(10)
)
GO

create table PHONGBAN
(
	tenPhg nvarchar(20),
	maPhg char(10) primary key,
	trPhg char(10),
	ng_NhanChuc date
)
GO

create table DIADIEM_PHG
(
	maPhg char(10),
	diaDiem nvarchar(20)
	primary key (maPhg, diaDiem)
)
GO

create table NHANVIEN
(
	hoNV nvarchar(10),
	tenLot nvarchar(10),
	tenNV nvarchar(10),
	maNV char(10) primary key,
	ngaySinh date,
	dChi nvarchar(50),
	phai nchar(5) check (phai in ('Nam', N'Nữ')),
	luong float default 0,
	ma_NQL char(10),
	phg char(10)
)
GO

create table THANNHAN
(
	ma_NVien char(10),
	tenTN nvarchar(30),
	phai nchar(5) check (phai in ('Nam', N'Nữ')),
	ngSinh date,
	quanHe nvarchar(20)
	primary key (ma_NVien, tenTN)
)
GO

create table CONGVIEC
(
	maDA char(10),
	stt int,
	ten_Cong_Viec nvarchar(20)
	primary key (maDA, stt)
)
GO

create table PHANCONG
(
	ma_NVien char(10),
	maDA char(10),
	stt int,
	thoigian float
	primary key (ma_NVien, maDA, stt)
)
GO
----Tạo ràng buộc khóa ngoại:

--1. THANNHAN(ma_NVien) -> NHANVIEN(maNV)
alter table THANNHAN
add 
	constraint FK_TN_NV
	foreign key (ma_NVien)
	references NHANVIEN(maNV)
GO
--2. DIADIEM_PHG(maPhg) -> PHONGBAN(maPhg)
alter table DIADIEM_PHG
add 
	constraint FK_DDP_PB
	foreign key (maPhg)
	references PHONGBAN(maPhg)
GO
--3. DEAN(phong) -> PHONGBAN(maPhg)
alter table DEAN
add 
	constraint FK_DA_PB
	foreign key (phong)
	references PHONGBAN(maPhg)
GO
--4. CONGVIEC(maDA) -> DEAN(maDA)
alter table CONGVIEC
add 
	constraint FK_CV_DA
	foreign key (maDA)
	references DEAN(maDA)
GO
--5. PHANCONG(maDA, stt) -> CONGVIEC(maDA, stt)
alter table PHANCONG
add 
	constraint FK_PC_CV
	foreign key (maDA, stt)
	references CONGVIEC(maDA, stt)
GO
--6. PHANCONG(ma_NVien) -> NHANVIEN(maNV)
alter table PHANCONG
add 
	constraint FK_PC_NV
	foreign key (ma_NVien)
	references NHANVIEN(maNV)
GO
--7. NHANVIEN(ma_NQL) -> NHANVIEN(maNV)
alter table NHANVIEN
add 
	constraint FK_NV_NV
	foreign key (ma_NQL)
	references NHANVIEN(maNV)
GO
--8. PHONGBAN(trPhg) -> NHANVIEN(maNV)
alter table PHONGBAN
add 
	constraint FK_PB_NV
	foreign key (trPhg)
	references NHANVIEN(maNV)
GO
--9. NHANVIEN(phg) -> PHONGBAN(maPhg)
alter table NHANVIEN
add 
	constraint FK_NV_PB
	foreign key (phg)
	references PHONGBAN(maPhg)
GO
------------------------------------
----NHẬP LIỆU

--Phg để null, sau đó update:
insert into NHANVIEN values 
(N'Đinh', N'Bá', N'Tiến', '009', '1960-02-11', N'119 Cống Quỳnh, Tp HCM', 'Nam', '30000', '005', null),
(N'Nguyễn', N'Thanh', N'Tùng', '005', '1962-08-20', N'222 Nguyễn Văn Cừ, Tp HCM', 'Nam', '40000', '006', null),
(N'Bùi', N'Ngọc', N'Hằng', '007', '1954-03-11', N'332 Nguyễn Thái Học, Tp HCM', 'Nam', '25000', '001', null),
(N'Lê', N'Quỳnh', N'Như', '001', '1967-02-01', N'291 Hồ Văn Huệ, Tp HCM', N'Nữ', '43000', '006', null),
(N'Nguyễn', N'Mạnh', N'Hùng', '004', '1967-03-04', N'95 Bà Rịa, Vũng Tàu', 'Nam', '38000', '005', null),
(N'Trần', N'Thanh', N'Tâm', '003', '1967-05-04', N'34 Mai Văn Lự, Tp HCM', 'Nam', '25000', '005', null),
(N'Trần', N'Hồng', N'Quang', '008', '1967-09-01', N'80 Lê Hồng Phong, Tp HCM', 'Nam', '25000', '001', null),
(N'Phạm', N'Văn', N'Vinh', '006', '1965-01-01', N'45 Trưng Vương, Hà Nội', N'Nữ', '55000', null, null)
GO

insert into THANNHAN values
('005', N'Trinh', N'Nữ', '1976-04-05', N'Con gái'),
('005', N'Khang', N'Nam', '1973-10-25', N'Con trai'),
('005', N'Phương', N'Nữ', '1948-05-03', N'Vợ chồng'),
('001', N'Minh', N'Nam', '1932-02-29', N'Vợ chồng'),
('009', N'Tiên', N'Nam', '1978-01-01', N'Con trai'),
('009', N'Châu', N'Nữ', '1978-12-30', N'Con gái'),
('009', N'Phương', N'Nữ', '1957-05-05', N'Vợ chồng')
GO

insert into PHONGBAN values
(N'Nghiên cứu', '5', '005', '1978-05-22'),
(N'Điều hành', '4', '008', '1985-01-01'),
(N'Quản lý', '1', '006', '1971-06-19')
GO

update NHANVIEN
set phg = '5' where maNV in ('009', '005', '004', '003')
update NHANVIEN
set phg = '4' where maNV in ('007', '001', '008')
update NHANVIEN
set phg = '1' where maNV = '006'
GO

insert into DIADIEM_PHG values
('1', N'TP HCM'),
('4', N'Hà Nội'),
('5', N'TAU'),
('5', N'NHA TRANG'),
('5', N'TP HCM')
GO

insert into DEAN values
('San pham X', '1', N'Vũng Tàu', '5'),
('San pham Y', '2', N'Nha Trang', '5'),
('San pham Z', '3', N'TP HCM', '5'),
('Tin hoc hoa', '10', N'Hà Nội', '4'),
('Cap quang', '20', N'TP HCM', '1'),
('Dao tao', '30', N'Hà Nội', '4')
GO

insert into CONGVIEC values
('1', 1, 'Thiet ke SP X'),
('1', 2, 'Thu nghiem SP X'),
('2', 1, 'San xuat SP Y'),
('2', 2, 'Quang cao SP Y'),
('3', 1, 'Khuyen mai SP Z'),
('10', 1, 'THH NS tien luong'),
('10', 2, 'THH phong KD'),
('20', 1, 'Lap dat cap quang'),
('30', 1, 'DT NV Marketing'),
('30', 2, 'DT CV thiet ke')
GO

insert into PHANCONG values
('009', '1', 1, 32),
('009', '2', 2, 8),
('004', '3', 1, 40),
('003', '1', 2, 20.0),
('003', '2', 1, 20.0),
('008', '10', 1, 35),
('008', '30', 2, 5),
('001', '30', 1, 20),
('001', '20', 1, 15),
('006', '20', 1, 30),
('005', '3', 1, 10),
('005', '10', 2, 10),
('005', '20', 1, 10),
('007', '30', 2, 30),
('007', '10', 2, 10)
GO
------------------------------------------------------
----TRUY VẤN Q1 -> Q14:
--1. Cho ds nhân viên gồm họ tên, phái.
select hoNV + ' ' + tenLot + ' ' + tenNV as N'Họ Tên', phai
from NHANVIEN

--2. Cho ds nhân viên thuộc phòng số 5.
select * 
from NHANVIEN
where phg = '5'

--3. Cho ds nhân viên gồm mã nv, họ tên, phái của các nv thuộc phòng số 5
select maNV, hoNV + ' ' + tenLot + ' ' + tenNV as 'hoten', phai
from NHANVIEN
where phg = '5'

--4. Danh sách họ tên, phái của các nhân viên thuộc phòng nghiên cứu
select nv.hoNV + ' ' + nv.tenLot + ' ' + nv.tenNV as 'hoten', nv.phai
from NHANVIEN nv join PHONGBAN pb on nv.phg = pb.maPhg
where pb.tenPhg = N'Nghiên cứu'

--5. Cho ds các mã nhân viên có tham gia đề án số 4 hoặc 5
select distinct ma_NVien
from PHANCONG
where maDA in ('1', '2')
--where maDA in ('4', '5')

select * from PHANCONG

--6. Cho ds các mã nhân viên vừa có tham gia đề án số 4 vừa số 5.
select ma_NVien
from PHANCONG
where maDA = '1'
intersect
select ma_NVien
from PHANCONG
where maDA = '2'

--7. Cho ds các mã nhân viên có tham gia đề án 4 mà ko tham gia đề án 5
select ma_NVien
from PHANCONG
where maDA = '3'
except
select ma_NVien
from PHANCONG
where maDA = '2'

--8. Cho biết danh sách thể hiện mọi nhân viên đều tham gia tất cả các đề án.
--em chưa hiểu đề lắm, em nghĩ là select các maNV không có tham gia đề án 
-- nếu 'không có' nghĩa là 'ai cũng tham gia đề án'.
select maNV from NHANVIEN
except 
select ma_NVien from PHANCONG

--9. Cho ds các nhân viên và thông tin phòng ban mà nhân viên đó trực thuộc.
--(maNV, hoten, mã phòng, tên phòng)
select nv.maNV, nv.hoNV + ' ' + nv.tenLot + ' ' + nv.tenNV as 'hoten',
pb.maPhg, pb.tenPhg
from NHANVIEN nv, PHONGBAN pb
where nv.phg = pb.maPhg

--10. Cho ds các phòng ban và địa điểm phòng ban (mã pb, tên pb, địa điểm)
select pb.maPhg, pb.tenPhg, ddpb.diaDiem
from PHONGBAN pb join DIADIEM_PHG ddpb on pb.maPhg = ddpb.maPhg

--11. Cho danh sách các nhân viên thuộc phòng 'Nghiên cứu'
select nv.*
from NHANVIEN nv, PHONGBAN pb
where nv.phg = pb.maPhg and pb.tenPhg = N'Nghiên cứu'

--12. Đối với từng nv, cho biết họ tên, ngày sinh và tên của nv phụ trách trực tiếp.
select nv.maNV, nv.hoNV + ' ' + nv.tenLot + ' ' + nv.tenNV as 'hoten',
nql.ngaySinh, nql.hoNV + ' ' + nql.tenLot + ' ' + nql.tenNV as 'hotenNQL'
from NHANVIEN nv, NHANVIEN nql
where nv.ma_NQL = nql.maNV

--13. Ds nv thuộc phòng số 5 có tham gia đề án tên là 'San pham X'
select nv.*
from NHANVIEN nv, PHANCONG pc, DEAN da
where nv.phg = '5' and nv.maNV = pc.ma_NVien 
and pc.maDA = da.maDA and da.tenDA = 'San pham X'

--14. Tương tự 5, thuộc phòng 'Nghiên cứu' có tham gia đề án tên 'San pham X'
select nv.*
from NHANVIEN nv, PHONGBAN pb, PHANCONG pc, DEAN da
where nv.phg = pb.maPhg and pb.tenPhg =  N'Nghiên cứu'
and nv.maNV = pc.ma_NVien 
and pc.maDA = da.maDA and da.tenDA = 'San pham X'
GO

USE QLPCDA
GO

--15. Cho biết có tất cả bao nhiêu nhân viên
select count(*) as N'Số lượng nhân viên'
from NHANVIEN

--16. Cho biết mỗi phòng ban có bao nhiêu nhân viên (MAPB, TENPB, SLNV)
select pb.maPhg, pb.tenPhg, count(nv.maNV) as N'Số lượng nhân viên'
from NHANVIEN nv, PHONGBAN pb
where nv.phg = pb.maPhg
group by pb.maPhg, pb.tenPhg

--17. Cho biết tổng lương, số lượng nhân viên, lương trung bình, 
--lương bé nhất trong toàn công ty.
select sum(nv.luong) N'Tổng lương', count(nv.maNV) as N'Số lượng nhân viên', 
avg(nv.luong) as N'Lương trung bình', min(luong) as 'Lương bé nhất'
from NHANVIEN nv

--18. Danh sách nhân viên có tham gia đề án.
select distinct pc.ma_NVien, nv.hoNV + ' ' + nv.tenLot + ' ' + nv.tenNV as N'Họ Tên'
from NHANVIEN nv, PHANCONG pc
where pc.ma_NVien = nv.maNV

--19. Danh sách nhân viên không có tham gia đề án nào.
select nv.maNV, nv.hoNV + ' ' + nv.tenLot + ' ' + nv.tenNV as N'Họ Tên'
from NHANVIEN nv
where nv.maNV not in (select ma_NVien from PHANCONG)

--20. Mỗi nhân viên tham gia bao nhiêu đề án với tổng thời gian là bao nhiêu?
select pc.ma_NVien, nv.hoNV + ' ' + nv.tenLot + ' ' + nv.tenNV as N'Họ Tên',
count(pc.maDA) as N'Số lượng đề án tham gia', sum(pc.thoigian) as N'Tổng thời gian'
from NHANVIEN nv, PHANCONG pc
where nv.maNV = pc.ma_NVien
group by pc.ma_NVien, nv.hoNV + ' ' + nv.tenLot + ' ' + nv.tenNV

select * from PHANCONG
--21. Danh sách nhân viên có tham gia đề án tên 'Sản phẩm X' hoặc 'Sản phẩm Y'
select maNV, hoNV + ' ' + tenLot + ' ' + tenNV as N'Họ Tên'
from NHANVIEN
where maNV in 
(select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA = 'San pham X'
union
select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA = 'San pham Y')

--22. Danh sách nhân viên có tham gia đề án tên 'Sản phẩm X' và 'Sản phẩm Y'
select maNV, hoNV + ' ' + tenLot + ' ' + tenNV as N'Họ Tên'
from NHANVIEN
where maNV in 
(select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA = 'San pham X'
intersect
select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA = 'San pham Y')

select * from PHANCONG
select * from DEAN
--23. Danh sách nhân viên có tham gia đề án tên 'Sản phẩm X' mà không tham gia 'Sản phẩm Y'
select maNV, hoNV + ' ' + tenLot + ' ' + tenNV as N'Họ Tên'
from NHANVIEN
where maNV in 
(select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA = 'San pham X'
except
select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA = 'San pham Y')

--24. Danh sách nhân viên chỉ có tham gia đề án tên 'Sản phẩm X'
(select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA = 'San pham X')
except
(select pc.ma_NVien from PHANCONG pc, DEAN da
where pc.maDA = da.maDA and da.tenDA != 'San pham X')

--25. Danh sách các đề án chỉ do các nhân viên thuộc phòng "Nghiên cứu" thực hiện.
(select distinct pc.maDA, da.tenDA
from NHANVIEN nv, PHONGBAN pb, PHANCONG pc, DEAN da
where nv.maNV = pc.ma_NVien and nv.phg = pb.maPhg
and da.maDA = pc.maDA and pb.tenPhg = N'Nghiên cứu')
except
(select distinct pc.maDA, da.tenDA
from NHANVIEN nv, PHONGBAN pb, PHANCONG pc, DEAN da
where nv.maNV = pc.ma_NVien and nv.phg = pb.maPhg
and da.maDA = pc.maDA and pb.tenPhg != N'Nghiên cứu')

select * from PHONGBAN
select * from NHANVIEN
select * from PHANCONG
--26. Danh sách nhân viên có tham gia tất cả các đề án
--Phép chia
select distinct pc.ma_NVien, hoNV + ' ' + tenLot + ' ' + tenNV as N'Họ Tên'
from NHANVIEN nv, PHANCONG pc
where pc.ma_NVien = nv.maNV
and not exists
(select * from DEAN da
where not exists
(select * from PHANCONG pc2 where pc2.ma_NVien = pc.ma_NVien and pc2.maDA = da.maDA))

--Thêm để test:
select * from CONGVIEC
select * from PHANCONG

insert into CONGVIEC
values ('1', '3', 'TEST_Q26'),
('2', '3', 'TEST_Q26'),
('30', '3', 'TEST_Q26')

insert into PHANCONG
values ('005', '1', '3', '10'),
('005', '2', '3', '10'),
('005', '30', '3', '10')
--Q27. Danh sách nhân viên thuộc phòng nghiên cứu có tham gia tất cả các đề án do phòng
--số 5 chủ trì:
--Phép chia
select distinct pc.ma_NVien, hoNV + ' ' + tenLot + ' ' + tenNV as N'Họ Tên'
from NHANVIEN nv, PHONGBAN pb, PHANCONG pc
where pc.ma_NVien = nv.maNV and nv.phg = pb.maPhg and pb.tenPhg = N'Nghiên cứu'
and not exists
(select * from DEAN da
where da.phong = '5' and not exists
(select * from PHANCONG pc2 where pc2.ma_NVien = pc.ma_NVien and pc2.maDA = da.maDA))

--Q28. Cho biết lương trung bình của các phòng ban (mã, tên, lươngtb)
select nv.phg, pb.tenPhg, avg(nv.luong) as N'LƯƠNG TRUNG BÌNH'
from NHANVIEN nv, PHONGBAN pb
where nv.phg = pb.maPhg
group by nv.phg, pb.tenPhg

--Q29. Cho biết các phòng ban có lương trung bình > 25000 (mã, tên, lươngtb)
select nv.phg, pb.tenPhg, avg(nv.luong) as N'LƯƠNG TRUNG BÌNH'
from NHANVIEN nv, PHONGBAN pb
where nv.phg = pb.maPhg
group by nv.phg, pb.tenPhg
having avg(nv.luong) > 25000

--Q30. Cho biết các phòng ban có chủ trì đề án có số nhân viên > 3 và
--có lương trung bình > 25000.
select nv.phg, pb.tenPhg, count(distinct nv.maNV) as N'SỐ LƯỢNG NHÂN VIÊN', 
avg(nv.luong) as N'LƯƠNG TRUNG BÌNH'
from NHANVIEN nv, PHONGBAN pb, DEAN da
where nv.phg = pb.maPhg and da.phong = pb.maPhg
group by nv.phg, pb.tenPhg
having count(distinct nv.maNV) > 3 and avg(nv.luong) > 25000

--Q31. Cho biết nhân viên nào có lương cao nhất trong từng phòng ban
select nv.phg, pb.tenPhg, max(nv.luong) as N'LƯƠNG CAO NHẤT'
from NHANVIEN nv, PHONGBAN pb
where pb.maPhg = nv.phg 
group by nv.phg, pb.tenPhg

--Q32. Cho biết phòng ban nào có lương trung bình cao nhất.
select nv.phg, pb.tenPhg, avg(nv.luong) as N'LƯƠNGTB CAO NHẤT'
from NHANVIEN nv, PHONGBAN pb
where pb.maPhg = nv.phg 
group by nv.phg, pb.tenPhg
having avg(nv.luong) >= all (select avg(luong) from NHANVIEN group by phg)

--Q33. Cho biết phòng ban nào có ít nhân viên nhất.
select nv.phg, pb.tenPhg, count(nv.maNV) as N'Số lượng nhân viên'
from NHANVIEN nv, PHONGBAN pb
where pb.maPhg = nv.phg 
group by nv.phg, pb.tenPhg
having count(nv.maNV) <= all (select count(*) from NHANVIEN group by phg)

--Q34. Cho biết phòng ban nào có đông nhân viên nữ nhất.
select nv.phg, pb.tenPhg, count(nv.maNV) as N'Số lượng nhân viên nữ'
from NHANVIEN nv, PHONGBAN pb
where pb.maPhg = nv.phg and nv.phai = N'Nữ'
group by nv.phg, pb.tenPhg
having count(nv.maNV) >= all (select count(*) from NHANVIEN where phai = N'Nữ' group by phg)

----Insert để test:
--insert into NHANVIEN
--values(N'Tiểu', null, N'Kiều', '002', '2006-10-20', N'129/26 Nguyễn Trãi, Q5, TP.HCM', N'Nữ', '10000', '009', '4')

--Q35. Danh sách mã, tên của các phòng ban có chủ trì đề án tên là 'SPX' lẫn 'SPY'
select da.phong, pb.tenPhg
from DEAN da, PHONGBAN pb
where da.phong = pb.maPhg and da.tenDA = 'San pham X'
intersect
select da.phong, pb.tenPhg
from DEAN da, PHONGBAN pb
where da.phong = pb.maPhg and da.tenDA = 'San pham Y'

--Q36. Danh sách mã, tên của các phòng ban có chủ trì đề án tên là 'SPX'
select da.phong, pb.tenPhg
from DEAN da, PHONGBAN pb
where da.phong = pb.maPhg and da.tenDA = 'San pham X'
except
select da.phong, pb.tenPhg
from DEAN da, PHONGBAN pb
where da.phong = pb.maPhg and da.tenDA = 'San pham Y'

--Q37. Phân công cho các nhân viên thuộc phòng số 5 tham gia đề án số 10 mỗi người tham gia 10h
insert into CONGVIEC
values 
('10', '3', 'Business Analysis'),
('10', '4', 'Business Analysis'),
('10', '5', 'Business Analysis'),
('10', '6', 'Business Analysis')
GO

insert into PHANCONG
values 
('003', '10', '3', '10'),
('004', '10', '3', '10'),
('005', '10', '3', '10'),
('009', '10', '3', '10')
GO

--TEST: Cho biết đề án mà tất cả nhân viên phòng 5 tham gia.
select distinct pc.maDA, da.tenDA
from PHANCONG pc, DEAN da
where pc.maDA = da.maDA
and not exists
(select * from NHANVIEN nv where nv.phg = '5'
and not exists
(select * from PHANCONG pc2
where pc2.maDA = pc.maDA and pc2.ma_NVien = nv.maNV))

--Q38. Xóa tất cả những phân công liên quan đến nhân viên mã là 10.
delete from PHANCONG 
where ma_NVien = '10'

--Q39. Xóa tất cả những phân công liên quan đến nhân viên mã là 10 và đề án mã là 20.
delete from PHANCONG 
where ma_NVien = '10' and maDA = '20'

--Q40. Tăng 10% giờ tham gia đề án của nhân viên đã tham gia đề án số 10.
update PHANCONG
set thoigian = thoigian * 1.1
where ma_NVien in (select ma_NVien from PHANCONG where maDA = '10')

--Q41. Giảm 15% giờ tham gia đề án của các nhân viên thuộc phòng 'Nghiên cứu' 
--đã tham gia đề án số 10.
update PHANCONG
set thoigian = thoigian * 0.85
where 
ma_NVien in (select nv.maNV from NHANVIEN nv, PHONGBAN pb 
where nv.phg = pb.maPhg and pb.tenPhg = N'Nghiên cứu')
and ma_NVien in (select ma_NVien from PHANCONG where maDA = '10')

--Q42. Cho biết mỗi phòng ban định vị ở bao nhiêu nơi.
select ddp.maPhg, pb.tenPhg, count(ddp.diaDiem) as N'SỐ LƯỢNG ĐỊA ĐIỂM'
from DIADIEM_PHG ddp, PHONGBAN pb
where ddp.maPhg = pb.maPhg
group by ddp.maPhg, pb.tenPhg

--Q43. Cho biết những phòng ban định vị ở nhiều nơi.
select ddp.maPhg, pb.tenPhg, count(ddp.diaDiem) as N'SỐ LƯỢNG ĐỊA ĐIỂM'
from DIADIEM_PHG ddp, PHONGBAN pb
where ddp.maPhg = pb.maPhg
group by ddp.maPhg, pb.tenPhg
having count(ddp.diaDiem) > 1

--Q44. Danh sách các nhân viên đã tham gia nhiều hơn 3 đề án.
select pc.ma_NVien, hoNV + ' ' + tenLot + ' ' + tenNV as N'Họ Tên', 
count(pc.maDA) as N'SỐ LƯỢNG ĐỀ ÁN THAM GIA'
from PHANCONG pc, NHANVIEN nv
where pc.ma_NVien = nv.maNV
group by pc.ma_NVien, hoNV + ' ' + tenLot + ' ' + tenNV
having count(pc.maDA) > 3

--Q45. Cho biết các đề án có nhiều hơn 5 nhân viên tham gia
select pc.maDA, da.tenDA, count(pc.ma_NVien) as N'SỐ LƯỢNG NHÂN VIÊN THAM GIA'
from PHANCONG pc, DEAN da
where pc.maDA = da.maDA
group by pc.maDA, da.tenDA
having count(pc.ma_NVien) > 5

select * from PHANCONG
select * from DEAN
select * from PHONGBAN
select * from NHANVIEN
select * from CONGVIEC

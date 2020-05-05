
create database QUANLYCHUYENBAY

go
use QUANLYCHUYENBAY


--Tạo bảng
create table KHACHHANG
(
	maKH char(15) primary key,
	ten nvarchar(15),
	dChi nvarchar(50),
	dThoai char(12)
)

create table NHANVIEN
(
	maNV char(15) primary key,
	ten nvarchar(15),
	dChi nvarchar(50),
	dThoai char(12),
	luong float default 10.2,
	loaiNV bit check (loainv in ('1', '0'))
)

create table LOAIMB
(
	maLoai char(15) primary key,
	hangSX char(15)
)

create table MAYBAY
(
	soHieu int,
	maLoai char(15)
	primary key (soHieu,maLoai)
)

create table CHUYENBAY
(
	maCB char(4) primary key,
	sbDi char(3),
	sbDen char(3),
	gioDi time,
	gioDen time
)

create table LICHBAY
(
	ngayDi date,
	maCB char(4),
	soHieu int,
	maLoai char(15)
	primary key(ngayDi, maCB)
)

create table DATCHO
(
	maKH char(15),
	ngayDi date,
	maCB char(4)
	primary key(maKH, ngayDi, maCB)
)

create table KHANANG
(
	maNV char(15),
	maLoai char(15)
	primary key(maNV, maLoai)
)

create table PHANCONG
(
	maNV char(15),
	ngayDi date,
	maCB char(4)
	primary key(maNV, ngayDi, maCB)
)

--Tạo khóa ngoại cho các bảng:
--1. DATCHO(maKH) -> KHACHHANG(maKH)
go
alter table DATCHO
add constraint FK_DC_KH
foreign key (maKH)
references KHACHHANG(maKH)

--2. DATCHO(ngayDi, maCB) -> LICHBAY(ngayDi, maCB)
go
alter table DATCHO
add constraint FK_DC_LB
foreign key (ngayDi, maCB)
references LICHBAY(ngayDi, maCB)

--3. PHANCONG(maNV) -> NHANVIEN(maNV)
go
alter table PHANCONG
add constraint FK_PC_NV
foreign key (maNV)
references NHANVIEN(maNV)

--4. PHANCONG(ngayDi, maCB) -> LICHBAY(ngayDi, maCB)
go
alter table PHANCONG
add constraint FK_PC_LB
foreign key (ngayDi, maCB)
references LICHBAY(ngayDi, maCB)

--5. KHANANG(maNV) -> NHANVIEN(maNV)
go
alter table KHANANG
add constraint FK_KN_NV
foreign key (maNV)
references NHANVIEN(maNV)

--6. KHANANG(maLoai) -> LOAIMB(maLoai)
go
alter table KHANANG
add constraint FK_KN_LMB
foreign key (maLoai)
references LOAIMB(maLoai)

--7. LICHBAY(maCB) -> CHUYENBAY(maCB)
go
alter table LICHBAY
add constraint FK_LB_CB
foreign key (maCB)
references CHUYENBAY(maCB)

--8. LICHBAY(soHieu, maLoai) -> MAYBAY(soHieu, maLoai)
go
alter table LICHBAY
add constraint FK_LB_MB
foreign key (soHieu, maLoai)
references MAYBAY(soHieu, maLoai)

--9. MAYBAY(maLoai) -> LOAIMB(maLoai)
go
alter table MAYBAY
add constraint FK_MB_LMB
foreign key (maLoai)
references LOAIMB (maLoai)

--INSERT VALUES
INSERT INTO NHANVIEN
VALUES
	('1006','Chi ','12/6 Nguyen Kiem ','8120012','150000','0'),
	('1005','Giao ','65 Nguyen Thai Son ','8324467','500000','0'),
	('1001','Huong ','8 Dien Bien Phu ','8330733','500000','1'),
	('1002','Phong ','1 Ly Thuong Kiet ','8308117','450000','1'),
	('1004','Phuong ','351 Lac Long Quan ','8308155','250000','0'),
	('1003','Quang ','78 Truong Dinh ','8324461','350000','1'),
	('1007','Tam ','36 Nguyen Van Cu ','8458188','500000','0')

INSERT INTO KHACHHANG
VALUES
	('0009','Nga','223 Nguyen Trai','8932320'),
	('0101','Anh','567 Tran Phu','8826729'),
	('0045','Thu','285 Le Loi','8932203'),
	('0012','Ha','435 Quang Trung','8933232'),
	('0238','Hung','456 Pasteur','9812101'),
	('0397','Thanh','234 Le Van Si','8952943'),
	('0582','Mai','789 Nguyen Du','Null'),
	('0934','Minh','678 Le Lai','Null'),
	('0091','Hai','345 Hung Vuong','8893223'),
	('0314','Phuong','395 Vo Van Tan','8232320'),
	('0613','Vu','348 CMT8','8343232'),
	('0586','Son','123 Bach Dang','8556223'),
	('0422','Tien','75 Nguyen Thong','8332222')

INSERT INTO LOAIMB(HANGSX,MALOAI)
VALUES
	('Airbus','A310'),
	('Airbus','A320'),
	('Airbus','A330'),
	('Airbus','A340'),
	('Boeing','B727'),
	('Boeing','B747'),
	('Boeing','B757'),
	('MD','DC10'),
	('MD','DC9')

INSERT INTO MAYBAY
VALUES
	('10','B747'),
	('11','B727'),
	('13','B727'),
	('13','B747'),
	('21','DC10'),
	('21','DC9'),
	('22','B757'),
	('22','DC9'),
	('23','DC9'),
	('24','DC9'),
	('70','A310'),
	('80','A310'),
	('93','B757')

INSERT INTO KHANANG
VALUES
	('1001','B727'),
	('1001','B747'),
	('1001','DC10'),
	('1001','DC9'),
	('1002','A320'),
	('1002','A340'),
	('1002','B757'),
	('1002','DC9'),
	('1003','A310'),
	('1003','DC9')

INSERT INTO CHUYENBAY
VALUES
	('100','SLC ','BOS ','8:00','17:50'),
	('112','DCA ','DEN ','14:00','18:07'),
	('121','STL ','SLC ','7:00','9:13'),
	('206','DFW ','STL ','9:00','11:40'),
	('330','JFK ','YYV ','16:00','18:53'),
	('334','ORD ','MIA ','12:00','14:14'),
	('335','MIA ','ORD ','15:00','17:14'),
	('336','ORD ','MIA ','18:00','20:14'),
	('337','MIA ','ORD ','20:30','23:53'),
	('394','DFW ','MIA ','19:00','21:30'),
	('395','MIA ','DFW ','21:00','23:43'),
	('449','CDG ','DEN ','10:00','19:29'),
	('930','YYV ','DCA ','13:00','16:10'),
	('931','DCA ','YYV ','17:00','18:10'),
	('932','DCA ','YYV ','18:00','19:10'),
	('991','BOS ','ORD ','17:00','18:22')

INSERT INTO LICHBAY
VALUES
	('11/01/2000','100','80','A310'),
	('11/01/2000','112','21','DC10'),
	('11/01/2000','206','22','DC9'),
	('11/01/2000','334','10','B747'),
	('11/01/2000','395','23','DC9'),
	('11/01/2000','991','22','B757'),
	('11/01/2000','337','10','B747'),
	('10/31/2000','100','11','B727'),
	('10/31/2000','112','11','B727'),
	('10/31/2000','206','13','B727'),
	('10/31/2000','334','10','B747'),
	('10/31/2000','335','10','B747'),
	('10/31/2000','337','24','DC9'),
	('10/31/2000','449','70','A310')
	
INSERT INTO	PHANCONG
VALUES
	('1001','11/01/2000','100'),
	('1001','10/31/2000','100'),
	('1002','11/01/2000','100'),
	('1002','10/31/2000','100'),
	('1003','10/31/2000','100'),
	('1003','10/31/2000','337'),
	('1004','10/31/2000','100'),
	('1004','10/31/2000','337'),
	('1005','10/31/2000','337'),
	('1006','11/01/2000','991'),
	('1006','10/31/2000','337'),
	('1007','11/01/2000','112'),
	('1007','11/01/2000','991'),
	('1007','10/31/2000','206')

INSERT INTO DATCHO
VALUES
	('0009','11/01/2000','100'),
	('0009','10/31/2000','449'),
	('0045','11/01/2000','991'),
	('0012','10/31/2000','206'),
	('0238','10/31/2000','334'),
	('0582','11/01/2000','991'),
	('0091','11/01/2000','100'),
	('0314','10/31/2000','449'),
	('0613','11/01/2000','100'),
	('0586','11/01/2000','991'),
	('0586','10/31/2000','100'),
	('0422','10/31/2000','449')


----------------------------------------------------------
go
use QUANLYCHUYENBAY

------------------------------
----1. TRUY VẤN CƠ BẢN

--Q1: Cho biết mã số, tên phi công, địa chỉ, điện thoại của các phi công
--từng lái máy bay loại B747.
select phicong.maNV, phicong.ten, phicong.dChi, phicong.dThoai
from NHANVIEN phicong
where phicong.loaiNV = '1' 
and phicong.maNV in 
	(select maNV 
	from PHANCONG pc, LICHBAY lb
	where pc.maCB = lb.maCB and pc.ngayDi < GETDATE()
	and lb.maLoai = 'B747')

--Q2. Cho biết maso và ngayDi của các chuyến bay xuất phát từ sân bay
--DCA trong khoảng thời gian từ 14h->18h.
select cb.maCB, lb.ngayDi
from LICHBAY lb, CHUYENBAY cb
where lb.maCB = cb.maCB 
and cb.sbDi = 'DCA' and cb.gioDi >= '14:00' and cb.gioDi <= '18:00'

--Q3. Cho biết tên những nhân viên được phân công trên
--chuyến bay có mã số 100 xuất phạt tai sân bay SLC. Ko trùng lắp
--thông tin khi xuất ra.
select distinct nv.ten
from NHANVIEN nv, PHANCONG pc, CHUYENBAY cb
where nv.maNV = pc.maNV and pc.maCB = cb.maCB
and cb.maCB = '100' and cb.sbDi = 'SLC'

--Q4. Cho biết mã loại và số hiệu máy bay đã từng xuất phát tại sân bay
--MIA. Các dòng dữ liệu không đc trùng lắp.
select distinct maLoai, soHieu
from LICHBAY
where maCB in (select maCB from CHUYENBAY where sbDi = 'MIA')

--Q5. Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại,
--của tất cả các hành khách đi trên chuyến bay đó. Sắp xếp thoe thứ tự
--tăng dần của mã chuyến bay và theo ngày đi giảm dần:
select dc.maCB, dc.ngayDi, kh.ten, kh.dChi, kh.dThoai
from DATCHO dc, KHACHHANG kh
where dc.maKH = kh.maKH
order by maCB asc, ngayDi desc

--Q6. Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại
--của tất cả những nhân viên được phân công trong chuyến bay đó.
--Sắp sếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần
select distinct pc.maCB, lb.ngayDi, nv.ten, nv.dChi, nv.dThoai
from PHANCONG pc, NHANVIEN nv, LICHBAY lb
where pc.maNV = nv.maNV and pc.maCB = lb.maCB
order by pc.maCB asc, lb.ngayDi desc

--Q7. Cho biết mã chuyến bay, ngày đi, mã số & tên của những phi công
--được phân công vào chuyến bay hạn cánh xuống sb ORD.
select cb.maCB, pc.ngayDi, phicong.maNV, phicong.ten
from NHANVIEN phicong, PHANCONG pc, CHUYENBAY cb
where phicong.loaiNV = '1' and
phicong.maNV = pc.maNV and pc.maCB = cb.maCB
and cb.sbDen = 'ORD'

--Q8. Cho biết các chuyến bay (macb, ngayDi & tên phi công)
--trong đó phi công có mã 1001 được phân công lái.
select pc.maCB, pc.ngayDi, phicong.ten
from PHANCONG pc, NHANVIEN phicong
where phicong.loaiNV = '1' and pc.maNV = '1001'
and pc.maNV = phicong.maNV

--Q9. Cho biết thông tin (mãcb, sân bay đi, giờ đi, giờ đến, ngày đi
--của những chuyến bay hạ cánh xuống DEN. Các chuyến bay được liệt kê theo
--ngày đi giảm dần và sân bay xuất phát (sbDi) tăng dần.

select cb.maCB, cb.sbDi, cb.gioDi, cb.gioDen, lb.ngayDi
from CHUYENBAY cb, LICHBAY lb
where cb.maCB = lb.maCB and cb.sbDen = 'DEN'
order by lb.ngayDi desc, cb.sbDi asc

--Q10. Với mỗi phi công, cho biết hãng sản xuất và mã loại máy bay
--mà phi công này có khả năng bay được. Xuất ra tên phi công, hãng sx
--và mã loại máy bay.
select distinct phicong.ten, lmb.hangSX, lmb.hangSX
from NHANVIEN phicong, KHANANG kn, LOAIMB lmb
where phicong.loaiNV = '1' and phicong.maNV = kn.maNV
and kn.maLoai = lmb.maLoai

--Q11. Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay
--mã số 100 vào ngày 11/01/2000.
select phicong.maNV, phicong.ten
from NHANVIEN phicong, PHANCONG pc
where phicong.loaiNV = '1' and pc.maNV = phicong.maNV 
and pc.maCB = '100' and pc.ngayDi = '2000-11-01'

--Q12. Cho biết mãcb, mãnv, tênnv được phân công vào cb xuất phát ngày
--10/31/2000 tại sân bay MIA vào lúc 20:30
select cb.maCB, nv.maNV, nv.ten
from NHANVIEN nv, PHANCONG pc, CHUYENBAY cb
where pc.maNV = nv.maNV and pc.maCB = cb.maCB
and pc.ngayDi = '2000-10-31' and cb.sbDi = 'MIA'
and cb.gioDi = '20:30'

--Q13. Cho biết thông tin về chuyến bay (mãcb, số hiệu, mã loại, hãng sx)
--mà phi công 'Quang' đã lái
select pc.maCB, lb.soHieu, lb.maLoai, lmb.hangSX
from NHANVIEN phicong, PHANCONG pc, LICHBAY lb, LOAIMB lmb
where phicong.ten = 'Quang' and pc.maNV = phicong.maNV
and pc.maCB = lb.maCB and lb.maLoai = lmb.maLoai

--Q14. Cho biết tên những phi công chưa được phân công lái chuyến bay nào:
select ten
from NHANVIEN phicong
where phicong.loaiNV = '1'
and phicong.maNV not in (select maNV from PHANCONG)

--Q15. Cho biết tên KH đã đi chuyến bay trên mb của hãng 'Boeing'
select distinct kh.ten
from KHACHHANG kh, DATCHO dc, LICHBAY lb, LOAIMB lmb
where kh.maKH = dc.maKH and dc.ngayDi = lb.ngayDi
and dc.maCB = lb.maCB and lb.maLoai = lmb.maLoai
and lmb.hangSX = 'Boeing'

--Q16. Cho biết mã các chuyến bay chỉ bay với máy bay số hiệu 10 &
--mã loại B747
select distinct cb.maCB
from CHUYENBAY cb, LICHBAY lb
where cb.maCB = lb.maCB and lb.soHieu = 10 and lb.maLoai = 'B747'

------------------------
----GOM NHÓM + HÀM

--Q17. Với mỗi sân bay (sbDen), cho biết số lượng chuyến bay hạ cánh xuống
--sân bay đó. Kết quả được sắp xếp thoe thứ tự tăng dần của sân bay đến.
select sbDen, count(maCB) as N'SLCB hạ cánh'
from CHUYENBAY
group by sbDen
order by sbDen

--Q18. Với mỗi sân bay (sbDi), cho biết số lượng chuyến bay xuất phát từ
--sân bay đó, sắp xếp theo thứ tự tăng dần của sân bay xuất phát.
select sbDi, count(maCB) as N'SLCB cất cánh'
from CHUYENBAY
group by sbDi
order by sbDi

--Q19. Với mỗi sân bay (sbDi), cho biết số lượng chuyến bay
--xuất phát theo từng ngày. Xuất ra maSB đi, ngayDi và số lượng.
select cb.sbDi, lb.ngayDi, count(cb.maCB) as 'SL chuyến bay'
from CHUYENBAY cb, LICHBAY lb
where cb.maCB = lb.maCB
group by cb.sbDi, lb.ngayDi

--Q20. Với mỗi sân bay (sbDen), cho biết số lượng chuyến bay
--hạ cánh theo từng ngày. Xuất ra maSB đến, ngayDi và số lượng.
select cb.sbDen, lb.ngayDi, count(cb.maCB) as 'SL chuyến bay'
from CHUYENBAY cb, LICHBAY lb
where cb.maCB = lb.maCB
group by cb.sbDen, lb.ngayDi

--Q21. Với mỗi lịch bay, cho biết maCB, ngày đi cùng với số lượng
--nhân viên không phải là phi công của chuyến bay đó
select pc.maCB, pc.ngayDi, count(nv.maNV) as 'SL Tiếp Viên'
from PHANCONG pc, NHANVIEN nv
where pc.maNV = nv.maNV and nv.loaiNV = '0'
group by pc.maCB, pc.ngayDi

--Q22. Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000.
select cb.sbDi, lb.ngayDi, count(cb.maCB) as 'Số lượng chuyến bay'
from CHUYENBAY cb, LICHBAY lb
where cb.maCB = lb.maCB and cb.sbDi = 'MIA' and lb.ngayDi = '2000-11-01'
group by cb.sbDi, lb.ngayDi

--Q23. Với mỗi chuyến bay, cho biết maCB, ngayDi, số lượng nhân viên
--được phân công trên chuyến bay đó, sắp xếp theo thứ tự giảm dần cúa
--số lượng.
select cb.maCB, lb.ngayDi, count(pc.maNV) as 'Số lượng nhân viên'
from CHUYENBAY cb, LICHBAY lb, PHANCONG pc
where cb.maCB = lb.maCB and lb.ngayDi = pc.ngayDi and lb.maCB = pc.maCB
group by cb.maCB, lb.ngayDi
order by count(pc.maNV) desc

--Q24. Với mỗi chuyến bay, cho biết maCB, ngayDi cùng với số lượng
--hành khách đã đặt chỗ của chuyến bay đó, sắp xếp số lượng giảm dần.
select cb.maCB, lb.ngayDi, count(dc.maKH) as 'Số lượng khách hàng'
from CHUYENBAY cb, LICHBAY lb, DATCHO dc
where cb.maCB = lb.maCB and lb.maCB = dc.maCB
group by cb.maCB, lb.ngayDi
order by count(dc.maKH) desc

--Q25. Với mỗi chuyến bay, cho biết macb, ngayDi, tổng lương của phi hành
--đoàn (các nhân viên được phân công trong chuyến bay),
--sắp xếp theo thứ tự tăng dần của tổng lương.
select pc.maCB, pc.ngayDi, sum(nv.luong) as 'Số lượng nhân viên'
from PHANCONG pc, NHANVIEN nv
where pc.maNV = nv.maNV
group by pc.maCB, pc.ngayDi
order by sum(nv.luong) asc

--Q26. Lương trung bình các nhân viên không phải phi công
select avg(NHANVIEN.luong)
from NHANVIEN
where NHANVIEN.loaiNV = '0'

--Q27. Cho biết lương trung bình của các phi công
select AVG(NHANVIEN.luong)
from NHANVIEN
where NHANVIEN.loaiNV = '1'

--Q28. Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên
--loại máy bay đó hạ cánh xuống sân bay ORD. Xuất ra mã loại máy bay,
--số lượng chuyến bay.
select lb.maLoai, count(cb.maCB) as 'Số lượng chuyến bay'
from LICHBAY lb, CHUYENBAY cb
where lb.maCB = cb.maCB and cb.sbDen = 'ORD'
group by lb.maLoai

--Q29. Cho biết sân bay (sbDi) và số lượng chuyến bay có nhiều hơn 2
--chuyến bay xuất phát trong khoảng 10h->22h.
select cb.sbDi, count(cb.maCB) as 'Số lượng chuyến bay'
from CHUYENBAY cb
where cb.gioDi > '10:00' and cb.gioDi < '22:00' 
group by cb.sbDi
having count(cb.maCB) > 2

--Q30. Cho biết tên phi công được phân công vào ít nhất 2 chuyến
--bay trong cùng 1 ngày
select nv.ten, pc.ngayDi, count(pc.maCB) as 'Số chuyến được phân công'
from PHANCONG pc, NHANVIEN nv
where nv.loaiNV = '1' and pc.maNV = nv.maNV
group by nv.ten, pc.ngayDi
having count(pc.maCB) >= 2

--Q31. Cho biết mã chuyến bay và ngày đi của những chuyến bay có ít hơn
--3 hành khách đặt chỗ.
select maCB, ngayDi, count(maKH) as 'Số lượng hành khách đặt chỗ'
from DATCHO dc
group by maCB, ngayDi
having count(maKH) < 3

--Q32. Cho biết số hiệu máy bay và loại máy bay mà phi công có mã 1001
--được phân công lái trên 2 lần.
select lb.soHieu, lb.maLoai
from LICHBAY lb, PHANCONG pc
where lb.maCB = pc.maCB
and pc.maNV = '1001'
group by lb.soHieu, lb.maLoai
having count(distinct pc.maCB) >= 2

--Thêm để kiểm tra:
--insert into CHUYENBAY values ('999', 'AAA', 'BBB', '09:00', '11:00')
--insert into PHANCONG values('1001', '2000-11-01', '999')
--insert into LICHBAY values('2000-11-01', '999', '80', 'A310')

select * from LICHBAY

--Q33. Với mỗi hãng sản xuất, cho biết số lượng loại máy bay mà hãng đó
--đã sản xuất. Xuất ra hãng sản xuất và số lượng.
select hangSX, count(maLoai) as 'Số lượng'
from LOAIMB
group by hangSX

select * from LOAIMB

-------------------------------------------------------------
----TRUY VẤN LỒNG + HÀM
--Q34. Cho biết hãng sản xuất, mã loại và số hiệu của máy bay đã được
--sử dụng nhiều nhất.
select lmb.hangSX, lmb.maLoai, lb.soHieu, count(lb.maCB) as 'Số lượng chuyến bay'
from LICHBAY lb, LOAIMB lmb
where lb.maLoai = lmb.maLoai
group by lmb.hangSX, lmb.maLoai, lb.soHieu
having count(lb.maCB) >= all 
(select count(*) from LICHBAY group by soHieu, maLoai)

--Q35. Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất.
select nv.ten, count(pc.maCB) as 'Số lần phân công'
from NHANVIEN nv, PHANCONG pc
where nv.maNV = pc.maNV
group by nv.ten
having count(pc.maCB) >= all 
(select count(*) from PHANCONG group by maNV)

--Q36. Cho biết thông tin của phi công(tên, địa chỉ, điện thoại) 
--lái nhiều chuyến bay nhất.
select phicong.ten, phicong.dChi, phicong.dThoai, count(pc.maCB) as 'SL chuyến bay'
from PHANCONG pc, NHANVIEN phicong
where phicong.loaiNV = '1' and pc.maNV = phicong.maNV
group by phicong.ten, phicong.dChi, phicong.dThoai
having count(pc.maCB) >= all (select count(*) from PHANCONG group by maNV)

--Q37. Cho biết sân bay (SBDEN) và số lượng chuyến bay của sân bay có ít chuyến
--bay đáp xuống nhất.
select sbDen, count(maCB) as 'Số lượng chuyến bay'
from CHUYENBAY
group by sbDen
having count(maCB) <= all (select count(*) from CHUYENBAY group by sbDen)

--Q38. Cho biết sân bay (SBDI) và số lượng chuyến bay của sân bay
--có nhiều chuyến bay xuất phát nhất.
select sbDi, count(maCB) as 'Số lượng chuyến bay'
from CHUYENBAY
group by sbDi
having count(maCB) >= all (select count(*) from CHUYENBAY group by sbDi)

--Q39. Cho biết tên, địa chỉ và điện thoại của khách hàng đã đi trên
--nhiều chuyến bay nhất.
select kh.ten, kh.dChi, kh.dThoai, count(dc.maCB) as 'Số lượng chuyến bay'
from KHACHHANG kh, DATCHO dc
where kh.maKH = dc.maKH
group by kh.ten, kh.dChi, kh.dThoai
having count(dc.maCB) >= all (select count(*) from DATCHO group by maKH)

--Q40. Cho biết mã số, tên và lương của các phi công có khả năng lái
--nhiều loại máy bay nhất.
select kn.maNV, pilot.ten, pilot.luong, count(kn.maLoai) as 'Số loại máy bay'
from NHANVIEN pilot, KHANANG kn
where pilot.loaiNV = '1' and kn.maNV = pilot.maNV
group by kn.maNV, pilot.ten, pilot.luong
having count(kn.maLoai) >= all (select count(*) from KHANANG group by maNV)

-- Q41. Cho biết thông tin (mã nhân viên, tên, lương)
-- của nhân viên có mức lương cao nhất.
select nv.maNV, nv.ten, nv.luong
from NHANVIEN nv
where nv.luong = (select max(luong) from NHANVIEN)

--Q42. Cho biết tên, địa chỉ của các nhân viên có lương cao nhất
--trong phi hành đoàn (các nhân viên được phân công trong một chuyến bay)
--mà người đó tham gia.
select pc.maCB, nv.ten, nv.dChi, nv.luong
from PHANCONG pc, NHANVIEN nv
where pc.maNV = nv.maNV and nv.luong 
>= all (select luong from NHANVIEN nv, PHANCONG pc
where nv.maNV = pc.maNV group by luong)
group by pc.maCB, nv.ten, nv.dChi, nv.luong

--Q43. Cho biết mã chuyến bay, giờ đi và giờ đến của chuyến bay sớm nhất trong ngày
select maCB, gioDi, gioDen
from CHUYENBAY 
where gioDi <= all (select gioDi from CHUYENBAY)

select * from CHUYENBAY
--Q44. Cho biết mã chuyến bay có thời gian bay dài nhất. Xuất ra mã chuyến bay
--và thời gian bay tính bằng phút.
select maCB, datediff(minute, gioDi, gioDen) as 'Thời gian bay (Phút)'
from CHUYENBAY 
where datediff(minute, gioDi, gioDen)
>= all (select datediff(minute, gioDi, gioDen) from CHUYENBAY)

--Q45. Cho biết mã chuyến bay có thời gian bay ít nhất. Xuất ra mã chuyến bay
--và thời gian bay tính bằng phút.
select maCB, datediff(minute, gioDi, gioDen) as 'Thời gian bay (Phút)'
from CHUYENBAY 
where datediff(minute, gioDi, gioDen)
<= all (select datediff(minute, gioDi, gioDen) from CHUYENBAY)

--Q46. Cho biết mã chuyến bay và ngày đi của những chuyến bay bay trên loại 
--máy bay B747 nhiều nhất.
select maCB, ngayDi, count(maCB) as 'Số lượng chuyến bay'
from LICHBAY
where maLoai = 'B747'
group by maCB, ngayDi
having count(maCB) >= all (select count(maCB) from LICHBAY
where maLoai = 'B747' group by maCB, ngayDi)

--Q46a. Cho biết mã chuyến bay của những chuyến bay bay trên loại 
--máy bay B747 nhiều nhất.
select maCB, count(maCB) as 'Số lượng chuyến bay'
from LICHBAY
where maLoai = 'B747'
group by maCB
having count(maCB) >= all (select count(maCB) from LICHBAY
where maLoai = 'B747' group by maCB)

select * from LICHBAY
--Q47. Với mỗi chuyến bay có trên 3 hành khách, cho biết mã chuyến bay
--và số lượng nhân viên trên chuyến bay đó. Xuất ra mã chuyến bay và số lượng nv.
select dc.maCB, dc.ngayDi,
count(distinct pc.maNV) as 'Số lượng nhân viên', 
count(distinct dc.maKH) as 'Số lượng hành khách'
from DATCHO dc, PHANCONG pc
where pc.maCB = dc.maCB and pc.ngayDi = dc.ngayDi
group by dc.maCB, dc.ngayDi
having count(distinct dc.maKH) >= 3

--Q48. Với mỗi loại nhân viên có tổng lương trên 600000, cho biết số lượng
--nhân viên trong từng loại nhân viên đó. Xuất ra loại nhân viên, và số lượng
--nhân viên tương ứng.
select loaiNV, count(maNV) as 'Số lượng nhân viên', sum(luong) as 'Tổng lương'
from NHANVIEN
group by loaiNV
having sum(luong) > 600000

--Q49. Với mỗi chuyến bay có trên 3 nhân viên, cho biết mã chuyến bay và số lượng
-- khách hàng đã đặt chỗ trên chuyến bay đó.
select dc.maCB, dc.ngayDi,
count(distinct pc.maNV) as 'Số lượng nhân viên', 
count(distinct dc.maKH) as 'Số lượng hành khách đặt chỗ'
from DATCHO dc, PHANCONG pc
where pc.maCB = dc.maCB and pc.ngayDi = dc.ngayDi
group by dc.maCB, dc.ngayDi
having count(distinct pc.maNV) > 3

--Q50. Với mỗi loại máy bay có nhiều hơn một chiếc, cho biết số lượng
--chuyến bay đã được bố trí bay bằng loại máy bay đó. Xuất ra mã loại và số lượng
select mb.maLoai, count(distinct mb.soHieu) 'số lượng máy bay', count(maCB) as 'Số chuyến bay đã được bố trí'
from MAYBAY mb left join LICHBAY lb on mb.maLoai = lb.maLoai and mb.soHieu = lb.soHieu
group by mb.maLoai
having count(mb.soHieu) > 1

--select maLoai, count(soHieu) from MAYBAY group by maLoai

--select maLoai, count(maCB) from LICHBAY group by maLoai
--
--Q51. Cho biết mã những chuyến bay đã bay tất cả các máy bay của hãng
--'Boeing'
select distinct lb.maCB
from LICHBAY lb
where not exists (select * from LOAIMB lmb
where lmb.hangSX = 'Boeing' and not exists (select * from LICHBAY lb2
where lb2.maCB = lb.maCB and lb2.maLoai = lmb.maLoai))
 
--select * from LOAIMB

--insert into LICHBAY values 
--('2000-11-11', '991', '11', 'B727'),
--('2000-10-21', '991', '10', 'B747')


--Q52. Cho biết mã và tên phi công có khả năng lái tất cả các máy bay của hãng
--'Airbus'
select distinct kn.maNV, phicong.ten
from KHANANG kn, NHANVIEN phicong
where kn.maNV = phicong.maNV
and not exists (select * from LOAIMB lmb 
where lmb.hangSX = 'Airbus' and not exists
(select * from KHANANG kn2 
where kn2.maNV = kn.maNV and kn2.maLoai = lmb.maLoai))

--Thêm dữ liệu để test câu query:
select * from KHANANG
select * from MAYBAY
select * from LICHBAY

--insert into KHANANG values
--('1002', 'A310'),     
--('1002', 'A330')

--insert into MAYBAY values
--('90', 'A320'),
--('100', 'A330'),
--('110', 'A340')

--insert into LICHBAY values
--('2000-01-01','100','90', 'A320'),
--('2000-05-01','100','100', 'A330'),
--('2000-07-01','100','110', 'A340')

--Q53. Cho biết tên nhân viên (không phải phi công) được phân công bay vào
--tất cả các chuyến bay có mã 100.
select * from PHANCONG
select * from LICHBAY
select distinct pc.maNV, nv.ten
from NHANVIEN nv, PHANCONG pc
where nv.maNV = pc.maNV and nv.loaiNV = '0' --không phải phi công
and not exists (select * from LICHBAY lb
where lb.maCB = '100' and not exists
(select * from PHANCONG pc2 where pc2.maNV = pc.maNV and pc2.maCB = lb.maCB
and pc2.ngayDi = lb.ngayDi))

----Thêm để test:
--insert into PHANCONG values
--('1004', '2000-01-01', '100'),
--('1004', '2000-05-01', '100'),
--('1004', '2000-07-01', '100')

--Q54. Cho biết ngày đi nào mà có tất cả các loại máy bay của hãng 'Boeing'
--tham gia.
select distinct lb.ngayDi
from LICHBAY lb
where not exists (select * from LOAIMB lmb where lmb.hangSX = 'Boeing'
and not exists (select * from LICHBAY lb2 where lb2.ngayDi = lb.ngayDi
and lb2.maLoai = lmb.maLoai))

select * from LICHBAY

----Thêm để test:
--insert into LICHBAY values 
--('2000-10-31', '991', '22', 'B757')

--Q55. Cho biết loại máy bay của hãng 'Boeing' nào có tham gia vào tất cả
--các ngày đi.
select distinct lb.maLoai
from LICHBAY lb
where not exists (select * from LICHBAY lb2 where lb2.maLoai
in (select maLoai from LOAIMB where hangSX = 'MD')
and not exists (select * from LICHBAY lb3
where lb3.maLoai = lb.maLoai and lb3.ngayDi = lb2.ngayDi))

select * from CHUYENBAY

----Thêm để test:
--insert into LICHBAY values 
--('2000-01-01', '334', '22','DC9'),
--('2000-05-01', '112','22','DC9'),
--('2000-07-01', '121', '22', 'DC9'),
--('2000-10-21', '206', '22', 'DC9'),
--('2000-11-11', '931 ', '22', 'DC9')

--Q56. Cho biết mã và tên các khách hàng có đặt chỗ trong tất cả các ngày từ
--31/10/2000 đến --1/1/2001
--01/11/2000

select distinct dc.maKH, kh.ten
from KHACHHANG kh, DATCHO dc
where kh.maKH = dc.maKH and not exists
(select * from LICHBAY lb
where lb.ngayDi <= '2000-11-01' 
and lb.ngayDi >= '2000-10-31'
and not exists (select * from DATCHO dc2
where dc2.maKH = dc.maKH and dc2.ngayDi = lb.ngayDi))

select * from DATCHO

--Select * from MyTable where myDate > convert(DATETIME,'2013-04-10', 126)

--Q57. Cho biết mã và tên phi công không có khả năng lái được tất cả các máy
-- bay của hãng 'Airbus'.
select distinct kn.maNV, phicong.ten
from KHANANG kn, NHANVIEN phicong
where kn.maNV = phicong.maNV and exists
((select lmb.maLoai from LOAIMB lmb where lmb.hangSX = 'Airbus')
except (select kn2.maLoai from KHANANG kn2
where kn2.maNV = kn.maNV))

--select * from KHANANG
--select * from LOAIMB

--Cách 2
select distinct kn.maNV, phicong.ten
from KHANANG kn, NHANVIEN phicong
where kn.maNV = phicong.maNV and exists
(select * from LOAIMB lmb where lmb.hangSX = 'Airbus'
and not exists (select * from KHANANG kn2
where kn2.maNV = kn.maNV and kn2.maLoai = lmb.maLoai))

--Q58. Cho biết sân bay nào đã có tất cả các loại máy bay của hãng 'Boeing'
--xuất phát.
select distinct cb.sbDi
from CHUYENBAY cb, LICHBAY lb
where cb.maCB = lb.maCB
and not exists (select * from LOAIMB lmb where hangSX = 'Airbus' --hangSX = 'Boeing'
and not exists (select * from LICHBAY lb2
where lb2.maCB = lb.maCB
and lb2.maLoai = lmb.maLoai))

--Test:
select * from LICHBAY 
where maLoai in (select maLoai from LOAIMB where hangSX = 'Airbus')
select * from CHUYENBAY
 
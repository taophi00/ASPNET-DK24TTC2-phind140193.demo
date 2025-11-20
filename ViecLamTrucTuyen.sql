-- =============================================
-- TẠO CƠ SỞ DỮ LIỆU
-- =============================================
CREATE DATABASE ViecLamTrucTuyen;
GO

USE ViecLamTrucTuyen;
GO

-- =============================================
-- BẢNG: NguoiDung
-- MÔ TẢ: Lưu trữ thông tin tài khoản đăng nhập chung
-- =============================================
CREATE TABLE NguoiDung (
    Id VARCHAR(50) PRIMARY KEY,
    Email VARCHAR(255) NOT NULL UNIQUE,
    MatKhau VARCHAR(255) NOT NULL,
    -- VaiTro: 1 cho Ứng viên, 2 cho Nhà tuyển dụng
    VaiTro INT NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE()
);

-- =============================================
-- BẢNG: UngVien
-- MÔ TẢ: Lưu trữ thông tin hồ sơ của ứng viên
-- =============================================
CREATE TABLE UngVien (
    Id VARCHAR(50) PRIMARY KEY,
    IdNguoiDung VARCHAR(50) NOT NULL UNIQUE,
    HoTen NVARCHAR(255) NOT NULL,
    SoDienThoai VARCHAR(20),
    AnhDaiDien VARCHAR(500),
    ChucDanh NVARCHAR(255),
    KinhNghiem NVARCHAR(MAX),
    KyNang NVARCHAR(MAX),
    HocVan NVARCHAR(MAX),
    DuongDanCV VARCHAR(500),
    NgayTao DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_UngVien_NguoiDung FOREIGN KEY (IdNguoiDung) REFERENCES NguoiDung(Id)
);

-- =============================================
-- BẢNG: NhaTuyenDung
-- MÔ TẢ: Lưu trữ thông tin hồ sơ của nhà tuyển dụng/công ty
-- =============================================
CREATE TABLE NhaTuyenDung (
    Id VARCHAR(50) PRIMARY KEY,
    IdNguoiDung VARCHAR(50) NOT NULL UNIQUE,
    TenCongTy NVARCHAR(255) NOT NULL,
    Logo VARCHAR(500),
    MoTa NVARCHAR(MAX),
    TrangWeb VARCHAR(255),
    SoDienThoai VARCHAR(20),
    DiaChi NVARCHAR(MAX),
    NganhNghe NVARCHAR(100),
    QuyMo VARCHAR(50),
    NgayTao DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_NhaTuyenDung_NguoiDung FOREIGN KEY (IdNguoiDung) REFERENCES NguoiDung(Id)
);

-- =============================================
-- BẢNG: DanhMuc
-- MÔ TẢ: Phân loại các ngành nghề, lĩnh vực công việc
-- =============================================
CREATE TABLE DanhMuc (
    Id VARCHAR(50) PRIMARY KEY,
    TenDanhMuc NVARCHAR(255) NOT NULL,
    MoTa NVARCHAR(MAX),
    -- TrangThai: 1 là đang hoạt động, 0 là không hoạt động
    TrangThai BIT DEFAULT 1
);

-- =============================================
-- BẢNG: CongViec
-- MÔ TẢ: Lưu trữ thông tin các tin tuyển dụng
-- =============================================
CREATE TABLE CongViec (
    Id VARCHAR(50) PRIMARY KEY,
    IdNhaTuyenDung VARCHAR(50) NOT NULL,
    IdDanhMuc VARCHAR(50) NOT NULL,
    TieuDe NVARCHAR(255) NOT NULL,
    DiaDiem NVARCHAR(255) NOT NULL,
    MucLuong VARCHAR(100),
    -- LoaiHinh: 1 cho Toàn thời gian, 2 cho Bán thời gian, 3 cho Thực tập, ...
    LoaiHinh INT NOT NULL,
    MoTaCongViec NVARCHAR(MAX) NOT NULL,
    YeuCau NVARCHAR(MAX),
    QuyenLoi NVARCHAR(MAX),
    NgayDang DATETIME DEFAULT GETDATE(),
    -- TrangThai: 1 là đang hiển thị, 0 là đã ẩn
    TrangThai BIT DEFAULT 1,
    CONSTRAINT FK_CongViec_NhaTuyenDung FOREIGN KEY (IdNhaTuyenDung) REFERENCES NhaTuyenDung(Id),
    CONSTRAINT FK_CongViec_DanhMuc FOREIGN KEY (IdDanhMuc) REFERENCES DanhMuc(Id)
);

-- =============================================
-- BẢNG: DonUngTuyen
-- MÔ TẢ: Lưu trữ thông tin ứng tuyển của ứng viên vào công việc
-- =============================================
CREATE TABLE DonUngTuyen (
    Id VARCHAR(50) PRIMARY KEY,
    IdCongViec VARCHAR(50) NOT NULL,
    IdUngVien VARCHAR(50) NOT NULL,
    ThuXinViec NVARCHAR(MAX),
    DuongDanCV VARCHAR(500),
    -- TrangThai: 0-Đã nộp, 1-Đã xem, 2-Phù hợp, 3-Từ chối
    TrangThai INT DEFAULT 0,
    NgayNop DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_DonUngTuyen_CongViec FOREIGN KEY (IdCongViec) REFERENCES CongViec(Id),
    CONSTRAINT FK_DonUngTuyen_UngVien FOREIGN KEY (IdUngVien) REFERENCES UngVien(Id)
);

GO

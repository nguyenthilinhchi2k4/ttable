CREATE DATABASE  BookLibrary
GO 
USE  BookLibrary
GO
CREATE TABLE Book(
BookCode INT PRIMARY KEY,
BookTitle VARCHAR(100) NOT NULL,
Author VARCHAR (50) NOT NULL,
Edition INT DEFAULT 1,
BookPrice MONEY DEFAULT 0.0,
Copies INT DEFAULT 0
);

-Tạo bảng Member
CREATE TABLE Member (
    MemberCode INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    PhoneNumber BIGINT NOT NULL
);

-- Tạo bảng IssueDetails
CREATE TABLE IssueDetails (
    BookCode INT,
    MemberCode INT,
    IssueDate DATETIME DEFAULT GETDATE(),
    ReturnDate DATETIME,
    CONSTRAINT FK_Book FOREIGN KEY (BookCode) REFERENCES Book(BookCode),
    CONSTRAINT FK_Member FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode),
    CONSTRAINT CK_IssueDate CHECK (IssueDate <= ReturnDate)
);

--Xóa bỏ ràng buộc khóa ngoại cho bảng IssueDetails
ALTER TABLE IssueDetails
DROP CONSTRAINT FK_Book;

ALTER TABLE IssueDetails
DROP CONSTRAINT FK_Member;
-- Xóa bỏ Ràng buộc Khóa chính của bảng Member và Book
ALTER TABLE Book
DROP CONSTRAINT PK__Book__0A5FFCC6F481C4E2;

ALTER TABLE Member
DROP CONSTRAINT PK__Member__84CA6376FCA1A979;


SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Member' AND CONSTRAINT_TYPE = 'PRIMARY KEY';


--Thêm mới ràng buộc Khóa chính cho bảng Member
ALTER TABLE Member
ADD CONSTRAINT PK_MemberCode PRIMARY KEY (MemberCode);

--Thêm mới ràng buộc Khóa chính cho bảng Book
ALTER TABLE Book
ADD CONSTRAINT PK_BookCode PRIMARY KEY (BookCode);

--Thêm mới ràng buộc khóa ngoại cho bảng IssueDetails
ALTER TABLE IssueDetails
ADD CONSTRAINT FK_Book FOREIGN KEY (BookCode) REFERENCES Book(BookCode);

ALTER TABLE IssueDetails
ADD CONSTRAINT FFK_Member FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode);

-- Thêm ràng buộc giá trị cho cột BookPrice trong bảng Book
ALTER TABLE Book
ADD CONSTRAINT CK_BookPriceRange CHECK (BookPrice > 0 AND BookPrice < 200);

-- Thêm ràng buộc duy nhất cho cột PhoneNumber trong bảng Member
ALTER TABLE Member
ADD CONSTRAINT PhoneNumber UNIQUE (PhoneNumber);

-- Thêm ràng buộc NOT NULL cho cột BookCode trong bảng IssueDetails
ALTER TABLE IssueDetails
	ALTER COLUMN BookCode INT NOT NULL

ALTER TABLE IssueDetails
	ALTER COLUMN MemberCode INT NOT NULL

--Tạo khóa chính gồm 2 cột BookCode, MemberCode cho bảng IssueDetails
ALTER TABLE IssueDetails
ADD CONSTRAINT PK_IssueDetails PRIMARY KEY (BookCode, MemberCode);

-- Chèn dữ liệu vào bảng Book
INSERT INTO Book (BookCode, BookTitle, Author, Edition, BookPrice, Copies)
VALUES
    (1, 'Introduction to Programming', 'John Smith', 1, 50.00, 10),
    (2, 'Database Management', 'Jane Doe', 2, 75.00, 5),
    (3, 'Web Development Basics', 'David Johnson', 1, 60.00, 8),
    (4, 'Data Structures and Algorithms', 'Emily Brown', 3, 90.00, 6),
    (5, 'Networking Fundamentals', 'Michael Lee', 1, 55.00, 12);

-- Chèn dữ liệu vào bảng Member
INSERT INTO Member (MemberCode, Name, Address, PhoneNumber)
VALUES
    (1001, 'Alice Johnson', '123 Main St, City', 123456789),
    (1002, 'Bob Smith', '456 Park Ave, Town', 987654321),
    (1003, 'Eva Davis', '789 Broadway, Village', 555555555),
    (1004, 'Daniel Miller', '234 Elm Rd, County', 111111111),
    (1005, 'Olivia Wilson', '567 Oak Lane, State', 222222222);

-- Chèn dữ liệu vào bảng IssueDetails
INSERT INTO IssueDetails (BookCode, MemberCode, IssueDate, ReturnDate)
VALUES
    (1, 1001, '2023-08-01', '2023-08-15'),
    (2, 1002, '2023-08-02', '2023-08-18'),
    (3, 1003, '2023-08-03', '2023-08-20'),
    (4, 1004, '2023-08-04', '2023-08-17'),
    (5, 1005, '2023-08-05', '2023-08-22');
	SELECT* FROM Book
	SELECT *FROM Member
	SELECT *FROM IssueDetails
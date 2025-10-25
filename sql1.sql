-- cau 1
-- 1. Tạo bảng Student
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Gender INT  -- 0: Male, 1: Female, NULL: Unknown
);

-- 2. Tạo bảng Subject
CREATE TABLE Subject (
    SubjectID INT PRIMARY KEY,
    sName NVARCHAR(50) NOT NULL
);

-- 3. Tạo bảng StudentSubject (Bảng điểm)
CREATE TABLE StudentSubject (
    StudentID INT,
    SubjectID INT,
    Mark INT CHECK (Mark >= 0 AND Mark <= 10),
    Date DATE,
    PRIMARY KEY(StudentID, SubjectID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID)
);

-- Thêm dữ liệu vào bảng Student
INSERT INTO Student VALUES
(1, N'Nguyen Van A', 'a@gmail.com', 0),
(2, N'Tran Thi B', 'b@gmail.com', 1),
(3, N'Le Van C', 'c@gmail.com', NULL);

-- Thêm dữ liệu vào bảng Subject
INSERT INTO Subject VALUES
(101, N'Math'),
(102, N'Physics'),
(103, N'English');

-- Thêm dữ liệu vào bảng StudentSubject
INSERT INTO StudentSubject VALUES
(1, 101, 8, '2025-01-10'),
(1, 102, 4, '2025-01-12'),
(2, 103, 6, '2025-01-15');


-- cau 2
-- a
SELECT s.Name AS StudentName, s.Email, sub.sName AS SubjectName, ss.Mark
FROM Student s
JOIN StudentSubject ss ON s.StudentID = ss.StudentID
JOIN Subject sub ON ss.SubjectID = sub.SubjectID
WHERE ss.Mark > 5;

-- b
SELECT sName
FROM Subject
WHERE SubjectID NOT IN (SELECT DISTINCT SubjectID FROM StudentSubject);

-- c
SELECT sub.sName
FROM Subject sub
JOIN StudentSubject ss ON sub.SubjectID = ss.SubjectID
GROUP BY sub.sName
HAVING COUNT(ss.Mark) >= 2;


-- Cau 3
CREATE VIEW StudentInfo AS
SELECT 
    s.StudentID,
    ss.SubjectID,
    s.Name AS StudentName,
    s.Email,
    CASE 
        WHEN s.Gender = 0 THEN 'Male'
        WHEN s.Gender = 1 THEN 'Female'
        ELSE 'Unknown'
    END AS Gender,
    sub.sName AS SubjectName,
    ss.Mark,
    ss.Date
FROM Student s
LEFT JOIN StudentSubject ss ON s.StudentID = ss.StudentID
LEFT JOIN Subject sub ON ss.SubjectID = sub.SubjectID;

SELECT * FROM StudentInfo;

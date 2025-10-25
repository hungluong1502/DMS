-- Cau 2:
CREATE DATABASE ABCCompany;
USE ABCCompany;

CREATE TABLE Department (
    DepartmentCode VARCHAR(10) PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Employee (
    EmployeeCode VARCHAR(10) PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentCode VARCHAR(10),
    FOREIGN KEY (DepartmentCode) REFERENCES Department(DepartmentCode)
);

-- Bảng lương
CREATE TABLE Payroll (
    PayrollID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeCode VARCHAR(10),
    WorkingDays INT,
    PaidOffDays INT,
    UnpaidOffDays INT,
    BasicSalary DECIMAL(10,2),
    GrossSalary DECIMAL(10,2),
    NetSalary DECIMAL(10,2),
    Note VARCHAR(100),
    FOREIGN KEY (EmployeeCode) REFERENCES Employee(EmployeeCode)
);

-- Insert Department
INSERT INTO Department VALUES ('IT', 'Information Technology');
INSERT INTO Department VALUES ('HR', 'Human Resource');
INSERT INTO Department VALUES ('SALE', 'Sales Department');

-- Insert Employee
INSERT INTO Employee VALUES ('A1', 'Nguyễn Văn A', 'IT');
INSERT INTO Employee VALUES ('A2', 'Lê Thị Bình', 'IT');
INSERT INTO Employee VALUES ('B1', 'Nguyễn Lan', 'HR');
INSERT INTO Employee VALUES ('D1', 'Mai Tuấn Anh', 'HR');
INSERT INTO Employee VALUES ('C1', 'Hà Thị Lan', 'HR');
INSERT INTO Employee VALUES ('C2', 'Lê Tú Chinh', 'SALE');
INSERT INTO Employee VALUES ('D2', 'Trần Văn Toàn', 'HR');
INSERT INTO Employee VALUES ('A3', 'Trần Văn Nam', 'IT');
INSERT INTO Employee VALUES ('B2', 'Huỳnh Anh', 'SALE');

-- Insert Payroll
INSERT INTO Payroll (EmployeeCode, WorkingDays, PaidOffDays, UnpaidOffDays, BasicSalary, GrossSalary, NetSalary)
VALUES 
('A1',22,0,0,1000,22000,20000),
('A2',21,1,0,1200,26400,23000),
('B1',20,1,1,600,13200,12000),
('D1',20,1,1,500,11000,10000),
('C1',22,0,0,500,11000,10000),
('C2',22,0,0,1200,26400,23000),
('D2',22,0,0,500,11000,10000),
('A3',22,0,0,1200,26400,23000),
('B2',21,1,0,1200,26400,23000);


-- Cau 3
CREATE PROCEDURE TotalSalaryByDepartment
AS
BEGIN
    SELECT d.DepartmentCode, SUM(p.NetSalary) AS TotalNetSalary
    FROM Payroll p
    JOIN Employee e ON p.EmployeeCode = e.EmployeeCode
    JOIN Department d ON e.DepartmentCode = d.DepartmentCode
    GROUP BY d.DepartmentCode
    ORDER BY d.DepartmentCode ASC;
END;

EXEC TotalSalaryByDepartment;


-- Cau 1:
/*
Bảng Department
| DepartmentCode (PK) | DepartmentName (optional) |
Bảng Employee
| EmployeeCode (PK) | EmployeeName | DepartmentCode (FK) |
Bảng Payroll
| PayrollID (PK) | EmployeeCode (FK) | WorkingDays | PaidOffDays | UnpaidOffDays | BasicSalary | GrossSalary | NetSalary | Note |
*/

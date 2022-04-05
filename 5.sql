-- create database week5_9285


use week5_9285;

-- create login ADMIN9285 with PASSWORD = 'password1!'
-- create login API9285 with PASSWORD = 'password2!'


-- create user ADMIN9285 for login admin9285
-- create user API9285 for login API9285

-- exec sp_addrolemember 'db_owner','ADMIN9285'
-- go

-- exec sp_addrolemember 'db_datawriter', 'API9285'
-- exec sp_addrolemember 'db_datareader', 'API9285'
-- go
drop table if EXISTS employee
drop table if exists office
drop table if exists department
drop table if exists building

Create table building(
    BuildingCode NVARCHAR(4) PRIMARY KEY,
    [description] NVARCHAR(200) NOT NULL
);
create table department(
    DeptCode NVARCHAR(5) primary key,
    DeptName NVARCHAR(50) not null
);
create table office(
    BuildingCode NVARCHAR(4),
    OfficeNo int,
    NumDesks int,
    phone nvarchar(20),
    CONSTRAINT ForeignKEYS_OFFICE
        foreign key (buildingCode) REFERENCES building (buildingCode),
    CONSTRAINT COMPPK_OFFICE
        primary key (buildingCode, OfficeNo),
    CONSTRAINT NumPhones
        check (numDesks <5),
);
create table employee(
    empID int,
    FirstName NVARCHAR(50) not null,
    Surname NVARCHAR(50) not null,
    email nvarchar(100),
    DeptCode nvarchar(5) foreign key (DeptCode) REFERENCES department (DeptCode),
    buildingCode NVARCHAR(4),
    OfficeNo int,
    constraint employee_FK_OFFICE
        foreign key(buildingCode, OfficeNo) references office (buildingCode, OfficeNo),
    constraint EMAIL_CHECK
        check(email like '%@%')
);


insert into building (BuildingCode, [description]) values 
('DGGP','Dod & Gy Google Plex'),
('DGL','Dod & Gy Louvre'),
('DGW','Dod & Gy Whitehouse');
insert into department (DeptCode, [DeptName]) VALUES 
('SNM', 'Sales and Marketing'),
('FULL', 'Fullfilment'),
('TAD', 'Tax Avoidance Department'),
('PROC', 'Procurement'),
('HR', ' Humane Redundancies');
insert into office (BuildingCode, officeNo, NumDesks, Phone) values 
('DGGP',101,3,'(03)9555-1234'),
('DGGP',102,2,'(03)9555-1235'),
('DGL',512,4,'(03)9555-1236'),
('DGL',514,2,'(03)9555-1237'),
('DGW',53,1,'(03)9555-1238');
insert into employee (EmpID, Firstname, Surname,Email,DeptCode,BuildingCode, OfficeNo) values 
(100001, 'Pat', 'Cummins','patty@acb.com.au','SNM', 'DGGP', 101),
(100002, 'Tim', 'Paine','tim@acb.com.au','SNM', 'DGL', 512),
(100003, 'Steve', 'Smith','steve@acb.com.au','FULL', 'DGW', 53),
(100004, 'Shane', 'Watson','shape@acb.com.au','PROC', 'DGL', 514),
(100005, 'Meg', 'Lanning','meg@acb.com.au','HR', 'DGL', 512);



go 
CREATE VIEW [EmployeesByDept] as
Select E.Surname , E.FirstName, D.DeptName
FROM Employee E
INNER JOIN Department D
On E.deptcode = D.deptcode
Order by E.Surname;

go 
create view [BuildingDeskNumbers] as 
Select O.BuildingCode, Sum(O.NumDesks)
FROM Office O
Group By O.BuildingCode
Order By Sum(O.NumDesks) Asc;



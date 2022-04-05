-- create database week6_9285

-- use master
use week6_9285;

-- create login ADMIN9285 with PASSWORD = 'Password1!'
-- create login API9285 with PASSWORD = 'Password2!'


-- create user ADMIN9285 for login admin9285
-- create user API9285 for login API9285

-- exec sp_addrolemember 'db_owner','ADMIN9285'
-- go

-- exec sp_addrolemember 'db_datawriter', 'API9285'
-- exec sp_addrolemember 'db_datareader', 'API9285'
-- go

drop table if exists booking,

Create table tour(
    tourName NVARCHAR(20) PRIMARY KEY,
    [DESCRIPTION] NVARCHAR(500) not NULL
)
CREATE table client(
    ClientID int primary key,
    surname NVARCHAR(100) NOT Null,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1),
    CONSTRAINT CHECK_GENDER
        check(gender in ('m','f','i'))
)
create table [event](
    tourName NVARCHAR(20),
    EventYear int,
    EventMonth nvarchar(3),
    EventDay int,
    fee money not null,
    CONSTRAINT FK_TOURNAME
        FOREIGN KEY (tourName) references tour (tourName),
    CONSTRAINT MONEY_GT_ZERO
        check(fee>0),
    CONSTRAINT COMP_PK_EVENT
        PRIMARY KEY (tourName, EventYear, EventMonth, EventDay)
)
create table booking(
    tourName NVARCHAR(20),
    EventYear int,
    EventMonth NVARCHAR(3),
    EventDay int, 
    ClientID INT,
    DateBooked Date,
    Payment money,
    CONSTRAINT EVENT_FK
        FOREIGN KEY (tourName,EventYear,EventMonth,EventDay) references [event] (tourName, EventYear, EventMonth, EventDay),
    constraint CLIENT_FK
        foreign key (ClientID) REFERENCES client (ClientID),
    constraint PAYMENT_NOT_ZERO
        check (payment > 0),
    CONSTRAINT COMP_PK_BOOKING
        PRIMARY KEY(tourName, EventYear, EventMonth, EventDay, ClientID, DateBooked)
    
)
insert into tour (tourName, [description]) values
('Seat', 'Tour of wineries and outlets on top of Arthurs Seat'),
('Dromy', 'Tour of wineries and outlets of Dromana Secondary College'),
('Polo', 'Tour of wineries and outlets of Portsea Polo');

INSERT into client (ClientID, surname, GivenName, Gender) VALUES
(1, 'Kelly', 'Edward', 'M' ),
(2, 'Trouble', 'Allotta', 'F' ),
(3, 'Goespostal', 'Tilly', 'F'),
(4, 'le Kid', 'William', 'M'),
(5, 'Cranium', 'Richard', 'M'),
(6, 'YOUR SURNAME', 'YOUR FIRSTNAME', NULL)

insert into [event] (tourName, EventYear, EventMonth, EventDay, Fee ) VALUES
('Seat',  2022, 'Jan', 9, 200),
('Seat',  2022, 'Feb', 13, 225),
('Dromy',  2022, 'Jan', 9, 200),
('Dromy',  2022, 'Jan', 16, 200),
('Polo',  2022, 'Jan', 29, 225)

insert into booking (tourName, EventYear, EventMonth, EventDay, ClientID, DateBooked, Payment) values
('Seat', 2022,  'Jan', 9, 1, '12/10/2021', 200),
('Seat', 2022,  'Jan', 9, 2, '12/16/2021', 200),
('Seat',  2022, 'Feb', 13, 1, '1/8/2022', 225),
('Seat',  2022, 'Feb', 13, 2, '1/14/2022', 125),
('Seat',  2022, 'Feb', 13, 3, '2/3/2022', 225),
('Dromy', 2022, 'Jan', 9, 1, '12/10/2021', 200),
('Dromy',  2022, 'Jan', 16, 5, '12/18/2021', 200),
('Dromy',  2022, 'Jan', 16, 3, '1/9/2022', 200),
('Polo',  2022, 'Jan', 29, 2, '12/17/2021', 225),
('Polo',  2022, 'Jan', 29, 4, '12/18/2021', 200)

go 
Create view clientList as
select GivenName, surname 
from client

go
create view BookingSummary AS
select ClientID, TourName, EventDay, EventMonth, EventYear 
FROM [booking]





select * from tour
select * from client
select * from [event]
select * from booking


select * from clientList
select * from BookingSummary
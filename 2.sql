drop table if exists certificate
drop table if exists vehicle
drop table if exists customer


CREATE TABLE customer (
    custNo int,
    Firstname NVARCHAR(100),
    Surname NVARCHAR(100),
    Address NVARCHAR(100),
    Suburb NVARCHAR(100),
    Postcode decimal(4),
    Phone int,
    PRIMARY KEY(custNo)
)
CREATE TABLE vehicle (
    Registration NVARCHAR(6),
    VinNumber int,
    Make NVARCHAR(50),
    Model NVARCHAR(50),
    YearOfManufacture decimal(4),
    CustNo int,
    primary key (registration),
    foreign key (custNo) REFERENCES customer (custNo)
)
CREATE TABLE certificate (
    certificateNo INT,
    issueDate date,
    registration NVARCHAR(6)
    PRIMARY KEY(certificateNo),
    foreign KEY (registration) REFERENCES vehicle (registration)
)

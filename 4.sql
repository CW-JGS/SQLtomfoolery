use week4Build9285
drop view if exists [Total_Qty_Sold]
drop view if exists [CUSTOMER_BRIEF]
DrOp TaBlE iF eXiStS [orderline]
dRop tAbLe If ExIsTs [order] 
DrOp TaBlE iF eXiStS customer
dRoP tAbLe If ExIsTs product
drop table if exists prodcategory

-- create login ADMIN9285 with PASSWORD = 'password1!'
-- create login API9285 with PASSWORD = 'password2!'
-- create login DEV9285 with PASSWORD = 'password3!'
-- create login BACKUP9285 with PASSWORD = 'password4!'
-- create database week4Build9285;

-- create user ADMIN9285 for login admin9285
-- create user API9285 for login API9285
-- create user DEV9285 for login DEV9285
-- create user BACKUP9285 for login backup9285

-- exec sp_addrolemember 'db_owner','ADMIN9285'
-- go

-- exec sp_addrolemember 'db_datawriter', 'API9285'
-- exec sp_addrolemember 'db_datareader', 'API9285'
-- go

-- exec sp_addrolemember 'db_ddladmin', 'DEV9285'
-- exec sp_addrolemember 'db_datawriter', 'DEV9285'
-- exec sp_addrolemember 'db_datareader','DEV9285'
-- go

-- exec sp_addrolemember  'db_backupoperator','BACKUP9285'
-- go

CREATE table prodcategory (
CatCode NVARCHAR(5) primary key,
    [description] NVARCHAR(200) not null
);
CREATE TaBlE product (
    ProdID int,
    [description] NVARCHAR(MAX) not null,
    CostPrice money,
    RetailPrice money,
    CatCode NVARCHAR(5),       
    constraint PRODUCT_PK_PRODID 
        primary key(ProdID),
    constraint PRODUCT_FK_CATCODE
        foreign key(CatCode) REFERENCES prodcategory (CatCode),
    CONSTRAINT PRODUCT_CHK_COST_PRICE
        check(CostPrice > 0),
    CONSTRAINT PRODUCT_CHK_RETAIL_PRICE
        check(RetailPrice > CostPrice) 
);
create tAbLe Customer (
    CustID NVARCHAR(10) PRIMARY KEY,
    FirstName NVARCHAR(200) not null,
    Surname NVARCHAR(200), 
    Email NVARCHAR(200) not null
);
CREATE table [order] (
    CustID NVARCHAR(10),
    DateTimePlaced DATETIME,
    DeliveryAddress NVARCHAR(max),
    CONSTRAINT PK_ORDER_CUSTID_DATETIMEPLACED
        PRIMARY KEY(CustID, DateTimePlaced),
    CONSTRAINT FK_ORDER_CustID
        FOREIGN KEY(CustID) REFERENCES Customer (CustID)
);
CREATE table orderline (
    CustID NVARCHAR(10),
    DateTimePlaced DATETIME,
    prodID int FOREIGN KEY (prodID) REFERENCES Product (ProdID),
    qty INT,
    foreign key (CustID, DateTimePlaced) REFERENCES [order] (CustID, DateTimePlaced),
    CONSTRAINT ORDERLINE_PK
        PRIMARY KEY (CustID, DateTimePlaced, prodID),
    constraint ORDERLINE_CHECK_QTY
        check (qty > 0)
);

GO
CREATE VIEW [CUSTOMER_BRIEF] AS 
SELECT FIRSTNAME, SURNAME 
FROM Customer

GO
CREATE VIEW [Total_Qty_Sold] AS
SELECT SUM(QTY) as Total
FROM orderline

select * from [CUSTOMER_BRIEF]
select * from [Total_Qty_Sold]
select * from prodcategory
select * from product
select * from customer
select * from [order]
select * from orderline



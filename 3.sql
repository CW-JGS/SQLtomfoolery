drop table if exists ENTRY
DROP table if exists EVENT
drop table if exists MEET
DROP table if exists LOCATION
drop table if exists COMPETITOR

create TABLE COMPETITOR (
    CompetitorID NVARCHAR(10),
    FirstName NVARCHAR(100) NOT NULL Unique,
    Surname nvarchar(100) NOT NULL Unique,
    Gender NVARCHAR(1),
    DateOfBirth DATE NOT NULL Unique,
    PRIMARY key (CompetitorID),
    CONSTRAINT COMPETITOR_Gender_MF
        CHECK(Gender in ('m','f'))

)
create TABLE LOCATION(
    [location] NVARCHAR(50)  
    PRIMARY key ([location]) 
)
create TABLE MEET(
    [Year] DECIMAL(4),
    [location] NVARCHAR(50),
    CONSTRAINT MEET_FK 
        foreign key ([location]) REFERENCES LOCATION ([location]),

    CONSTRAINT MEET_PK
        primary key ([Year], [location])

)
create TABLE EVENT(
    [location] NVARCHAR(50),
    [Year] DECIMAL(4),
    Gender NVARCHAR(1) Not Null,
    AgeRestriction nvarchar(10),
    Distance int
    CONSTRAINT EVENT_FK
        FOREIGN key ([Year], [location]) REFERENCES MEET,
    CONSTRAINT EVENT_Gender_MF
        CHECK(Gender in ('m','f')),
    CONSTRAINT COMP_PRIMARY_KEY_EVENT
        primary key([location], [year], Gender, AgeRestriction, Distance)
    
)
create TABLE ENTRY(
    CompetitorID NVARCHAR(10),
    [location] NVARCHAR(50),
    [Year] DECIMAL(4),
    Gender NVARCHAR(1),
    AgeRestriction nvarchar(10),
    Distance int,
    time decimal(6,2)
    CONSTRAINT ENTRY_EVENT_FK
        FOREIGN key ([location], [year], gender, AgeRestriction, Distance) REFERENCES event,
    CONSTRAINT ENTRY_COMPETITOR_FK
        foreign key (CompetitorID) REFERENCES competitor (CompetitorID),
    CONSTRAINT ENTRY_TIME_GTZ
        CHECK(time > 0),
    CONSTRAINT ENTRY_PK
        PRIMARY key (CompetitorID, [location], [year], gender, AgeRestriction, distance)
)


insert into COMPETITOR (CompetitorID, FirstName, Surname, Gender, DateOfBirth) Values
('m192169420', 'damo', 'burns', 'M', '2003-09-15');

INSERT into Location ([Location]) VALUES
('hawthorne');

INSERT into MEET ([location],[Year]) VALUES
('hawthorne',2022);

INSERT into EVENT ([location],[year],Gender, AgeRestriction, distance) VALUES
('hawthorne',2022,'M','U20', 2000);

insert into ENTRY (CompetitorID,[location],[year],Gender, AgeRestriction, distance,[time]) values
('m192169420','hawthorne',2022,'M','U20', 2000,15);

CREATE INDEX SurnameIndex ON COMPETITOR(Surname);


select * from COMPETITOR
select * from LOCATION
select * from MEET
select * from EVENT
select * from ENTRY


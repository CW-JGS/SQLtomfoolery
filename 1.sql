drop table if exists complaint 

create table complaint(
    fullName NVARCHAR(100),
    mobileNo int,
    staffName NVARCHAR(100),
    complaintDetails NVARCHAR(500),
    resolutionDetails NVARCHAR(500),
    primary key (fullName)
);

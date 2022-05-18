create database if not exists staffdata;

create table branch(
branchNo int primary key,
address varchar(100),
street varchar(64),
city varchar(50),
zipcode int) ;

create table staff(
staffNo int primary key,
name varchar(100),
position varchar(50),
salary int,
branchNo int,
foreign key(branchNo) references branch(branchNo) on update cascade on delete cascade
);

create table fulltime(
staffNo int primary key,
salaryScale int,
holidayAllowance int,
foreign key (staffNo) references staff(staffNo) on update cascade on delete cascade
);

create table parttime(
staffNo int primary key,
hourlyrate int,
foreign key (staffNo) references staff(staffNo) on update cascade on delete cascade
);

create table role_specific(
staffNo int primary key,
is_Manager bool,
is_Sales bool,
is_Secretary bool,
mgrStartDate date,
bonus decimal(9,2),

);

-- create table -- 
drop database if exists Notown_musician_album;
create database Notown_musician_album;
use Notown_musician_album;

create table instrument(
instrumentId int primary key,
name varchar(50),
musicial_key varchar(30)
);

create table musician(
ssn int primary key,
name varchar(100),
address varchar(200),
phone_number int
);

create table album(
albumId int primary key,
title varchar(100),
copyright_date date,
formate varchar(50),
identifier varchar(100),
producer_ssn int,
foreign key (producer_ssn) references musician(ssn) on update restrict on delete restrict
);

create table song(
songId int primary key,
title varchar(50),
author_ssn int,
albumId int,
foreign key (author_ssn) references musician(ssn) on update restrict on delete restrict,
foreign key (albumId) references album(albumId) on update restrict on delete restrict 
);

create table musician_play_instrument(
instrumentId int,
musician_ssn int,
primary key (instrumentId, musician_ssn),
foreign key (instrumentId) references instrument(instrumentId) on update restrict on delete restrict,
foreign key (musician_ssn) references musician(ssn) on update restrict on delete restrict
);

create table musician_perform_song(
songId int,
musician_ssn int,
primary key (songId, musician_ssn),
foreign key (songId) references song(songId) on update restrict on delete restrict,
foreign key (musician_ssn) references musician(ssn) on update restrict on delete restrict
);

drop database if exists Dane_County_Airport;
create database Dane_County_Airport;
use Dane_County_Airport;

create table employee_union(
unionId int primary key,
job_performed varchar(100)
);

create table employee(
ssn int primary key,
union_membership_No int not null,
unionId int not null,
foreign key (unionId) references employee_union(unionId) on update cascade on delete restrict
);

create table traffic_controller(
employee_ssn int primary key,
exam_date date,
foreign key (employee_ssn) references employee(ssn) on update cascade on delete cascade
);

create table technician(
employee_ssn int primary key,
tech_name varchar(100) not null,
address varchar(200),
phone_number int,
salary int,
foreign key (employee_ssn) references employee(ssn) on update cascade on delete cascade
);

 create table plane_model(
 modelNo int primary key,
 capacity int not null,
 weight int
 );
 
 create table airplane(
 registrationNo int primary key,
 modelNo int,
 foreign key (modelNo) references plane_model(modelNo) on update cascade on delete cascade
 );
 
 create table plane_model_to_technician(
 modelNo int,
 technician_ssn int,
 primary key (modelNo, technician_ssn),
 foreign key (modelNo) references plane_model(modelNo) on update cascade on delete cascade,
 foreign key (technician_ssn) references technician(employee_ssn) on update cascade on delete cascade
 );
 
 drop database if exists car_insurance_company;
 create database car_insurance_company;
 use car_insurance_company;
 
 create table customer(
 ssn int primary key
 );
 
 create table insurance_policy(
 policyNo int primary key,
 customer_ssn int,
 foreign key (customer_ssn) references customer(ssn) on update cascade on delete cascade
 );
 
 create table car(
 licenceNo int primary key,
 customer_ssn int,
 policyNo int,
 foreign key (customer_ssn) references customer(ssn) on update cascade on delete cascade,
 foreign key (policyNo) references insurance_policy(policyNo) on update cascade on delete cascade
 );
 
 create table accident(
 accidentId int primary key,
 accident_date date,
 location varchar(100),
 cost int,
 carNo int,
 foreign key (carNo) references car(licenceNo) on update cascade on delete cascade
 );
 
 create table payment(
 paymentId int primary key,
 time_period varchar(100) not null,
 due_date date,
 received_date date,
 policyNo int,
 foreign key (policyNo) references insurance_policy(policyNo) on update cascade on delete cascade
);
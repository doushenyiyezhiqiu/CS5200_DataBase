drop database if exists hw4Problem1_PerfectPets;
create database hw4Problem1_PerfectPets;
use hw4Problem1_PerfectPets;

create table petowner(
ownerId int primary key
);

create table clinic(
clinicNo int primary key
);

create table staff(
staffNo int primary key,
clinicNo int,
foreign key (clinicNo) references clinic(clinicNo) on update restrict on delete restrict
);

create table manager(
staffNo int,
clinicNo int,
primary key (staffNo, clinicNo),
foreign key (staffNo) references staff(staffNo) on update restrict on delete restrict,
foreign key (clinicNo) references clinic(clinicNo) on update restrict on delete restrict
);

create table pet(
petNo int primary key,
ownerId int,
clinicNo int,
foreign key (ownerId) references petowner(ownerId) on update restrict on delete restrict,
foreign key (clinicNo) references clinic(clinicNo) on update cascade on delete restrict
);

create table examination(
examNo int primary key,
staffNo int,
petNo int,
foreign key (staffNo) references staff(staffNo) on update cascade on delete set null,
foreign key (petNo) references pet(petNo) on update cascade on delete cascade
);

create table treatment(
treatNo int primary key,
petNo int,
examNo int,
foreign key (petNo) references pet(petNo) on update cascade on delete cascade,
foreign key (examNo) references examination(examNo) on update cascade on delete cascade
);

drop database if exists hw4Problem2_RegionalSchools;
create database hw4Problem2_RegionalSchools;
use hw4Problem2_RegionalSchools;

create table school(
schoolId int primary key,
schoolName varchar(64),
phone_number int
);

create table schoolAddr(
schoolId int primary key,
town varchar(30),
street varchar(50),
zip_code int,
foreign key (schoolId) references school(schoolId) on update cascade on delete cascade
);

create table pupil(
pupilId int primary key,
sex varchar(10),
birthdate date,
schoolId int,
foreign key (schoolId) references school(schoolId) on update cascade on delete restrict
);

create table pupilName(
pupilId int primary key,
first_name varchar(50),
last_name varchar(50),
foreign key (pupilId) references pupil(pupilId) on update cascade on delete cascade
);

create table teacher(
NIN int primary key,
sex varchar(10),
qualifications varchar(200),
schoolId int,
foreign key (schoolId) references school(schoolId) on update restrict on delete restrict
);

create table teacherName(
NIN int primary key,
first_name varchar(50),
last_name varchar(50),
foreign key (NIN) references teacher(NIN) on update cascade on delete cascade
);

create table manager(
NIN int,
schoolId int,
start_date date,
primary key (NIN, schoolId),
foreign key (NIN) references teacher(NIN) on update restrict on delete restrict,
foreign key (schoolId) references school(schoolId) on update restrict on delete restrict
);

create table subject_list(
subjectNo int primary key,
title varchar(100),
subjectType varchar(50)
);

create table pupil_to_subject(
pupilId int,
subjectNo int,
primary key (pupilId, subjectNo),
foreign key (pupilId) references pupil(pupilId) on update restrict on delete restrict,
foreign key (subjectNo) references subject_list(subjectNo) on update restrict on delete restrict
);

create table teacher_to_subject(
NIN int,
subjectNo int,
hours_required int,
primary key (NIN, subjectNo),
foreign key (NIN) references teacher(NIN) on update restrict on delete restrict,
foreign key (subjectNo) references subject_list(subjectNo) on update restrict on delete restrict
);

drop database if exists hw4Problem3_BusyBee;
create database hw4Problem3_BusyBee;
use hw4Problem3_BusyBee;

create table clean_group(
groupNo int primary key
);

create table clean_staff(
staffNo int primary key,
is_supervisor bool,
groupNo int,
foreign key (groupNo) references clean_group(groupNo) on update restrict on delete restrict
);

create table supervisor(
staffNo int primary key,
groupNo int,
foreign key (staffNo) references clean_staff(staffNo) on update restrict on delete restrict,
foreign key (groupNo) references clean_group(groupNo) on update restrict on delete restrict
);

create table administrator(
staffNo int primary key
);

create table office_work(
work_content varchar(50) primary key
);

create table adminstrator_office_work(
admin_no int,
work_content varchar(50),
primary key (admin_no, work_content),
foreign key (admin_no) references administrator(staffNo) on update restrict on delete restrict,
foreign key (work_content) references office_work(work_content) on update restrict on delete restrict
); 

create table client_list(
clientId int primary key,
company_name varchar(100),
client_type varchar(20)
);

create table job(
jobNo int primary key,
specific_time date not null,
specific_requirement varchar(300) not null,
clientId int,
admin_no int,
supervisor_no int,
foreign key (clientId) references client_list(clientId) on update cascade on delete cascade,
foreign key (admin_no) references administrator(staffNo) on update restrict on delete restrict,
foreign key (supervisor_no) references supervisor(staffNo) on update restrict on delete restrict
);

create table equipment(
equipmentId int primary key,
equipment_type varchar(20)
);

create table equipment_to_job(
jobNo int,
equipmentId int,
primary key (jobNo, equipmentId),
foreign key (jobNo) references job(jobNo) on update restrict on delete restrict,
foreign key (equipmentId) references equipment(equipmentId) on update restrict on delete restrict
);

create table cleaning_staff_to_job(
staffNo int,
jobNo int,
hours_required int,
primary key(staffNo, jobNo),
foreign key (staffNo) references clean_staff(staffNo) on update restrict on delete restrict,
foreign key (jobNo) references job(jobNo) on update restrict on delete restrict
);

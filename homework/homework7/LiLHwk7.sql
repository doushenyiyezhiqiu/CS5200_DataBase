use lotrfinal_lil;

-- question1 --
drop procedure if exists track_character;

delimiter $$
create procedure track_character(
	in character_name varchar(255))
begin
select character1_name as character_selected, region_name, title as book_name, character2_name as encounter_character
from lotr_first_encounter join lotr_book using(book_id)
where character1_name = character_name
union all
select character2_name as character_selected, region_name, title as book_name, character1_name as encounter_character
from lotr_first_encounter join lotr_book using(book_id)
where character2_name = character_name
; 
end$$

delimiter ;

-- test question1 code --
call track_character('frodo');
call track_character('gimli');
call track_character('fro');

-- question2 --
drop procedure if exists track_region;

delimiter $$
create procedure track_region(
	in region varchar(255))
begin
declare encounter_num int;
declare book_name, rleader varchar(255);

select count(*) into encounter_num
from lotr_first_encounter where region_name = region;

select title into book_name from lotr_book
join lotr_first_encounter using(book_id)
where region_name = region
limit 1;

select leader into rleader from lotr_region
where region_name = region;

select region, book_name, encounter_num, rleader;
end $$

delimiter ;

-- test question2 code --
call track_region('bree');
call track_region('shire');
call track_region('lonely mountain');
call track_region('rivendell');
call track_region('ldsfjhlskd');

-- question3 --
drop function if exists strongerSpecie;
delimiter //
create function strongerSpecie
(
	sp1 varchar(255),
    sp2 varchar(255)
)
returns int
deterministic reads sql data
begin
	declare sp1_size, sp2_size int;
    select size into sp1_size from lotr_species
    where sp1 = species_name;
	select size into sp2_size from lotr_species
    where sp2 = species_name;
    if sp1_size > sp2_size then
		return 1;
	elseif sp1_size < sp2_size then
		return -1;
	else
		return 0;
	end if;
end //

-- test question3 code --
set @s1 = 'elf';
set @s2 = 'human';
select strongerSpecie(@s1, @s2);
set @s3 = 'elf';
set @s4 = 'ent';
select strongerSpecie(@s3, @s4);
set @s5 = 'orc';
select strongerSpecie(@s2, @s5);

-- question4 --

-- with t as(
-- select region_name, count(*) as encounter_total
-- from lotr_first_encounter
-- where character1_name = 'aragorn' or character2_name = 'aragorn'
-- group by region_name)
-- select region_name from t where
-- encounter_total = 
-- (select max(encounter_total) from t);

drop function if exists region_most_encounters;

deilimiter //
create function region_most_encounters(
character_name varchar(255)
)returns varchar(255)
deterministic reads sql data
begin
	declare result varchar(255);
    with t as(
    select region_name, count(*) as encounter_total
    from lotr_first_encounter
    where character1_name = character_name or character2_name = character_name
    group by region_name)
    select region_name into result from t where
    encounter_total = (select max(encounter_total) from t)
    limit 1;
    return result;
end //

-- test question4 code --
select region_most_encounters('aragorn');
select region_most_encounters('gimli');
select region_most_encounters('elrond');
select region_most_encounters('erlond');

-- question5 --

drop function if exists home_region_encounter;

delimiter //
create function home_region_encounter(
character_name varchar(255)
) returns varchar(255)
deterministic reads sql data
begin
	declare temp_h, temp_r varchar(255);

	select homeland into temp_h 
    from lotr_character
    where lotr_character.character_name = character_name;
    
    if  (temp_h IS null)  then
		return 'NULL';
	end if;
    select distinct region_name into temp_r from lotr_first_encounter
    where (character1_name = character_name or character2_name = character_name)
    and region_name = temp_h;
    if temp_r = temp_h then 
		return 'TRUE';
	else
		return 'FALSE';
	end if;
end //

-- test question5 code --
select home_region_encounter('frodo');
select home_region_encounter('gimli');
select home_region_encounter('sauron');
select home_region_encounter('elrond');
select home_region_encounter('erlond');

-- question6 --
drop function if exists encounters_in_num_region;

delimiter //
create function encounters_in_num_region(
region_name varchar(255)
)returns int
deterministic reads sql data
begin
	declare res int;
    select count(*) into res 
    from lotr_first_encounter l1
    where l1.region_name = region_name;
    return res;
end //

-- test question6 code --
select encounters_in_num_region('rivendell');
select encounters_in_num_region('lonely mountain');
select encounters_in_num_region('river');

-- question7 --
-- select distinct character1_name as namel from lotr_first_encounter
-- join lotr_book using(book_id)
-- where lotr_book.title = 'the fellowship of the ring'
-- union all
-- select distinct character2_name as namel from lotr_first_encounter
-- join lotr_book using(book_id)
-- where lotr_book.title = 'the fellowship of the ring';

drop procedure fellowship_encounters;

delimiter $$
create procedure fellowship_encounters(
in book varchar(255))
begin
with t as(
select distinct character1_name as namel
from lotr_first_encounter join lotr_book using(book_id)
where lotr_book.title = book
union all
select distinct character2_name as namel 
from lotr_first_encounter join lotr_book using(book_id)
where lotr_book.title = book
) select character_name, species, homeland, royalty, fellowship, survive, alias,
book_number_introduction
from lotr_character join (
select distinct namel from t) t1
on t1.namel = lotr_character.character_name;
end $$
delimiter ;

-- test quesion7 code --
call fellowship_encounters('the fellowship of the ring');
call fellowship_encounters('the two towers');
call fellowship_encounters('the return of the king');

-- question8 --
alter table lotr_book add encounters_in_book int;

drop procedure if exists initialize_encounters_count;

delimiter $$
create procedure initialize_encounters_count(
in book int
)
begin
declare countb int;
select count(*) into countb from lotr_first_encounter
where book_id = book;
update lotr_book set encounters_in_book = countb where book_id = book;
select * from lotr_book;
end $$

 delimiter ;
 
 -- test question8 code --
 call initialize_encounters_count(1);
 call initialize_encounters_count(2);
 call initialize_encounters_count(3);
 call initialize_encounters_count(4);
 
 -- question9 --
-- alter table lotr_book add encounters_in_book int;
drop trigger if exists firstencounters_after_insert;
call initialize_encounters_count(1);
call initialize_encounters_count(2);
call initialize_encounters_count(3);

delimiter //
create trigger firstencounters_after_insert
after insert on lotr_first_encounter
for each row
begin
update lotr_book set encounters_in_book = encounters_in_book+1 
where book_id = NEW.book_id;
end //

-- test question9 code --
insert into lotr_first_encounter 
values ('legolas', 'frodo', 1, 'rivendell');

select * from lotr_book;

-- update lotr_book set encounters_in_book = 6 where book_id = 1;
-- delete from lotr_first_encounter where character1_name = 'legolas' and character2_name = 'frodo';

-- question10 --
prepare stmt10 from 'select home_region_encounter(?)';

set @argu10='Aragorn';

execute stmt10 using @argu10;

-- question11 --
prepare stmt11 from 'select region_most_encounters(?)';

set @argu11='Aragorn';

execute stmt11 using @argu11;
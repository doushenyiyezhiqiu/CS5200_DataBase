-- Name: Liangshe Li --
-- Before importing data, I change the name of database to "lotrfinal_lil" instead of "lotrfinal_1" --  
use lotrfinal_lil;

-- problem1 --

select character_name, count(*) as encounter_total 
from lotr_character join lotr_first_encounter  
on character_name = character1_name or character_name = character2_name 
group by character_name;

-- problem2 --

-- I first select the total amount of visited regions which is not homeland for each character.
-- And then name it as "t", the amount of visited regions is named by "no_home_region"
-- in the final select, I will plus no_home_region(use ifnull() to transfer from null to 0) and 1
 
-- it is my first draft
-- select character_name , count(distinct region_name) as no_home_total 
-- from lotr_character left join lotr_first_encounter 
-- on character_name = character1_name or character_name = character2_name
-- where homeland != region_name
-- group by character_name
-- ; 

with t as (
select character_name as c_name, count(distinct region_name) as no_home_total 
from lotr_character join lotr_first_encounter 
on character_name = character1_name or character_name = character2_name
where homeland != region_name
group by c_name
) select character_name, (ifnull(no_home_total,0)+1) as visited_region_total 
from lotr_character left join t 
on character_name=c_name 
group by character_name;

-- problem3 --

select count(*) from lotr_region where major_species='hobbit';
-- After running the query above, I get that the number of regions whose majority species is ‘hobbit’ is 1. --

-- problem4 --

with t as  
(select region_name as r_name, count(*) as r_total 
from lotr_first_encounter 
group by r_name)
select r_name from t 
where r_total=(select max(r_total) from t);
-- After running the query above, I get that "riverndell" has the most number of first encounters.

-- problem5 --

-- select region_name, count(distinct character_name) as no_home_total 
-- from lotr_first_encounter left join lotr_character
-- on character_name = character1_name or character_name = character2_name 
-- where homeland!=region_name
-- group by region_name;

-- select homeland, count(character_name)
-- from lotr_character
-- group by homeland;

with t as(
select region_name, count(distinct character_name) as no_home_total 
from lotr_first_encounter left join lotr_character
on character_name = character1_name or character_name = character2_name 
where homeland!=region_name
group by region_name
) select l.region_name as region, (ifnull(no_home_total,0)+ifnull(home_total,0)) as visit_total
from lotr_region l left join t using(region_name)
left join (select homeland, count(character_name) as home_total
from lotr_character
group by homeland) as h
on homeland=l.region_name
group by l.region_name;

select region from
(with t as(
select region_name, count(distinct character_name) as no_home_total 
from lotr_first_encounter left join lotr_character
on character_name = character1_name or character_name = character2_name 
where homeland!=region_name
group by region_name
) select l.region_name as region, (ifnull(no_home_total,0)+ifnull(home_total,0)) as visit_total
from lotr_region l left join t using(region_name)
left join (select homeland, count(character_name) as home_total
from lotr_character
group by homeland) as h
on homeland=l.region_name
group by l.region_name) as tot
where visit_total = (select count(distinct character_name) from lotr_character);
-- After running the query above, I find that no region has been visited by all characters.

-- problem6 --
create table book1_encounters 
as select * from lotr_first_encounter 
where book_id=1;

-- problem7 --
select l1.book_id, l1.title from lotr_book as l1 
left join lotr_first_encounter as l2 
using(book_id) 
where (l2.character1_name='Frodo' and l2.character2_name='Faramir') 
or (l2.character2_name='Frodo' and l2.character1_name='Faramir'); 

-- problem8 --

select region_name , group_concat(character_name) as grouped_character_name 
from lotr_region left join lotr_character 
on region_name = homeland
group by region_name;

-- problem9 --
with t as
(select species, count(*) as s_total from lotr_character 
group by species)
select species from t where s_total=(select max(s_total) from t);
-- After running the query above, I get that "human" and "maiar" are the largest species.

-- preblem10 --

select count(*) from lotr_character where species='human';
-- After running the query above, I get that the number of characters whose species is ‘human’ is 3. --

-- problem11 --

create table HumanHobbitFirstEncounters 
as select * from lotr_first_encounter 
where (character1_name in (select character_name from lotr_character where species="human" ) 
and character2_name in (select character_name from lotr_character where species="hobbit"))
or (character1_name in (select character_name from lotr_character where species="hobbit") 
and character2_name in (select character_name from lotr_character where species="human"));

-- problem12 --
select character_name from lotr_character where homeland='gondor';

-- problem13 --

select count(*) from lotr_character where species='hobbit';
-- After running the query above, I get that the number of characters whose species is listed as ‘hobbit’ is 1. --

-- problem14 --

select region_name, ifnull(count(distinct character_name),0) as eachhome_character_total 
from lotr_region left join lotr_character  
on region_name = homeland 
group by region_name;

-- problem15 --

select character_name, ifnull(count(*), 0) as encounters 
from lotr_character left join lotr_first_encounter  
on character_name = character1_name or character_name = character2_name 
group by character_name;
create database if not exists premierLiL;
use premierlil;

-- problem123 --
alter table epl_managers add foreign key (Team) references epl_stadiums(Team) on update restrict on delete restrict;
alter table epl_matcheepl_managerss add foreign key (`Team 1`) references epl_stadiums(Team) on update restrict on delete restrict;
alter table epl_matches add foreign key (`Team 2`) references epl_stadiums(Team) on update restrict on delete restrict;

-- problem4 --
select `Match number`, `Team 1` as home_team, `Team 2` as away_team from epl_matches 
where `Match day`=1 and `Full time score team 1`>`Full time score team 2`;

-- problem5 --
select Team, count(distinct Manager) as manager_total from epl_managers
group by Team having manager_total>1;

-- problem6 --
select Manager, count(distinct Team) as team_total from epl_managers
group by Manager having team_total>1;

-- problem7 --
select Manager, `Team 1` as home_team, sum(`Full time score team 1`) as home_scoreTotal 
from epl_matches  join epl_managers on `Team 1`=Team
where `Status`='Active' group by Manager order by home_scoreTotal desc;

-- problem8 --
select Manager, count(*) as total_win from epl_managers join epl_matches
on (`Team 1`=Team  and `Full time score team 1`>`Full time score team 2`) or
(`Team 2`=Team  and `Full time score team 2`>`Full time score team 1`)
where `Status`='Active' group by Manager order by total_win desc; 

-- problem9 --
-- select Venue as stadium, sum(`Full time score team 1`)+sum(`Full time score team 2`) as score_total
-- from epl_stadiums left join epl_matches
-- on Team=`Team 1`
-- group by stadium;

with t as(
select Venue as stadium, sum(`Full time score team 1`)+sum(`Full time score team 2`) as score_total
from epl_stadiums left join epl_matches
on Team=`Team 1`
group by stadium
) select stadium from t
where score_total = (select max(score_total) from t);

-- problem10 --
select Team, count(*) as draw_total from epl_stadiums join epl_matches
on Team = `Team 1` or Team = `Team 2`
where `Full time score team 1`=`Full time score team 2`
group by Team;

-- problem11 --
select Team, count(*) as clean_sheet
from epl_matches join epl_stadiums
on Team=`Team 1` or Team=`Team 2`
where (Team=`Team 1` and `Full time score team 2`=0)
or(Team=`Team 2` and `Full time score team 1`=0)
group by Team order by clean_sheet desc limit 5;

-- problem12 --
select * from epl_matches
where (`Date` between '2017-12-25' and '2018-01-03')
and `Full time score team 1`>2;

-- problem13 --
select * from epl_matches
where (`Half time score team 1`>`Half time score team 2` and `Full time score team 1`<`Full time score team 2`) 
or (`Half time score team 1`<`Half time score team 2` and `Full time score team 1`>`Full time score team 2`);

-- problem14 --
with t as(
select Team as team_name, count(*) as win_total from epl_stadiums
join epl_matches on Team=`Team 1` or Team=`Team 2`
where (Team=`Team 1` and `Full time score team 1`>`Full time score team 2`)
or (Team=`Team 2` and `Full time score team 2`>`Full time score team 1`)
group by Team order by win_total desc limit 5
) select team_name from t;

-- problem15 --
-- select Team as h_team, avg(`Full time score team 1`) as avg_home_score, avg(`Full time score team 2`) as avg_home_concede
-- from epl_matches right join epl_stadiums on Team=`Team 1`
-- group by h_team;

-- select Team as a_team, avg(`Full time score team 2`) as avg_away_score, avg(`Full time score team 1`) as avg_away_concede
-- from epl_matches right join epl_stadiums on Team=`Team 2`
-- group by a_team;

with t as(
select Team as h_team, avg(`Full time score team 1`) as avg_home_score, avg(`Full time score team 2`) as avg_home_concede
from epl_matches right join epl_stadiums on Team=`Team 1`
group by h_team
) select h_team, avg_home_score, avg_home_concede, avg_away_score, avg_away_concede
from t join(
select Team as a_team, avg(`Full time score team 2`) as avg_away_score, avg(`Full time score team 1`) as avg_away_concede
from epl_matches right join epl_stadiums on Team=`Team 2`
group by a_team
) as a on a_team=h_team
group by h_team;
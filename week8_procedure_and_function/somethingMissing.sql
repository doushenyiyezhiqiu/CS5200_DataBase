DELIMITER $$
create procedure credit_increase(in increase int,
in id_p int)

begin
if(increase < 10) then
update student set credit_earned = credit_earned+increase where id=id_p;
elseif (increase>100) then
	select "Increase to large for a transaction";
else select "no update done";
end if;
end$$

DELIMITER ;

delimiter $$
create procedure try_out(out d int,
						inout id_p int)
begin
set id_p = id_p +1;
set d = 20;
end $$

delimiter ;

set @i=4;

-- loop
delimiter $$
create procedure iterator2(n int)

begin
while n>0 do
select n;
set n=n-1;
end while;
end$$
delimiter ;

call iterator(5);

delimiter ##
create procedure walk_students()
begin
declare row_not_found, student_id_var, credit_var int;
declare name_var, school_var, major_var varchar(30);

declare student_major_c cursor for
	select id, name, credit_earned, major
		from student_major inner join student on student.id=
			student_major.student_id;
declare continue handler for not found
	set row_not_found = true;

set row_not_found = false;

open student_major_c;
while row_not_found = false do
	fetch student_major_c into student_id_var, name_var,
		credit_var, major_var;
	select student_id_var, name_var, 
			credit_var, major_var;
end while;
close student_major_c;
end$$

delimiter ;
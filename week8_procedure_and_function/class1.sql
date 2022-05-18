set @code=0;
select @COD;

use student;
select id, name into @code, @name from student
order by id limit 1;

select @code, @name;

select * from student where id=@code;

-- procedure

-- create procedure test1()
-- begin
-- end;

-- delimiter $$
-- create procedure test2()
-- begin
-- declare i int;
-- end$$

-- delimiter ;

-- call test2();

-- delimiter $$
-- create procedure credit_increase1(in increase int,
-- 								in id_p int)
-- begin
-- declare i int;
-- update student set credit_earned = credit_earned + increase 
-- where id=id_p;
-- end$$

-- delimiter ;

-- call credit_increase1(2,2);

delimiter $$
create procedure credit_increase3(in increase int,
								in id_p int)
begin
declare i int;
if (increase<10) then
	update student set credit_earned = credit_earned + increase 
	where id=id_p;
elseif (increase>100) then
	select"Increase too large for a transaction";
else
	select"No update done";
end if;
end$$

delimiter ;

call credit_increase3(101,2);

call credit_increase3(50,2);

delimiter $$
create procedure try_out(out d int,
						inout id_p int)
begin
set id_p = id_p+1;
set d=20;
end$$

set @i=4;
call try_out(@w, @i);
select @w, @i;

-- loop
delimiter $$
create procedure iterator(n int)
begin
while n>0 do
	select n;
    set n=n-1;
end while;
end$$

delimiter ;

call iterator(5);

delimiter $$
create procedure walk_students()
begin
declare row_not_found, student_id_var, credit_var int;
declare name_var, school_var, major_var varchar(30);

declare student_major_c cursor for
	select id, name, credit_earned, major
		from student_major inner join student on student.id = 
			student_major.student_id;

declare continue handler for not found
	set row_not_found = true;

set row_not_found = false;

open student_major_c;

while row_not_found = false do
	fetch student_major_c into student_id_var, name_var,
		credit_var, major_var;
	select  student_id_var, name_var,
		    credit_var, major_var;
end while;
close student_major_c;
        
end$$
delimiter ;

call walk_student();


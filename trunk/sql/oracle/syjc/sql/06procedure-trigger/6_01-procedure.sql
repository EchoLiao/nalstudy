create or replace procedure count_grade 
    (zym in char, person_num out number)
as 
begin 
    select count(*)
	into person_num 
	from xs 
	where zym = zym and zxf > 40;
end count_grade;
/

declare 
    num number;
begin 
    execute count_grade('¼ÆËã»ú', num);
end;
/

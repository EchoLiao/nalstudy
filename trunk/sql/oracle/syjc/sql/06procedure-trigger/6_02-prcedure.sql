create or replace procedure update_info
( xm in varchar2 )
as
    xf number(2);
begin
    select zxf
	into xf
	from xs
	where xm = xm
    if xf > 60 then
	update xs set bz = '四好学生'
	    where xm = xm;
    end if;
    if xf < 45 then
	update xs set bz = '学分未修满'
	    where xm = xm;
    end if;
end update_info;
/

execute update_info('张子');

/* select * from xs; */

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
	update xs set bz = '�ĺ�ѧ��'
	    where xm = xm;
    end if;
    if xf < 45 then
	update xs set bz = 'ѧ��δ����'
	    where xm = xm;
    end if;
end update_info;
/

execute update_info('����');

/* select * from xs; */

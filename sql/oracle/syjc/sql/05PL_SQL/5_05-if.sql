set ServerOutput on;
declare 
    v_num number(3);


begin 
    select count(*) into v_num 
	from xs 
	where zxf > 40;

    if v_num != 0 then 
	dbms_output.put_line('zxf´óÓÚ40: ' || to_char(v_num));
    else
	dbms_output.put_line('TEST');
    end if;
end;
/

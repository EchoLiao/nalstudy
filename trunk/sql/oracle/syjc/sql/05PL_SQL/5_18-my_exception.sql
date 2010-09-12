declare 
    e_overnumber exception;
    v_xs_number number(9);
    v_max_xs_number number(9) := 5;

begin 
    select count(*) into v_xs_number 
	from xs; 
    if v_max_xs_number < v_xs_number then 
	raise e_overnumber; 
    end if; 
    exception 
    when e_overnumber then 
	dbms_output.put_line('current: ' || v_xs_number || 
	    ',  max: ' || v_max_xs_number);
end;
/

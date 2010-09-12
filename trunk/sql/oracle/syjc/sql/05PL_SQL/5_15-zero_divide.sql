declare 
    v_number number(2) := 10;
    v_zero number(2) := 0;
    v_result number(5);

begin 
    v_result := v_number / v_zero;
    exception  /*  */ 
    when zero_divide then 
	dbms_output.put_line('ZERO DIVIDE');
end;
/

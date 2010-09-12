/* ×ª»»´íÎó´¦Àí */
declare 
    v_number number(5);
    v_result char(5) := '2w';

begin 
    v_number := to_number(v_result);
    exception 
    when value_error then 
	dbms_output.put_line('CONVERT TYPE ERROR');
end; 
/

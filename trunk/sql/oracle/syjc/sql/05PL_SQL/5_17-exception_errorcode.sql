declare 
    v_result xs.xm%type;   /* v_result 与表 xs 中字段 xm 相同 */ 

begin 
    select xm into v_result 
	from xs 
	where xm = '李红2';
	dbms_output.put_line('name is: ' || v_result);
    exception 
    when too_many_rows then 
	dbms_output.put_line('there has TOO_MANY_ROWS error');
    /* when no_data_found then  */
	/* dbms_output.put_line('NO_DATA_FOUND error'); */
    when others then 
	/* dbms_output.put_line('Unkown error'); */
	dbms_output.put_line('error code: ' || sqlcode);
	dbms_output.put_line('error string: ' || sqlerrm);
end;
/

declare 
type name is table of varchar2(20) index by binary_integer;
type pwd is table of varchar2(20);
type dates is varray(7) of varchar2(20); /* 可变数组 */ 
v_name name ;
v_pwd pwd := pwd('100', '12345', '22', 'yes', 'no');
v_dates dates := dates('Monday', 'Sunday');

begin 
    v_name(1) := 'Tom';
    v_name(-1) := 'Jack';
    v_name(4) := 'Rose';
    dbms_output.put_line(v_name.count); /* 求长度 */ 
    dbms_output.put_line(v_pwd.count);
    dbms_output.put_line(v_dates.count);
end;
/

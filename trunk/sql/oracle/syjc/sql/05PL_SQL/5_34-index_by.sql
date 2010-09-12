/* 联合数组 */
/* 联合数组属于非连续存储 */
declare
type xs_name 
is table of xs.xm%type index by binary_integer;
v_name xs_name;
begin 
    v_name(1) := 'adb';
    v_name(-2) := 'alfj';
    v_name(9) := 'jlajfo';
    dbms_output.put_line(v_name(-2));
end;
/

/* ====================================================================== */

declare 
type studytab 
is table of varchar2(20) index by binary_integer;
v_studytab studytab;
begin 
    for v_count in 1..5 loop 
	v_studytab(v_count) := v_count * 10;
    end loop; 
    for v_count in 1..5 loop 
	dbms_output.put_line(v_studytab(v_count));
    end loop;
end;
/

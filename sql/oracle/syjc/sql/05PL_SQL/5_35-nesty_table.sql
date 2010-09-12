/* 嵌套表 */
/* 嵌套表属于连续存储 */
set ServerOutput on;
Declare 
type studytab 
is table of varchar(20);
v_studytab studytab := studytab('Tom', 'Jack', 'Rose'); /* 嵌套表必须要初始化 */ 

begin 
    for v_count in 1..8 loop 
	dbms_output.put_line(v_studytab(v_count));
    end loop;
end;
/

/* Ƕ�ױ� */
/* Ƕ�ױ����������洢 */
set ServerOutput on;
Declare 
type studytab 
is table of varchar(20);
v_studytab studytab := studytab('Tom', 'Jack', 'Rose'); /* Ƕ�ױ����Ҫ��ʼ�� */ 

begin 
    for v_count in 1..8 loop 
	dbms_output.put_line(v_studytab(v_count));
    end loop;
end;
/

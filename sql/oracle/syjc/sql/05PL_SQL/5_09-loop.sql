/* �� 10 �Ľ׳� */
declare 
    n number:=1;
    count1 number:=2; /* count Ϊϵͳ���� */ 

begin 
    loop 
	n := n*count1;
	count1 := count1 + 1;
	if count1 > 10 then 
	    exit;
	end if;
    end loop; 
    dbms_output.put_line(to_char(n));
end;
/

/* 求 10 的阶乘 */
declare 
    n number:=1;
    count1 number:=2; /* count 为系统函数 */ 

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

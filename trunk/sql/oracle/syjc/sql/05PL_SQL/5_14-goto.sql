declare 
    n number := 1;
    count1 number; 
begin 
    for count1 in 2 .. 100 
    loop 
	n := n * count1; 
	if count1 = 10 then 
	    goto loop_end;
	end if;
    end loop; 

    <<loop_end>> /* goto ±Í÷æ */ 
    dbms_output.put_line(to_char(n));
end;
/

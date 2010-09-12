declare 
    n number := 1;
    count1 number; 
begin 
    for count1 in 2 .. 10 
    loop 
	n := n * count1; 
    end loop; 
    dbms_output.put_line(to_char(n));
end;
/

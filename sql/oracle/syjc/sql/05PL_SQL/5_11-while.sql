declare 
    n number := 1;
    count1 number := 2;

begin 
    while count1 <= 10 
    loop 
	n := n*count1; 
	count1 := count1 + 1;
    end loop;
    dbms_output.put_line(to_char(n));
end;
/

create or replace procedure cs_xm 
(
    in_xh in char,
    out_xm out char
)
as 
begin 
    select xm into out_xm 
	from xs 
	where xh = in_xh; 
    dbms_output.put_line(out_xm);
end cs_xm;
/ 

begin
    execute cs_xm('061102'); /* QQQQQ */ 
end;
/

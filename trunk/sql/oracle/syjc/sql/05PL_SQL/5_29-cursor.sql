set ServerOutput on;
declare cursor xs_cur2 is
select xh, xm, zxf
    from xs;
begin
    open xs_cur2;
    dbms_output.put_line(xs_cur2%ROWCOUNT);
end;
/


declare
    v_xh char(6);
    v_zxf number(2);
    cursor xs_cur3 is
    select xh, zxf
	from xs
	where zym = '计算机';
begin
    if not xs_cur3%ISOPEN then /* 游标未打开? */
	open xs_cur3;
    end if;
    fetch xs_cur3 into v_xh, v_zxf;
    dbms_output.put_line(xs_cur3%ROWCOUNT); /* ROWCOUNT 表示当前处理到第几行 */
    while xs_cur3%FOUND /* 若还有数据 */  /* NOFOUND */
	loop
	    dbms_output.put_line(v_xh || ' ' || v_zxf);
	    dbms_output.put_line(xs_cur3%ROWCOUNT); /* ROWCOUNT 表示当前处理到第几行 */
	    fetch xs_cur3 into v_xh, v_zxf;
	end loop;
    if xs_cur3%ISOPEN then
	close xs_cur3;
    end if;
end;
/

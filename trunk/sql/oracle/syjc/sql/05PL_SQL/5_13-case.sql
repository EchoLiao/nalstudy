declare 
    v_kch char(3);
    v_result varchar2(16);

begin 
    select kch 
	into v_kch 
	from kc 
	where kkxq = '2';

    CASE v_kch  /* 结果集 v_kch 中必须只有一个元素或没有元素才能正常执行 */ 
	when '102' then v_result:='大学英语';
	when '105' then v_result:='线性代数';
	else 
	    v_result := 'Nothing';
    end case;

    dbms_output.put_line(v_result);
end; 
/


declare 
    v_kch char(3);
    v_result varchar2(16);

begin 
    select kch 
	into v_kch 
	from kc 
	where kkxq = '2';

    CASE v_kch  /* ����� v_kch �б���ֻ��һ��Ԫ�ػ�û��Ԫ�ز�������ִ�� */ 
	when '102' then v_result:='��ѧӢ��';
	when '105' then v_result:='���Դ���';
	else 
	    v_result := 'Nothing';
    end case;

    dbms_output.put_line(v_result);
end; 
/


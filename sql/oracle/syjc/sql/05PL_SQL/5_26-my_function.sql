/* ��ȫ��ѧ����ƽ���ɼ� */
/* �������� */
create or replace function averae
    ( cnum in char ) /* �γ̺� */
    return number
as
    avger number;

begin
    select avg(cj) into avger
	from xs_kc
	where kch = cnum
	group by kch;
    return (avger);
end averae;
/
/* / ����Ҫ�� MMMMM */


/* �������� */
begin
    dbms_output.put_line(to_char(averae(101)));
end;
/


/* ɾ������ */
drop function averae;

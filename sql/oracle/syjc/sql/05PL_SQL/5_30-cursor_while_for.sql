drop table temp_cj;
create table temp_cj
(	xh char(6) not null,
	kch char(3) not null, /* ��С���ȱ���Ҫ��� CK �е�һ�� MMMMM */ 
	cj number(2) null
)
tablespace myts;

declare 
    v_xh char(6);
    v_kch char(3);
    v_cj number(2);
    cursor kc_cur is 
	select xh, kch, cj 
	    from xs_kc; 

begin 
    open kc_cur;
    fetch kc_cur into v_xh, v_kch, v_cj; 
    while kc_cur%FOUND LOOP 
	if v_cj < 60 then 
	    insert into temp_cj values(v_xh, v_kch, v_cj);
	end if; 
	fetch kc_cur into v_xh, v_kch, v_cj;
    end loop;
    close kc_cur; 
end;
/
select * from temp_cj;

/* ====================================================================== */

truncate table temp_cj;
/* �� for ʵ�� */
declare 
    cursor kc_cur is 
	select xh, kch, cj 
	    from xs_kc; 

begin 
    for kc_cur_rec in kc_cur loop /* ������ļ��! */ 
	if kc_cur_rec.cj < 60 then 
	    insert into temp_cj values(kc_cur_rec.xh,
		kc_cur_rec.kch, kc_cur_rec.cj);
	end if; 
    end loop;
end;
/
select * from temp_cj;

/* ����ѡ����ȫ���γ̵�ͬѧ������ */ /* MMMMM */ 
/* ��: ����û��һ�Ź��β�ѡ�޵�ѧ�� */
select xm
    from xs
    where not exists
    (select *
	from kc
	where not exists
	(select *
	    from xs_kc
	    where xh=xs.xh and kch=kc.kch
	)
    );

/* ���Ҽ����רҵƽ���ɼ���80�����ϵ�ѧ����ѧ�ź�ƽ���ɼ� */
select xh, avg(cj)
    from xs_kc 
    where xh in 
    (select xh 
	from xs 
	where zym = '�����'
    )
    group by xh
    having avg(cj) >= 80;

/* ���ұ����еļ����ϵѧ�����䶼���ѧ�� */
select * 
    from xs 
    where cssj < all 
    (select cssj
	from xs 
	where zym='�����'
    );

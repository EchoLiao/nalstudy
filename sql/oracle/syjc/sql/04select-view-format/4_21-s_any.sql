/* ���ҿγ̺� 105 �ĳɼ������ڿγ̺� 101 ����ͳɼ���ѧ����ѧ�� */
select xh
    from xs_kc
    where kch='105' and cj>=any
    (select cj
	from xs_kc
	where kch='101'
    );

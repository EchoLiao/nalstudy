/* ��ĳ�γ�δ��ѡ��, ����������Ӧ�е�ѧ��, �γ̺�, �ɼ��ֶ�ֵ��Ϊ NULL */
select xs_kc.*, kcm 
    from xs_kc right outer join kc 
	on xs_kc.kch = kc.kch;

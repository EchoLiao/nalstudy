/* ��ƽ���ɼ���85�����ϵ�ѧ����ѧ�ź�ƽ���ɼ� */
select xh, avg(cj)
    from xs_kc 
    group by xh 
    having avg(cj) >= 85;

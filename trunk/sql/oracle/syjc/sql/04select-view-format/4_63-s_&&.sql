/* ����ѡ�޿γ̳���2���ҳɼ���75�����ϵ�ѧ����ѧ�� */ /* MMMMM */ 
select &&column /* xh */ 
    from xs_kc
    where cj >= 75
    group by &column
    having count(*) > 2;

create or replace view cs_xs1 
    as 
    select * 
    from xs 
    where zym = '�����'
    with check option /* ָ������ͼ�ϵ��޸�Ҫ������������ */
    ;

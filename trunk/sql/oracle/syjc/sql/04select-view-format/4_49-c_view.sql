/* Ҫ��Ҫ��֤�Ը���ͼ���޸Ķ�Ҫ����רҵ��Ϊ������������ */
create or replace view cs_kc
as
select xs.xh, kch, cj
    from xs, xs_kc
    where xs.xh = xs_kc.xh and zym = '�����'
    with check option /* ָ������ͼ�ϵ��޸�Ҫ������������ */
    ;

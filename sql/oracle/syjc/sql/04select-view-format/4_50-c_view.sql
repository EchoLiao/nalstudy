/* ���������רҵ��ƽ���ɼ���ͼ cs_kc_avg */
/* force ��ʾ�� cs_kc ������ҲҪ���� */
create or replace force view cs_kc_avg(num, score_avg)
as 
select xh, avg(cj)
    from cs_kc
    group by xh;

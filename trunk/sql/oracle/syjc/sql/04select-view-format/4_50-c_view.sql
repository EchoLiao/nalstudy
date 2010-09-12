/* 创建计算机专业的平均成绩视图 cs_kc_avg */
/* force 表示即 cs_kc 不存在也要创建 */
create or replace force view cs_kc_avg(num, score_avg)
as 
select xh, avg(cj)
    from cs_kc
    group by xh;

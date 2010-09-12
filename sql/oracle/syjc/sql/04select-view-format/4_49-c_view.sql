/* 要求要保证对该视图的修改都要符合专业名为计算机这个条件 */
create or replace view cs_kc
as
select xs.xh, kch, cj
    from xs, xs_kc
    where xs.xh = xs_kc.xh and zym = '计算机'
    with check option /* 指出在视图上的修改要符合限制条件 */
    ;

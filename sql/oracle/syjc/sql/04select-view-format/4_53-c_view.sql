create or replace view cs_xs1 
    as 
    select * 
    from xs 
    where zym = '计算机'
    with check option /* 指出在视图上的修改要符合限制条件 */
    ;

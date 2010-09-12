/* 若有学生未选修任何课程, 则结果表中相应行的课程号字段值为 NULL */
select xs.xh, kch 
    from xs left outer join xs_kc on xs.xh = xs_kc.xh;

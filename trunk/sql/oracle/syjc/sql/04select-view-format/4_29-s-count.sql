/* 求学生总人数 */
select count(*) 学生总数
    from xs;

/* 求选修了课程的学生总人数 */
select count(distinct xh)
    from xs_kc;



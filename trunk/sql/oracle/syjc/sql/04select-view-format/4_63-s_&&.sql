/* 查找选修课程超过2门且成绩在75分以上的学生的学号 */ /* MMMMM */ 
select &&column /* xh */ 
    from xs_kc
    where cj >= 75
    group by &column
    having count(*) > 2;

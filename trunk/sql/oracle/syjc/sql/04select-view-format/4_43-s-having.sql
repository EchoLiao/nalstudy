/* 求平均成绩在85分以上的学生的学号和平均成绩 */
select xh, avg(cj)
    from xs_kc 
    group by xh 
    having avg(cj) >= 85;

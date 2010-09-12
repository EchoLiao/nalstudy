/* 查找计算机专业平均成绩在80分以上的学生的学号和平均成绩 */
select xh, avg(cj)
    from xs_kc 
    where xh in 
    (select xh 
	from xs 
	where zym = '计算机'
    )
    group by xh
    having avg(cj) >= 80;

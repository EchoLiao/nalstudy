/* 查找课程号 105 的成绩不低于课程号 101 的最低成绩的学生的学号 */
select xh
    from xs_kc
    where kch='105' and cj>=any
    (select cj
	from xs_kc
	where kch='101'
    );

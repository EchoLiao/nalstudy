/* 若某课程未被选修, 则结果表中相应行的学号, 课程号, 成绩字段值均为 NULL */
select xs_kc.*, kcm 
    from xs_kc right outer join kc 
	on xs_kc.kch = kc.kch;

/* 查找不同课程成绩相同的学生的学号, 课程号和成绩 */
select a.xh, a.kch, b.kch, a.cj
    from xs_kc a join xs_kc b 
	on a.cj = b.cj and a.xh = b.xh 
	    and a.kch != b.kch;

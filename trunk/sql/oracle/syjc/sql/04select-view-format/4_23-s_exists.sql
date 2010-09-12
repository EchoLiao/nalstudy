/* 查找选修了全部课程的同学的姓名 */ /* MMMMM */ 
/* 即: 查找没有一门功课不选修的学生 */
select xm
    from xs
    where not exists
    (select *
	from kc
	where not exists
	(select *
	    from xs_kc
	    where xh=xs.xh and kch=kc.kch
	)
    );

/* 查找 061104 号同学所选修的全部课程的同学的学号 */ /* MMMMM */ 
select distinct xh
    from xs_kc x
    where not exists
    (select *
	from xs_kc y
	where y.xh='061104' and not exists
	(select *
	    from xs_kc z
	    where z.xh=x.xh and z.kch=y.kch
	)
    );

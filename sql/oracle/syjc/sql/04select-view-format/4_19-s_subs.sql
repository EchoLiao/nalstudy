/* 查找未选修离散数学的学生情况 */
select xh, xm, zym, zxf
    from xs
    where xh not in
    (select xh	
	from xs_kc
	where kch in
	(select kch
	    from kc 
	    where kcm = '离散数学'
	)
    );

select xs.xh, xm, zym, zxf
    from xs
    where xh not in
    (select xh
	from xs_kc, kc
	where kc.kch = xs_kc.kch and
	    kcm = '离散数学'
    );

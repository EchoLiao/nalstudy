/* ����δѡ����ɢ��ѧ��ѧ����� */
select xh, xm, zym, zxf
    from xs
    where xh not in
    (select xh	
	from xs_kc
	where kch in
	(select kch
	    from kc 
	    where kcm = '��ɢ��ѧ'
	)
    );

select xs.xh, xm, zym, zxf
    from xs
    where xh not in
    (select xh
	from xs_kc, kc
	where kc.kch = xs_kc.kch and
	    kcm = '��ɢ��ѧ'
    );

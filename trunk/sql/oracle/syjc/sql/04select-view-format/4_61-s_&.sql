select xs.xh, &name, kcm, &column 
    from xs, &kc, xs_kc 
    where xs.xh = xs_kc.xh and &condition 
	and kcm = &kcm
    order by &column;

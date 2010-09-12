select xm, cj 
    from xs join xs_kc
	on xs.xh = xs_kc.xh
    where kch='105' and cj >= 80;

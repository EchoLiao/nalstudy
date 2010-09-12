accept num prompt '«Î ‰»ÎøŒ≥Ã∫≈: ';

select xh, kcm, cj 
    from xs_kc, kc 
    where xs_kc.kch = kc.kch and 
	kc.kch = '&num' 
    order by cj;

merge into xs a
    using xs_jsj b 
    on (a.xh = b.xh)
    when not matched then insert 
    values (b.xh, b.xm, b.zym, b.xb, b.cssj, b.zxf, b.bz);

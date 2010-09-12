alter table xs_kc
    add(constraint fk_xh foreign key(xh) references xs(xh));

alter table xs_kc
    add(constraint fk_kch foreign key(kch) references kc(kch));


alter table xs_kc
    drop constraint fk_kc;

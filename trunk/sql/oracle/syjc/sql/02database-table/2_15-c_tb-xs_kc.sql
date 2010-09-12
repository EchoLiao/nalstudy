/* ������ xs_kc */
create table xs_kc
(	xh char(6) not null,
	    /* constraint fk_xh foreign key references xs(xh), */
	kch char(3) not null, /* ��С���ȱ���Ҫ��� CK �е�һ�� MMMMM */ 
	cj number(2) null, /* �ɼ� */ 
	xf number(2) null, /* ѧ�� */ 
	constraint "pk_xs_kc" primary key (xh, kch),
	constraint fk_xs_kc__xh  foreign key (xh)  references xs(xh),
	constraint fk_xs_kc__kch foreign key (kch) references kc(kch)
)
tablespace myts;

drop table xs_kc;

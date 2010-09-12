/* 创建表 xs_kc */
create table xs_kc
(	xh char(6) not null,
	    /* constraint fk_xh foreign key references xs(xh), */
	kch char(3) not null, /* 大小长度必须要与表 CK 中的一样 MMMMM */ 
	cj number(2) null, /* 成绩 */ 
	xf number(2) null, /* 学分 */ 
	constraint "pk_xs_kc" primary key (xh, kch),
	constraint fk_xs_kc__xh  foreign key (xh)  references xs(xh),
	constraint fk_xs_kc__kch foreign key (kch) references kc(kch)
)
tablespace myts;

drop table xs_kc;

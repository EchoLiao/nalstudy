/* ������ xs */
create table xs
(
    xh char(6) not null,
	/* constraint pk_xs primary key, */
    xm varchar2(8) not null,
    indentity char(20),
	/* constraint un_id unique; */
    zym char(10), /* רҵ�� */
    xb char(2) not null,
    cssj date not null,		/* ����ʱ�� */
    zxf number(2) default 0,	/* ��ѧ�� */
    bz varchar2(200) null,
    constraint pk_xs primary key (xh),
    constraint un_xs__indentity unique (indentity)
);

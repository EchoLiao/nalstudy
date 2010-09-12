create table cp
(
    cpbh    char(8) not null, /* ��Ʒ��� */ 
    cpmc    char(12) not null,  /* ��Ʒ���� */ 
    jg	    number(8) not null, /* �۸� */ 
    kcl	    integer null, /* ����� */ 
    constraint pk_cp primary key (cpbh)
);

alter table cp
    add(constraint pk_cp primary key(cpbh));

insert into cp(cpbh, cpmc, jg, kcl)
    values('08982230', '���� A', 1500, 500 );
insert into cp(cpbh, cpmc, jg, kcl)
    values('08982231', '���� B', 1800, 300 );

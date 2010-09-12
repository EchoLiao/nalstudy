create table cp
(
    cpbh    char(8) not null, /* 产品编号 */ 
    cpmc    char(12) not null,  /* 产品名称 */ 
    jg	    number(8) not null, /* 价格 */ 
    kcl	    integer null, /* 库存量 */ 
    constraint pk_cp primary key (cpbh)
);

alter table cp
    add(constraint pk_cp primary key(cpbh));

insert into cp(cpbh, cpmc, jg, kcl)
    values('08982230', '冰箱 A', 1500, 500 );
insert into cp(cpbh, cpmc, jg, kcl)
    values('08982231', '冰箱 B', 1800, 300 );

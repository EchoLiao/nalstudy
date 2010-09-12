/* 创建表kc, 并指定存储参数 */
create table kc
(
	kch char(3) not null,
	kcm char(16) not null,
	indentity char(20) null,
	kkxq number(1) not null,    /* 开课学期 */
	xs number(2) not null,	    /* 学时 */
	xf number(2) null,	    /* 学分 */
	    /* check(xf>=0 and xf<=10) null,  */
	constraint pk_kch primary key (kch),
	constraint un_kc__indentity unique (indentity), /* indentity 必须要用括号括起来 */
	constraint ch_kc__kkxq check (kkxq between 1 and 8),
	constraint ch_kc__xf check(xf>=0 and xf<=10)
)
pctfree 10 pctused 40 initrans 1 maxtrans 255
tablespace myts
storage (initial 64K minextents 1 pctincrease 40
	freelists 1 freelist groups 1);

drop table xs_kc;
drop table kc;
drop table xs;

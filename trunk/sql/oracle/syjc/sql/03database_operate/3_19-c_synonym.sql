/* 创建公用同义词 */
create public synonym xs
    for system.xs;	

create public synonym xs_kc
    for system.xs_kc;	

/* 为 XSCJ 数据库 XS 表创建远程数据库同义词 */
create public synonym xs_link
    for system.xs@my_link;

/* 为 XSCJ 数据库 cs_xs 视图创建公用同义词 */
create public synonym cs_xs
    for system.cs_xs;


/* 使用同义词 */
/* 登陆方式: sqlplus system/google8@xscj as sysdba */
select * from xs

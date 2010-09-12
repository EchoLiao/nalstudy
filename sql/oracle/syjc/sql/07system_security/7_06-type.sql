/* 安全特性--(4).类型安全--(3).创建类型和表权限 */ -- QQQQQ 
/* 使用类型创建类型和表的权限 */

/* 设user1, user2, user3 这三个用户都有 connect 和 resource 角色  */
/* 1). user1 在自己的模式上执行以下DDL语句: */
create type type1 as object(attr1 number);
create type type2 as object(attr2 number);
grant execute on type1 to user2;
grant execute on type2 to user2
    with grant option; -- 使得表的所有者可以访问其他用户的表 

/* 2). user2 在自己的模式上执行以下DDL语句: */
create table tab1 of user1.type1;
create type type3 as object(attr3 user1.type2);
create table tab2(col1 userl.type2);


/* 测试: */
/* 3.1) 由于user2在grant option中拥有对user1的type2的execute权限, 所以能构成功
 * 执行: */
grant execute on type3 to user3;
grant select on tab2 to user3;

/* 3.2) 以下执行失败: */
grant select on tab1 to user3;

/* 4). user3可以成功执行以下语句 */
create type type4 as object(attr4 user2.type3);
create table tab3 of type4;

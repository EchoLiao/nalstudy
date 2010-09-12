/* 创建一个新角色 account_create， 它只能创建用户， 而不能执行其他dba级命令
 * */
create role account_create;
grant create session, create user, alter user
    to account_create;



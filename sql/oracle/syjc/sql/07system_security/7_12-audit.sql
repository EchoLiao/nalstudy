/* 分别对 nick 和 admin 用户进行系统权限级别的审计 */
audit delete any table whenever not Successful;
audit create table whenever not Successful;
audit alter any table, alter any procedure by nick by access whenever not Successful;
audit create user by admin whenever not Successful;


/* 查看哪些用户进行了权限审计与审计的选项 */
/* 必须是以 sys 用户连接到数据库进行查询 */
select user_name, privilege, Success, failure 2
    from dba_priv_audit_opts
    order by user_name;

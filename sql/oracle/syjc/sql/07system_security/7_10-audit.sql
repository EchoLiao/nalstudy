/* 使用户hr的所有更新操作都被审计 */
audit update table by hr;

/* 审计影响角色的所有命令 */
audit role;

noaudit role;


/* 被审计的操作都被指定一个数字代码, 这些代码可通过 audit_actions 视图来访问
 * */
select action, name 
    from audit_actions;

/* 已知操作代码就可以通过 dba_audit_object 视图检索登陆审计记录 */
select os_username, username, terminal, owner, obj_name, action_name,
    decode(returncode, '0','Success', returncode),
    to_char(Timestamp, 'DD-MON-YYYY HH24:MI:SS')
    from dba_audit_object;

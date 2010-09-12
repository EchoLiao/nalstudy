/* 授予author的定额users表空间中的10M */
alter user author 
    quota 10M on users;

/* 锁定author用户账户 */
alter user author 
    account lock;

/* 回收用户author的dba角色 */
revoke dba from author; 

/* 回收用户NICK对表xs修改的权限 */
revoke alter on xs from nick;

/* 回收用户nick和author对表xs删除和插入数据的权限 */
revoke delete, insert on xs from nick, author;

/* 删除用户 */
-- cascade 删除用户所有的相关对象 
drop user author cascade


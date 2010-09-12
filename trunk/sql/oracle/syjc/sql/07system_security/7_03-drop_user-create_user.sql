/* 约等价于 7_01 */
drop user author;
create user author
    identified by angel
    default tablespace users
	temporary tablespace temp 
	password expire; 
-- 登陆前必须修改密码 

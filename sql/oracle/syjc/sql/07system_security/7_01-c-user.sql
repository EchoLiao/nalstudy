/* 创建一个名为author的用户, 口令为angel, 默认表空间为users, 临时表空间为TEMP.
 * 没有定额, 使用默认概要文件 */
create user author
	identified by angel
	default tablespace users
	temporary tablespace temp;

create user admin
	identified by google8
	default tablespace users
	temporary tablespace temp;

drop user admin cascade;

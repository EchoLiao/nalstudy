/* ����һ����Ϊauthor���û�, ����Ϊangel, Ĭ�ϱ�ռ�Ϊusers, ��ʱ��ռ�ΪTEMP.
 * û�ж���, ʹ��Ĭ�ϸ�Ҫ�ļ� */
create user author
	identified by angel
	default tablespace users
	temporary tablespace temp;

create user admin
	identified by google8
	default tablespace users
	temporary tablespace temp;

drop user admin cascade;

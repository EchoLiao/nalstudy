/* ����author�Ķ���users��ռ��е�10M */
alter user author 
    quota 10M on users;

/* ����author�û��˻� */
alter user author 
    account lock;

/* �����û�author��dba��ɫ */
revoke dba from author; 

/* �����û�NICK�Ա�xs�޸ĵ�Ȩ�� */
revoke alter on xs from nick;

/* �����û�nick��author�Ա�xsɾ���Ͳ������ݵ�Ȩ�� */
revoke delete, insert on xs from nick, author;

/* ɾ���û� */
-- cascade ɾ���û����е���ض��� 
drop user author cascade


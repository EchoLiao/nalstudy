/* ����һ���½�ɫ account_create�� ��ֻ�ܴ����û��� ������ִ������dba������
 * */
create role account_create;
grant create session, create user, alter user
    to account_create;



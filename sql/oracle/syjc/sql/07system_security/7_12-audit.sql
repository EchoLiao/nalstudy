/* �ֱ�� nick �� admin �û�����ϵͳȨ�޼������� */
audit delete any table whenever not Successful;
audit create table whenever not Successful;
audit alter any table, alter any procedure by nick by access whenever not Successful;
audit create user by admin whenever not Successful;


/* �鿴��Щ�û�������Ȩ���������Ƶ�ѡ�� */
/* �������� sys �û����ӵ����ݿ���в�ѯ */
select user_name, privilege, Success, failure 2
    from dba_priv_audit_opts
    order by user_name;

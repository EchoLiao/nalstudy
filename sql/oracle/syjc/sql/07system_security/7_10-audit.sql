/* ʹ�û�hr�����и��²���������� */
audit update table by hr;

/* ���Ӱ���ɫ���������� */
audit role;

noaudit role;


/* ����ƵĲ�������ָ��һ�����ִ���, ��Щ�����ͨ�� audit_actions ��ͼ������
 * */
select action, name 
    from audit_actions;

/* ��֪��������Ϳ���ͨ�� dba_audit_object ��ͼ������½��Ƽ�¼ */
select os_username, username, terminal, owner, obj_name, action_name,
    decode(returncode, '0','Success', returncode),
    to_char(Timestamp, 'DD-MON-YYYY HH24:MI:SS')
    from dba_audit_object;

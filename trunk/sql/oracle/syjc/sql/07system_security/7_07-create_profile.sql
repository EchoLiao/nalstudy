/* ����һ��limited_profile ��Ҫ�ļ� */

/* �������5����author�˻�������ʧ��, �ý��Զ���oracle����.
 * Ȼ��, ��ʹʹ������ȷ�Ŀ���, ϵͳ����ʾ������Ϣ, ֻ�ж��˻�������, ����ʹ��
 * ���û�.
 */
/* ����5������ʧ�� */
/* 10����Զ����� */
create profile limited_profile limit
    failed_login_attempts 5
    password_lock_time 10;

alter user nick
    profile limited_profile;


/* ��������ͬ��� */
create public synonym xs
    for system.xs;	

create public synonym xs_kc
    for system.xs_kc;	

/* Ϊ XSCJ ���ݿ� XS ����Զ�����ݿ�ͬ��� */
create public synonym xs_link
    for system.xs@my_link;

/* Ϊ XSCJ ���ݿ� cs_xs ��ͼ��������ͬ��� */
create public synonym cs_xs
    for system.cs_xs;


/* ʹ��ͬ��� */
/* ��½��ʽ: sqlplus system/google8@xscj as sysdba */
select * from xs

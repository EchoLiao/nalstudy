/* �޸ı� */

/* �ڱ� xs ������2�� */
/* ��ѧ��ȼ�, ��ѧ��ȼ�˵�� */
alter table xs
    add(jxj number(1), djsm varchar2(40) default '���� 1000Ԫ');

/* �޸���Ĭ��ֵ */
alter table xs
    modify (djsm default '����800Ԫ');

/* ɾ���� */
alter table xs
    drop column jxj;
alter table xs
    drop column djsm;

/* �޸ı� xs �Ĵ洢���� */
alter table xs
    pctfree 20 maxtrans 50;

/* Ϊ�� xs_jsj �������� */
alter table xs_jsj
	add(constraint "pk_jsj" primary key (xh));

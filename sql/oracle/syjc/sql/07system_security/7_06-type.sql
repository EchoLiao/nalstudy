/* ��ȫ����--(4).���Ͱ�ȫ--(3).�������ͺͱ�Ȩ�� */ -- QQQQQ 
/* ʹ�����ʹ������ͺͱ��Ȩ�� */

/* ��user1, user2, user3 �������û����� connect �� resource ��ɫ  */
/* 1). user1 ���Լ���ģʽ��ִ������DDL���: */
create type type1 as object(attr1 number);
create type type2 as object(attr2 number);
grant execute on type1 to user2;
grant execute on type2 to user2
    with grant option; -- ʹ�ñ�������߿��Է��������û��ı� 

/* 2). user2 ���Լ���ģʽ��ִ������DDL���: */
create table tab1 of user1.type1;
create type type3 as object(attr3 user1.type2);
create table tab2(col1 userl.type2);


/* ����: */
/* 3.1) ����user2��grant option��ӵ�ж�user1��type2��executeȨ��, �����ܹ��ɹ�
 * ִ��: */
grant execute on type3 to user3;
grant select on tab2 to user3;

/* 3.2) ����ִ��ʧ��: */
grant select on tab1 to user3;

/* 4). user3���Գɹ�ִ��������� */
create type type4 as object(attr4 user2.type3);
create table tab3 of type4;

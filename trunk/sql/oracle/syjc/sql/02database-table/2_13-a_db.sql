/* ʹ���ݿ� mydb �л����鵵ģʽ */
alter database mydb
    archivelog;

/* �����µ������ļ��Դ���ԭ���������ļ� */
alter database mydb 
    create datafile 'users' as 'E:\oracle\product\10.2.0\admin\mydb\users01.dbf'
	size 20M reuse autoextend on next 1M
	maxsize 50M
	extent management local;

/* �ֹ���չ users01 �����ļ� */
alter database mydb 
    datafile 'E:\oracle\product\10.2.0\admin\mydb\users01.dbf'
	resize 80M

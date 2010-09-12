/* 使数据库 mydb 切换到归档模式 */
alter database mydb
    archivelog;

/* 创建新的数据文件以代替原来的数据文件 */
alter database mydb 
    create datafile 'users' as 'E:\oracle\product\10.2.0\admin\mydb\users01.dbf'
	size 20M reuse autoextend on next 1M
	maxsize 50M
	extent management local;

/* 手工扩展 users01 数据文件 */
alter database mydb 
    datafile 'E:\oracle\product\10.2.0\admin\mydb\users01.dbf'
	resize 80M

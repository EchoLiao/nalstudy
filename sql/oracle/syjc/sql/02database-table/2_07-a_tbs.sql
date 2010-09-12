/* 修改表空间data, 增加新数据文件data02.dbf */
alter tablespace data 
	add datafile 'E:\oracle\product\10.2.0\oradata\XSCJ\data02.dbf'  size 4M
	reuse autoextend on next 64K maxsize 20M


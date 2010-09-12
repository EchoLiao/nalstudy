/* 创建表空间, 禁止自动扩展数据文件 */
create tablespace "test"
	logging
	datafile 'E:\oracle\product\10.2.0\oradata\XSCJ\test101.dbf' size 3M
		reuse autoextend off /* 若文件已满, 不自动增加文件大小 */


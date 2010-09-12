/* 创建表空间, 允许自动扩展数据文件 */
create tablespace myts
	logging
	datafile 'E:\oracle\product\10.2.0\oradata\XSCJ\myts01.dbf' size 3M
		reuse autoextend on next 32K maxsize 10M
	default storage(initial 32K next 32K minextents 1
		maxextents 249 pctincrease 50); /* 设置相关物理存储配置 */
	-- extent management local /* local 与 storage 互斥 */

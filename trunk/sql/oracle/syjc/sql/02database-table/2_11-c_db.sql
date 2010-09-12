create database mydb 
    maxinstances 1
    maxloghistory 1
    maxlogfiles 5
    maxlogmembers 5
    maxdatafiles 100
    datafile 'E:\oracle\product\10.2.0\admin\mydb\system01.dbf'
	size 5M autoextend on next 100K maxsize unlimited
    undo tablespace undotbs datafile
	'E:\oracle\product\10.2.0\admin\mydb\undotbs01.dbf'
	size 5M reuse autoextend on next 100K maxsize unlimited
    default temporary tablespace temps1
    character set zhs16gbk
    national character set al16utf16
    logfile 'E:\oracle\product\10.2.0\admin\mydb\redo01.log' size 3M
            'E:\oracle\product\10.2.0\admin\mydb\redo02.log' size 3M
            'E:\oracle\product\10.2.0\admin\mydb\redo03.log' size 3M

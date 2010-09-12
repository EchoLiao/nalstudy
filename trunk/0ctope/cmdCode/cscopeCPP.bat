@echo off
rem 下表中列出了cscope的常用选项(生成cscope_data_base): 
rem    -R: 在生成索引文件时，搜索子目录树中的代码 
rem    -b: 只生成索引文件，不进入cscope的界面 
rem    -q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度 
rem    -k: 在生成索引文件时，不搜索/usr/include目录 
rem    -i: 如果保存文件列表的文件名不是cscope.files时,需要加此选项告诉cscope到哪儿去找源文件列表.可以使用”-“，表示由标准输入获得文件列表。 
rem    -Idir: 在-I选项指出的目录中查找头文件 
rem    -u: 扫描所有文件，重新生成交叉索引文件 
rem    -C: 在搜索时忽略大小写 
rem    -Ppath: 在以相对路径表示的文件前加上的path，这样，你不用切换到你数据库文件所在的目录也可以使用它了。 
rem
rem

cls
@echo on
dir cscope.*
del cscope.*
del ncscope.*
dir cscope.*
call bk.bat
dir /s /b *.cpp *.h *.hpp > cscope.files
REM cscope -b -q -k -i cscope.files 
cscope -b
dir cscope.*

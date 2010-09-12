@echo off
rem 为java文件生成索引

call bk.bat
ctags -R --java-kinds=+p --fields=+iaS --extra=+q .


@echo off
rem Ϊjava�ļ���������

call bk.bat
ctags -R --java-kinds=+p --fields=+iaS --extra=+q .


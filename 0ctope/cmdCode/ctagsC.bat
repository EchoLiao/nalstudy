@echo off
rem Ϊc++�ļ���������

call bk.bat
ctags -R --c-kinds=+p --fields=+iaS --extra=+q .


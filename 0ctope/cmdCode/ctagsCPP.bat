@echo off
rem Ϊc++�ļ���������
rem
rem ��std����������
rem ctags -R --kinds-c++=+p --fields=+iaS --extra=+q --language-force=c++ .

call bk.bat
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .



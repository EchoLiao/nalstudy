@echo off
rem ���ݵ�ǰĿ¼(������Ŀ¼)�µ����� *~ �ļ�.
rem ������ʾ:  for /?

rem FOR /R . %%i IN (*~) DO copy /y "%%i" E:\bake_up  &   del "%%i"
@echo on
FOR /R . %%i IN (*~) DO move /y "%%i" d:\bake_up

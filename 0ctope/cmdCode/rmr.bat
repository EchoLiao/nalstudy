@echo off
rem ���ݵ�ǰĿ¼(������Ŀ¼)�µ����� *~ �ļ�.
rem ������ʾ:  for /?

@echo on
FOR /R . %%i IN (*~) DO del "%%i"

@echo off
rem 备份当前目录(包括子目录)下的所有 *~ 文件.
rem 帮助提示:  for /?

rem FOR /R . %%i IN (*~) DO copy /y "%%i" E:\bake_up  &   del "%%i"
@echo on
FOR /R . %%i IN (*~) DO move /y "%%i" d:\bake_up

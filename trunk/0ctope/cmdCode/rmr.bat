@echo off
rem 备份当前目录(包括子目录)下的所有 *~ 文件.
rem 帮助提示:  for /?

@echo on
FOR /R . %%i IN (*~) DO del "%%i"

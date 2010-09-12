@echo off
set fla=www.hao123.com
rem echo "%fla%"
set /p fla=
cd "C:\Program Files\Internet Explorer"
c:
rem if /i "%fla%"=="h" start iexplore.exe
rem if /i "%fla%"=="h" goto a
rem echo "%fla%"
start iexplore.exe "%fla%"
rem :a
e:

@echo off
echo @echo off > %cmd_code_home%\h_b\b.bat
echo cd %cd% >> %cmd_code_home%\h_b\b.bat
cd \
echo %cd% > %cmd_code_home%\h_b\pan_fu_tmp.tmp

findstr E %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo E: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr F %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo F: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr C %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo C: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr G %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo G: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr D %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo D: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr H %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo H: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr I %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo I: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr J %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo J: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr A %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo A: >> %cmd_code_home%\h_b\b.bat & goto end )

findstr B %cmd_code_home%\h_b\pan_fu_tmp.tmp
IF %ERRORLEVEL% == 0 (
    echo B: >> %cmd_code_home%\h_b\b.bat & goto end )

:end
cd %cmd_code_home%
E:
echo cls >> %cmd_code_home%\h_b\b.bat
cls

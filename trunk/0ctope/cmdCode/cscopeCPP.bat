@echo off
rem �±����г���cscope�ĳ���ѡ��(����cscope_data_base): 
rem    -R: �����������ļ�ʱ��������Ŀ¼���еĴ��� 
rem    -b: ֻ���������ļ���������cscope�Ľ��� 
rem    -q: ����cscope.in.out��cscope.po.out�ļ����ӿ�cscope�������ٶ� 
rem    -k: �����������ļ�ʱ��������/usr/includeĿ¼ 
rem    -i: ��������ļ��б���ļ�������cscope.filesʱ,��Ҫ�Ӵ�ѡ�����cscope���Ķ�ȥ��Դ�ļ��б�.����ʹ�á�-������ʾ�ɱ�׼�������ļ��б� 
rem    -Idir: ��-Iѡ��ָ����Ŀ¼�в���ͷ�ļ� 
rem    -u: ɨ�������ļ����������ɽ��������ļ� 
rem    -C: ������ʱ���Դ�Сд 
rem    -Ppath: �������·����ʾ���ļ�ǰ���ϵ�path���������㲻���л��������ݿ��ļ����ڵ�Ŀ¼Ҳ����ʹ�����ˡ� 
rem
rem

cls
@echo on
dir cscope.*
del cscope.*
del ncscope.*
dir cscope.*
call bk.bat
dir /s /b *.cpp *.h *.hpp > cscope.files
REM cscope -b -q -k -i cscope.files 
cscope -b
dir cscope.*

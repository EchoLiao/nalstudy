@echo off
rem ctags�����÷�

@echo on
ctags -R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+px --fields=+aiKSz --extra=+q --exclude=lex.yy.cc --exclude=copy_lex.yy.cc

@echo off
rem 1.
rem -R
rem ��ʾɨ�赱ǰĿ¼��������Ŀ¼���ݹ����£��е�Դ�ļ��������������ļ�ctags����ɨ�裬����û�û���ر�ָ������ctags�����ļ�����չ���������Ƿ�Ҫɨ����ļ��������ctags���Ը����ļ�����չ�������жϳ����ļ���ʹ�õ����ԣ���ctags��ɨ����ļ���
rem 
rem 2.
rem --languages=c++
rem ֻɨ���ļ������ж�Ϊc++���ļ�������ctags�۲��ļ���չ���������չ����Ӧc++����ɨ����ļ�����֮���ĳ���ļ���aaa.py��python�ļ���������ļ����ᱻɨ�衣
rem 
rem 3.
rem --langmap=c++:+.inl
rem ��֪ctags����inlΪ��չ�����ļ���c++����д�ģ��ڼ�֮����2�е�ѡ���Ҫ��ctags��c++�﷨ɨ����inlΪ��չ�����ļ���
rem 
rem 4.
rem -h +.inl
rem ��֪ctags������inlΪ��չ�����ļ�������ͷ�ļ���һ�֣�inl�ļ��зŵ���inline�����Ķ��壬��������Ϊ�˱�include�ģ�������ctags��ɨ��inl�ļ�ʱ������������static��ȫ�ֱ�����ctags�ڼ�¼ʱҲ�������˵�ñ����Ǿ����ڱ��ļ��ģ�����һ����������
rem 
rem 5.
rem --c++-kinds=+px
rem ��¼����Ϊ����������ǰ���������﷨Ԫ�أ��������ڣ���
rem 
rem 6.
rem --fields=+aiKSz
rem ���Ƽ�¼�����ݣ������Ľڣ���
rem 
rem 7.
rem --extra=+q
rem ��ctags�����¼һЩ�����������ġ���ڣ���
rem 
rem 8.
rem --exclude=lex.yy.cc --exclude=copy_lex.yy.cc
rem ��֪ctags��Ҫɨ���������������ļ��������Կ���ctags��Ҫɨ��ָ��Ŀ¼������Ͳ�ϸ˵�ˡ�
rem 

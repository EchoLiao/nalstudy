@echo off
rem ctags经典用法

@echo on
ctags -R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+px --fields=+aiKSz --extra=+q --exclude=lex.yy.cc --exclude=copy_lex.yy.cc

@echo off
rem 1.
rem -R
rem 表示扫描当前目录及所有子目录（递归向下）中的源文件。并不是所有文件ctags都会扫描，如果用户没有特别指明，则ctags根据文件的扩展名来决定是否要扫描该文件——如果ctags可以根据文件的扩展名可以判断出该文件所使用的语言，则ctags会扫描该文件。
rem 
rem 2.
rem --languages=c++
rem 只扫描文件内容判定为c++的文件——即ctags观察文件扩展名，如果扩展名对应c++，则扫描该文件。反之如果某个文件叫aaa.py（python文件），则该文件不会被扫描。
rem 
rem 3.
rem --langmap=c++:+.inl
rem 告知ctags，以inl为扩展名的文件是c++语言写的，在加之上述2中的选项，即要求ctags以c++语法扫描以inl为扩展名的文件。
rem 
rem 4.
rem -h +.inl
rem 告知ctags，把以inl为扩展名的文件看作是头文件的一种（inl文件中放的是inline函数的定义，本来就是为了被include的）。这样ctags在扫描inl文件时，就算里面有static的全局变量，ctags在记录时也不会标明说该变量是局限于本文件的（见第一节描述）。
rem 
rem 5.
rem --c++-kinds=+px
rem 记录类型为函数声明和前向声明的语法元素（见第三节）。
rem 
rem 6.
rem --fields=+aiKSz
rem 控制记录的内容（见第四节）。
rem 
rem 7.
rem --extra=+q
rem 让ctags额外记录一些东西（见第四、五节）。
rem 
rem 8.
rem --exclude=lex.yy.cc --exclude=copy_lex.yy.cc
rem 告知ctags不要扫描名字是这样的文件。还可以控制ctags不要扫描指定目录，这里就不细说了。
rem 

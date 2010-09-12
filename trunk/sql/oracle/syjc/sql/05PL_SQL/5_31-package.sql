/* QQQQQ */
set ServerOutput on;
create or replace package select_table
is
type tab_02 is record
(
    itnum_1 varchar2(1),
    itnum_2 varchar2(1)
);
type tab_03 is record
(
    itnum_1 varchar2(1),
    itnum_2 varchar2(1),
    itnum_3 varchar2(1)
);
type tab_04 is record
(
    itnum_1 varchar2(1),
    itnum_2 varchar2(1),
    itnum_3 varchar2(1),
    itnum_4 varchar2(1)
);
type tab_05 is record
(
    itnum_1 varchar2(1),
    itnum_2 varchar2(1),
    itnum_3 varchar2(1),
    itnum_4 varchar2(1),
    itnum_5 varchar2(1)
);
type tab_06 is record
(
    itnum_1 varchar2(1),
    itnum_2 varchar2(1),
    itnum_3 varchar2(1),
    itnum_4 varchar2(1),
    itnum_5 varchar2(1),
    itnum_6 varchar2(1)
);

type cur_02 is ref cursor return tab_02;
type cur_03 is ref cursor return tab_03;
type cur_04 is ref cursor return tab_04;
type cur_05 is ref cursor return tab_05;
type cur_06 is ref cursor return tab_06;
end select_table;
/


create or replace package test_package
is
    function average
	(cnum in char)
	return number;
    procedure student_grade
	(cur out select_table.cur_04);
end test_package;
/

create or replace package BODY test_package
is
    function average
	(cnum in char)
	return number /*  */ 
    as
	avger number;
    begin
	select avg(cj) into agver
	    from xs_kc
	    where kch = cnum
	    group by kch;
	return (avger)
    end average;

    procedure student_grade
	(cur out select_table.cur_04)
    as
    begin
	open cur for
	select xs.xh, xs.xm, kc.kch, xs_kc.cj
	    from xs, xs_kc, kc
	    where xs.xh = xs_kc.xh and xs_kc.kch = kc.kch;
    end student_grade;
end test_package;
/


declare 
    num number; 
begin 
    num := test_package.average('101');
    dbms_output.put_line(to_char(num));
end;
/

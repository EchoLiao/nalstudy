create or replace package TempPackage 
as 
    procedure addstudent 
	( v_xh in temp_cj.xh%type );

    procedure addstudent 
	(
	    v_xh in temp_cj.xh%type,
	    v_kch in temp_cj.kch%type
	);
end TempPackage;
/

create or replace package body TempPackage 
as 
    procedure addstudent 
	( v_xh in temp_cj.xh%type ) /* 不能有 ; */ 
    is 
    begin 
	insert into temp_cj(xh)
	    values(v_xh);
    end addstudent; 

    procedure addstudent 
	(
	    v_xh in temp_cj.xh%type,
	    v_kch in temp_cj.kch%type
	)
    is 
    begin 
	insert into temp_cj(xh, kch)
	    values(v_xh, v_kch);
    end addstudent;
end TempPackage;
/

begin 
    TempPackage.addstudent('100803'); /* 无法实现重载 QQQQQ */ 
    TempPackage.addstudent('100803', '103');
end;
/
select * from temp_cj;

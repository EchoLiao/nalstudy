set ServerOutput on;
/* ����һ���򵥵Ķ������� */
create or replace type test_obj
    as object 
    (
	item_id char(6),
	price number(10, 2)
    );

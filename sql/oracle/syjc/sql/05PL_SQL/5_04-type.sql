set ServerOutput on;
/* 定义一个简单的对象类型 */
create or replace type test_obj
    as object 
    (
	item_id char(6),
	price number(10, 2)
    );

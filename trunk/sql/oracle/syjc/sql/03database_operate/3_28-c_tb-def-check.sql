create table books
(
    book_id number(10),
    bood_name varchar2(50) not null,
    boo_desc varchar2(50) default 'New book',
    max_lvl number(3, 2) not null, /* QQQQQ */
    trade_price number(4, 1) not null,
    constraint ch_cost check(max_lvl<=250)
);

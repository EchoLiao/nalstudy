alter table books
    add(constraint ch_price check(trade_price<=250));

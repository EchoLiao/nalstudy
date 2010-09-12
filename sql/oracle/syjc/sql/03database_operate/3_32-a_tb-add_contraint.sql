alter table xs
    add(constraint pk_xs primary key(xh));

alter table xs 
    add(constraint un_xs unique(indentity));


alter table xs
    drop constraint pk_xs; /* É¾²»µô QQQQQ */ 
alter table xs
    drop constraint un_xs;

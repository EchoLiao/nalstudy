create index xs_xm_idx 
    on xs(xm)
    tablespace "MYTS"
    initrans 2 /* 初始并行事务可以有的个数 */
    maxtrans 255 /* 可以有的最大并行事务的个数 */ 
    nosort;
    /* 行必须是按升序排序的 */ 

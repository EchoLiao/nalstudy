/* 合并 */
select * 
    from xs 
    union 
    /* all  */ /* all 表示不去除重复行. */ 
    select * 
	from xs;

/* 查找比所有的计算机系学生年龄都大的学生 */
select * 
    from xs 
    where cssj < all 
    (select cssj
	from xs 
	where zym='计算机'
    );

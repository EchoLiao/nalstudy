/* 求各专业的学生数 */
select zym, count(*)
    from xs 
    group by zym;

insert into cs_xs1(xh, xm, zym, xb, cssj, zxf, bz)
    values('001111', '刘妇', '计算机', '男', to_date('19880523', 'YYYYMMDD'), 
	50, '三好学生');

/* 因为 with check option , 以下语句不能成功执行 */
insert into cs_xs1(xh, xm, zym, xb, cssj, zxf, bz)
    values('001112', '刘国', '自动化', '男', to_date('19880523', 'YYYYMMDD'), 
	50, '三好学生');

/* 求全体学生的平均成绩 */
/* 创建函数 */
create or replace function averae
    ( cnum in char ) /* 课程号 */
    return number
as
    avger number;

begin
    select avg(cj) into avger
	from xs_kc
	where kch = cnum
	group by kch;
    return (avger);
end averae;
/
/* / 必须要有 MMMMM */


/* 函数调用 */
begin
    dbms_output.put_line(to_char(averae(101)));
end;
/


/* 删除函数 */
drop function averae;

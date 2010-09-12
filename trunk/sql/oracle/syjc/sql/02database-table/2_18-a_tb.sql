/* 修改表 */

/* 在表 xs 中增加2列 */
/* 奖学金等级, 奖学金等级说明 */
alter table xs
    add(jxj number(1), djsm varchar2(40) default '奖金 1000元');

/* 修改列默认值 */
alter table xs
    modify (djsm default '奖金800元');

/* 删除列 */
alter table xs
    drop column jxj;
alter table xs
    drop column djsm;

/* 修改表 xs 的存储特征 */
alter table xs
    pctfree 20 maxtrans 50;

/* 为表 xs_jsj 加上主键 */
alter table xs_jsj
	add(constraint "pk_jsj" primary key (xh));

/* inner join :
 * 内连接:  内连接按照 on 所指定的连接条件合并两个表, 返回满足条件的行.
 *	    内连接是系统的默认连接方式.
 * 外连接:
 *   1) left outer join :
 *	左连接:	    结果表中除了包括满足条件连接方式的行外, 还包括左表的所有行;
 *   2) right outer join :
 *	右连接:	    结果表中除了包括满足条件连接方式的行外, 还包括右表的所有行;
 *   3) full outer join :
 *	完全外连接: 结果表中除了包括满足条件连接方式的行外, 还包括两个表的所有行.
 *   Note: 外连接只能对两个表进行.
 * 交叉连接: cross join
 *	    交叉连接实际上是将两个表进行笛卡儿积运算, 结果表的行数等于两个表行数之积.
 *   Note: 交叉连接不能有条件, 且不能带 where 子句.
 */
select *
    from xs inner join xs_kc
	on xs.xh = xs_kc.xh;

select xs.*, kch, cj
    from xs inner join xs_kc
	on xs.xh = xs_kc.xh;

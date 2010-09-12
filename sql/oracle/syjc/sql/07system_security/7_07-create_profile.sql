/* 创建一个limited_profile 概要文件 */

/* 如果连续5次与author账户的连接失败, 该将自动由oracle锁定.
 * 然后, 即使使用了正确的口令, 系统会提示错误信息, 只有对账户解锁后, 才能使用
 * 该用户.
 */
/* 连续5次连接失败 */
/* 10天后自动解锁 */
create profile limited_profile limit
    failed_login_attempts 5
    password_lock_time 10;

alter user nick
    profile limited_profile;


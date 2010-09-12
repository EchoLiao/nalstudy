/* 为过期口令设置宽限期为10天 */
alter profile limited_profile limit 
    password_grace_time 10;

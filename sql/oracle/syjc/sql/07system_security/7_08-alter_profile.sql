/* 强制 limited_profile 概要文件的用户每10天改变一次口令 */
alter profile limited_profile limit 
    password_life_time 10;

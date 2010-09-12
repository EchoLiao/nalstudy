/* 为 KC 表的课程名列创建索引 */
/* 表空间为 MYTS */
    /* tablespace 区分大小写 MMMMMM */
create index kc_name_idx
    on kc(kcm)
    tablespace "MYTS";

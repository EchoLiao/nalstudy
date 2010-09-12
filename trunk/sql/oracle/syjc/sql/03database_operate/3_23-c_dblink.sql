/* 为 XSCJ 数据库创建一个名为 my_plink 的公用链接 */
create public database link my_plink
    connect to system identified by google8
    using 'XSCJ';


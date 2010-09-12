declare 
    /* 声明游标变量 */
    type xs_cur is ref cursor return xs%ROWTYPE; /* 强类型, 有返回值 */ 
    type mycur is ref cursor; /* 弱类型 */ 
    /* 定义游标变量 */
    xscur xs_cur;
/

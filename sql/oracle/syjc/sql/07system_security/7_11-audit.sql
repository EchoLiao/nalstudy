/* 对XS表的所有insert命令进行审计 */
audit insert on xs;
/* 对xs_kc表的每个命令都要进行审计 */
audit all on xs_kc;
/* 对KC表的delete命令都要进行审计 */
audit delete on kc;

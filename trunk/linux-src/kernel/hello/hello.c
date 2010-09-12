/*
 * =====================================================================================
 *
 *       Filename:  hello.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2010年08月23日 22时35分23秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerlz (nuoliu), nuoerlz@gmail.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <linux/sched.h>
#include <linux/init.h> /* Needed for the macros */
#include <linux/module.h> /* Needed for all modules */

MODULE_LICENSE("Dual BSD/GPL");
MODULE_AUTHOR("fudan_abc");

static int __init hello_init(void)
{
    /* 注意: KERN_ALERT 与 后面的字符串之间是没有","的! */
    printk(KERN_ALERT "Hello, world!\n");
    printk(KERN_INFO "The process is \"%s\" (pid %i)\n", current->comm, current->pid);
    return 0;
}

static void __exit hello_exit(void)
{
    printk(KERN_ALERT "Goodbye, cruel world\n");
}

module_init(hello_init);
module_exit(hello_exit);

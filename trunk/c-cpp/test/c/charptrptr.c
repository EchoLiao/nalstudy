#include <stdio.h>
#define ARG_MAX           4096	/* args + environ on small machines */
typedef unsigned long vir_bytes;/* virtual addresses and lengths in bytes */

void patch_ptr(stack, base)
	char stack[ARG_MAX];		/* pointer to stack image within PM */
	vir_bytes base;			/* virtual address of stack base inside user */ /* ps */ 
{
	/* When doing an exec(name, argv, envp) call, the user builds up a stack
	 * image with arg and env pointers relative to the start of the stack.  Now
	 * these pointers must be relocated, since the stack is not positioned at
	 * address 0 in the user's address space.
	 */

	char **ap, flag;
	vir_bytes v;

	flag = 0;			/* counts number of 0-pointers seen */
	ap = (char **) stack;		/* points initially to 'nargs' */
	ap++;				/* now points to argv[0] */
	char *t = stack;
	while (flag < 2) {
		if (ap >= (char **) &stack[ARG_MAX]) return;	/* too bad */
		if (*ap != NULL) {
			v = (vir_bytes) *ap;	/* v is relative pointer */
			v += base;		/* relocate it */
			*ap = (char *) v;	/* put it back */
		} else {
			flag++;
		}
		ap++;
	}
}

int main(int argc, char *argv[])
{
	printf("%s\n", argv[0]);
	char stack[ARG_MAX] = {'/', 'b', 'n', '/', 's', 'h', '\0', 't', '.', 's', 'h', '\0', 'f'};
	char *a1[10] = {"ab", "cd",};
	/* char *a1[10] = {'a', 'b', '\0', 'c', 'd', '\0'}; */ /* 错误! */ 
	printf(stack);
	printf("\n");
	/* a1++;				[>错误!!<] */
	printf(*a1);
/* a0 = (int) ((char **) stack)[1];	[>argv[0]<] */
	printf("\n");
	printf(*(a1+1));
	/* printf(*a1+1); */
	printf("\n");
	printf("%x\n", (unsigned char)'#');
	patch_ptr(a1, 0x10);
}

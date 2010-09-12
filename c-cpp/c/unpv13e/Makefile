CC = gcc
#CFLAGS = -I../lib -g -O2 -D_REENTRANT -Wall
CFLAGS = -g -O2 -Wall
LIBS = -lpthread
LIBS_XTI = 
RANLIB = 
LIBGAI_OBJS = 
CLEANFILES = core core.* *.core *.o temp.* *.out typescript* \
	     *.lc *.lh *.bsdi *.sparc *.uw

PROGS =	byteorder

all:	${PROGS}

byteorder:	byteorder.o
	${CC} ${CFLAGS} -o $@ byteorder.o ${LIBS}


clean:
	rm -f ${PROGS} ${CLEANFILES}

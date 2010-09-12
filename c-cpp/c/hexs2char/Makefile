# Change the following as required:
CC	= gcc -g
CFLAGS	=

# math lib
LIBS	= -lm

PROGS =	hexs2char
OBJS = hexs2char.o

all:	${PROGS}

# lib 放后边
hexs2char:	${OBJS}
		${CC} ${CFLAGS} -o $@ ${OBJS} ${LIBS}

clean:
		rm -f ${PROGS} core core.* *.o temp.* *.out typescript*

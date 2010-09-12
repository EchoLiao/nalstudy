CC	= gcc
CFLAGS	= -g -ansi -Wall

LIBS	=

PROGS = test watch watch2 char_ptr_string_len
#OBJS = watch.o watch2.o

all:	${PROGS}

# lib 放后边
#all:	${OBJS}
#${CC} ${CFLAGS} -o $@ ${OBJS} ${LIBS}

clean:
	rm -f ${PROGS} *.o

test:	test.o
watch:	watch.o
watch2:	watch2.o
char_ptr_string_len:	char_ptr_string_len.o

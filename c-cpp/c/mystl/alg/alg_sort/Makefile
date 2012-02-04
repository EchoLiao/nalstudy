CC=gcc -c
LD=gcc
AS=as
AR=ar ruv
RANLIB=ranlib
DIFF=diff
CD=cd
RM=rm -f
CP=cp -rf

A=.a
O=.o
E=

## modify this lines by yourself
MY_DEBUG=

MY_STL_INCLUDE=/home/scr/.rt/lang/0mystl/include
MY_STL_LIBDIRS=/home/scr/.rt/lang/0mystl/lib
## modify this lines by yourself
MY_STL_LIBS=-lalg_rand

INCLUDE=-I./include -I$(MY_STL_INCLUDE)
LIBDIRS=-L./lib -L$(MY_STL_LIBDIRS)
LIBS=$(MY_STL_LIBS) -lm

CFLAGS=-g -Wall $(INCLUDE) $(MY_DEBUG)
LDFLAGS=-g $(LIBDIRS) $(LIBS)


## modify this lines by yourself
DST_OBJECTS = \
		  alg_sort.o \

## modify this lines by yourself
DST_INCLUDE = alg_sort.h

## modify this lines by yourself
DST_LIB = libalg_sort.a


## modify this lines by yourself
OBJECTS = \
		  alg_sort_test.o

## modify this lines by yourself
TARGETS = \
		  alg_sort_test



all: $(DST_LIB) $(TARGETS)


$(DST_OBJECTS): %.o: %.c %.h
	$(CC) $(CFLAGS) $< -o $@

$(DST_LIB): $(DST_OBJECTS)
	$(AR) $@ $^
	$(RANLIB) $@ || true


$(OBJECTS): %.o: %.c %.h
	$(CC) $(CFLAGS) $< -o $@

$(TARGETS): %: %.o $(DST_OBJECTS)
	$(LD) -o $@ $< $(DST_OBJECTS) $(LDFLAGS)


install: all
	$(CP) $(DST_INCLUDE) $(MY_STL_INCLUDE)
	$(CP) $(DST_LIB)	 $(MY_STL_LIBDIRS)

uninstall:
	$(CD) $(MY_STL_INCLUDE); $(RM) $(DST_INCLUDE)
	$(CD) $(MY_STL_LIBDIRS); $(RM) $(DST_LIB)


clean:
	$(RM) $(DST_OBJECTS) $(OBJECTS) $(TARGETS)

cleanall: clean
	$(RM) $(DST_LIB)


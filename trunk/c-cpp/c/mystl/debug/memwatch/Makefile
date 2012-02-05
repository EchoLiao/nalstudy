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
MY_STL_LIBS=

INCLUDE=-I./include -I$(MY_STL_INCLUDE)
LIBDIRS=-L./lib -L$(MY_STL_LIBDIRS)
LIBS=$(MY_STL_LIBS) -lm

CFLAGS=-g -Wall $(INCLUDE) $(MY_DEBUG)
LDFLAGS=-g $(LIBDIRS) $(LIBS)


## modify this lines by yourself
DST_OBJECTS = \
		  memwatch.o \

## modify this lines by yourself
DST_INCLUDE = memwatch.h

## modify this lines by yourself
DST_LIB = libmemwatch.a


## modify this lines by yourself
OBJECTS = \

## modify this lines by yourself
TARGETS = \



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


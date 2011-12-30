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

MY_STL_INCLUDE=/home/scr/.rt/lang/0mystl/include
MY_STL_LIBDIRS=/home/scr/.rt/lang/0mystl/lib
MY_STL_LIBS=-lalg_table

INCLUDE=-I./include -I$(MY_STL_INCLUDE)
LIBDIRS=-L./lib -L$(MY_STL_LIBDIRS)
LIBS=$(MY_STL_LIBS) -lm

CFLAGS=-g -Wall $(INCLUDE)
LDFLAGS=-g $(LIBDIRS) $(LIBS)


DST_OBJECTS= \
			  unicode_utf-8.o

DST_INCLUDE= unicode_utf-8.h

DST_LIB= libunicode_utf-8.a


OBJECTS= \
		 unicode_utf-8_test.o \

TARGETS= \
		 unicode_utf-8_test \



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


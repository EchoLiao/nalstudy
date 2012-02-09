PREFIX=
CC=$(PREFIX)gcc
LD=$(PREFIX)gcc
AS=$(PREFIX)as
AR=$(PREFIX)ar ruv
RANLIB=$(PREFIX)ranlib
DIFF=diff
CD=cd
RM=rm -rf
CP=cp -rf
MKDIR=mkdir -p

A=.a
O=.o
E=


MY_STL_DEBUGS=
MY_STL_INCLUDE=/home/scr/.rt/lang/0mystl/include
MY_STL_LIBDIR=/home/scr/.rt/lang/0mystl/lib
MY_STL_LIBNAME=nalstl
MY_STL_LIB=lib$(MY_STL_LIBNAME).a
MY_STL_CFLAGS=-c -g -Wall -I. $(MY_STL_DEBUGS)
MY_STL_LDFLAGS=-g

TEST_DEBUGS=
TEST_INCLUDES=-I./include -I$(MY_STL_INCLUDE)
TEST_LIBDIRS=-L./lib -L$(MY_STL_LIBDIR)
TEST_LIBS=-lm -l$(MY_STL_LIBNAME)
TEST_CFLAGS=-c -g -Wall $(TEST_INCLUDES) $(TEST_DEBUGS)
TEST_LDFLAGS=-g $(TEST_LIBDIRS) $(TEST_LIBS)



## modify this lines by yourself
MY_STL_OBJECTS = \
				 alg/alg_array/alg_array.o \
				 alg/alg_list/alg_list.o \
				 alg/alg_rand/alg_rand.o \
				 alg/alg_sort/alg_sort.o \
				 alg/alg_table/alg_table.o \
				 debug/memwatch/memwatch.o \

## modify this lines by yourself
TEST_OBJECTS = \
			   alg/alg_sort/alg_sort_test.o \


MY_STL_TARGETS = $(MY_STL_LIB)
TEST_TARGETS = $(patsubst %.o,%,$(TEST_OBJECTS))

TARGETS = \
		  $(MY_STL_TARGETS) \
		  $(TEST_TARGETS) \


all: $(TARGETS)


$(MY_STL_OBJECTS): %.o: %.c %.h
	$(CC) $(MY_STL_CFLAGS) $< -o $@
	$(MKDIR) $(MY_STL_INCLUDE)/$(dir $@)
	$(CP) $(patsubst %.o,%.h,$@) $(MY_STL_INCLUDE)/$(patsubst %.o,%.h,$@)

$(MY_STL_LIB): $(MY_STL_OBJECTS)
	$(AR) $@ $^
	$(RANLIB) $@ || true
	$(CP) commdef.h $(MY_STL_INCLUDE)/commdef.h
	$(CP) alg/alg_array/alg_arrayrep.h $(MY_STL_INCLUDE)/alg/alg_array/alg_arrayrep.h
	$(MKDIR) $(MY_STL_LIBDIR)
	$(CP) $(MY_STL_LIB) $(MY_STL_LIBDIR)/$(MY_STL_LIB)


$(TEST_OBJECTS): %.o: %.c %.h
	$(CC) $(TEST_CFLAGS) $< -o $@

$(TEST_TARGETS): %: %.o $(MY_STL_LIBDIR)/$(MY_STL_LIB)
	$(LD) -o $@ $< $(TEST_LDFLAGS)


#install:

uninstall:
	$(CD) $(MY_STL_INCLUDE); $(RM) *
	$(CD) $(MY_STL_LIBDIR);  $(RM) *


clean:
	$(RM) $(MY_STL_OBJECTS) $(TEST_OBJECTS) $(TEST_TARGETS)

cleanall: clean
	$(RM) $(MY_STL_LIB)


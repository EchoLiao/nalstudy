
CC := gcc
CFLAGS := -g -Wall

TARGETS = \
		  unicode_utf-8_test \

OBJS = \
	   unicode_utf-8.o \
	   unicode_utf-8_test.o \

TOP = .

LLDLIBS = 

targets: $(TARGETS)


def:
	find . -name '*.c' | xargs gcc -MM | \
	sed 's/\(^[^ :]*\).o:/\1:/' > Makefile.d;


$(TARGETS): %: %.o unicode_utf-8.o
	gcc $^ $(LLDLIBS) -o $@

$(OBJS): %.o: %.c %.h
	gcc -c $(CFLAGS) -I/usr/include -I$(TOP) $< $(LLDLIBS) -o $@


-include Makefile.d


clean:
	-rm -f *.o $(TARGETS) $(IMAGING_SUBSET)

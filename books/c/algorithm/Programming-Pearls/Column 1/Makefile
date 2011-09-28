TOP = .

CC := gcc
CXX := g++
CFLAGS := -g -Wall -I/usr/include -I$(TOP)
CXXFLAGS := $(CFLAGS)
LLDLIBS = -lm

TARGETS = \
		  bitsort \
		  bitsortgen \
		  qsortints \

CPP_TAGETS = \
		  sortints \

all: $(TARGETS) $(CPP_TAGETS)

$(TARGETS): %: %.o
	$(CC) $(LLDLIBS) $< -o $@

$(CPP_TAGETS): %: %.o
	$(CXX) $(LLDLIBS) $< -o $@

#include Makefile.def


clean:
	-rm -f *.o $(TARGETS) $(CPP_TAGETS)

cleanall: clean
	-rm -f Makefile.def

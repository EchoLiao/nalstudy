TOP = .

CC := gcc
CXX := g++
CFLAGS := -g -Wall -I/usr/include -I$(TOP)
CXXFLAGS := $(CFLAGS)
LLDLIBS = -lm

TARGETS = \
		  rotate \
		  sign \
		  squash \

CPP_TAGETS = \

all: $(TARGETS) $(CPP_TAGETS)

$(TARGETS): %: %.o
	$(CC) $(LLDLIBS) $< -o $@

$(CPP_TAGETS): %: %.o
	$(CXX) $(LLDLIBS) $< -o $@

#include Makefile.def

run: all
	# finding anagrams
	./sign < data | sort | ./squash

clean:
	-rm -f *.o $(TARGETS) $(CPP_TAGETS)

cleanall: clean
	-rm -f Makefile.def

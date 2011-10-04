
TARGETS = peitgen

TOP = .

GLUT = -lglut
LLDLIBS = $(GLUT) -lGLU -lGL -lXmu -lXext -lX11 -lm



peitgen: peitgen.cpp
	g++ -Wall -g -I/usr/include -I$(TOP) $< $(LLDLIBS) -o $@

clean:
	-rm -f *.o $(TARGETS)

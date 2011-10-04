
TARGETS = rand

TOP = .

GLUT = -lglut
LLDLIBS = $(GLUT) -lGLU -lGL -lXmu -lXext -lX11 -lm



rand: rand.cpp
	g++ -Wall -g -I/usr/include -I$(TOP) $< $(LLDLIBS) -o $@

clean:
	-rm -f *.o $(TARGETS)

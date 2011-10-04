
TARGETS = threedots

TOP = .

GLUT = -lglut
#LLDLIBS = -lGLEW $(GLUT) -lGLU -lGL -lXmu -lXext -lX11 -lm
LLDLIBS = $(GLUT) -lGLU -lGL -lXmu -lXext -lX11 -lm



threedots: main.cpp
	g++ -g -I/usr/include -I$(TOP) $< $(LLDLIBS) -o $@

clean:
	-rm -f *.o $(TARGETS)

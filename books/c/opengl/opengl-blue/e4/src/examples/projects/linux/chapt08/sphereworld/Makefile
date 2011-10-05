# you need to modify follow two line
MAIN = sphereworld
MAIN_PATH = chapt08

LIBDIRS = -L/usr/local/lib
INCDIRS = -I/usr/include -I/usr/local/include/GL -I../../../../src/shared -I/usr/include/GL
MAIN_SRCPATH = ../../../../src/$(MAIN_PATH)/$(MAIN)
SHAREDPATH = ../../../../src/shared

CXX = g++
CPPFLAGS = $(COMPILERFLAGS) -g $(INCDIRS) -Wall
LIBS = -lglut -lGL -lGLU -lm

main_objects = $(MAIN).o
share_objects = math3d.o gltools.o
glee_object = GLee.o

all : $(MAIN)


$(main_objects) : %.o : $(MAIN_SRCPATH)/%.cpp
	$(CXX) -c $(CPPFLAGS) $< -o $@

$(share_objects) : %.o : $(SHAREDPATH)/%.cpp
	$(CXX) -c $(CPPFLAGS) $< -o $@

$(glee_object) : %.o : $(SHAREDPATH)/%.c
	$(CXX) -c $(CPPFLAGS) $< -o $@

$(MAIN) : $(main_objects) $(share_objects) $(glee_object)
	$(CXX) $(CPPFLAGS) -o $@ $(LIBDIRS) $^ $(LIBS)

clean:
	rm -f *.o $(MAIN)

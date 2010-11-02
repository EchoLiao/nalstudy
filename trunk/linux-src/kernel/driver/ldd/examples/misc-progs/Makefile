
FILES = nbtest load50 mapcmp polltest mapper setlevel setconsole \
	datasize dataalign netifdebug \
	asynctest \
	#outp \
	#inp\

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
INCLUDEDIR = $(KERNELDIR)/include
CFLAGS = -O2 -fomit-frame-pointer -Wall -I$(INCLUDEDIR)

all: $(FILES)

clean:
	rm -f $(FILES) *~ core

#
# Copyright (c) 1993-2003, Silicon Graphics, Inc.
# All Rights Reserved
#
# Permission to use, copy, modify, and distribute this software for any
# purpose and without fee is hereby granted, provided that the above
# copyright notice appear in all copies and that both the copyright
# notice and this permission notice appear in supporting documentation,
# and that the name of Silicon Graphics, Inc. not be used in
# advertising or publicity pertaining to distribution of the software
# without specific, written prior permission.
#
# THE MATERIAL EMBODIED ON THIS SOFTWARE IS PROVIDED TO YOU "AS-IS" AND
# WITHOUT WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR OTHERWISE,
# INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY OR
# FITNESS FOR A PARTICULAR PURPOSE.  IN NO EVENT SHALL SILICON
# GRAPHICS, INC.  BE LIABLE TO YOU OR ANYONE ELSE FOR ANY DIRECT,
# SPECIAL, INCIDENTAL, INDIRECT OR CONSEQUENTIAL DAMAGES OF ANY KIND,
# OR ANY DAMAGES WHATSOEVER, INCLUDING WITHOUT LIMITATION, LOSS OF
# PROFIT, LOSS OF USE, SAVINGS OR REVENUE, OR THE CLAIMS OF THIRD
# PARTIES, WHETHER OR NOT SILICON GRAPHICS, INC.  HAS BEEN ADVISED OF
# THE POSSIBILITY OF SUCH LOSS, HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE POSSESSION, USE
# OR PERFORMANCE OF THIS SOFTWARE.
#
# US Government Users Restricted Rights
# Use, duplication, or disclosure by the Government is subject to
# restrictions set forth in FAR 52.227.19(c)(2) or subparagraph
# (c)(1)(ii) of the Rights in Technical Data and Computer Software
# clause at DFARS 252.227-7013 and/or in similar or successor clauses
# in the FAR or the DOD or NASA FAR Supplement.  Unpublished - rights
# reserved under the copyright laws of the United States.
#
# Contractor/manufacturer is:
#		  Silicon Graphics, Inc.
#		  1500 Crittenden Lane
#		  Mountain View, CA  94043
#		  United State of America
#
# OpenGL(R) is a registered trademark of Silicon Graphics, Inc.
#
#

CC := gcc
CFLAGS := -g -Wall

TARGETS = \
		  aaindex aargb accanti accpersp alpha3D \
		  alpha bezcurve bezmesh bezsurf blendeqn \
		  checker clip colormat combiner cubemap \
		  cube dof double drawf feedback \
		  fogcoord fogindex fog font hello \
		  image light lines list material \
		  mipmap model movelight multisamp multitex \
		  mvarray pickdepth picksquare planet pointp \
		  polyoff polys quadric robot scene \
		  select shadowmap smooth stencil stroke \
		  surface surfpoints teapots tesswind tess \
		  texbind texgen texprox texsub texture3d \
		  texturesurf torus trim unproject varray \
		  wrap \
		  20e 20e-2 20e-3 20e-4 20e-5 20e-6 smooth-2 \
		  robot2 culling rotate_any \
		  movelight-2 pboimage\
#	  primrestart


#
# If the ARB imaging subset is not implemented on your platform, you may
# find that
#
#   make targets
#
# will be more convenient, since it will not attempt to make the programs
# relating to the Imaging Subset.

IMAGING_SUBSET = colormatrix colortable convolution histogram minmax

#
#  You may need to modify TOP and GLUT so that
#  GLUT is properly included.
#

TOP = .

GLUT = -lglut
#LLDLIBS = -lGLEW $(GLUT) -lGLU -lGL -lXmu -lXext -lX11 -lm
LLDLIBS = $(GLUT) -lGLU -lGL -lXmu -lXext -lX11 -lm


targets: $(TARGETS) $(IMAGING_SUBSET)


def:
	find . -name '*.c' | xargs gcc -MM | \
	sed 's/\(^[^ :]*\).o:/\1:/' > Makefile.d;


# 使用"静态模式"书写规则
#.PRECIOUS : %.o
#$(TARGETS) $(IMAGING_SUBSET): %: %.c
$(TARGETS): %: %.o
	gcc -I/usr/include -I$(TOP) $< $(LLDLIBS) -o $@

readImage.o: readImage.c
	gcc -g -c -I/usr/include -I$(TOP) $< -o $@

$(IMAGING_SUBSET): %: %.o readImage.o
	gcc -I/usr/include -I$(TOP) $< readImage.o $(LLDLIBS) -o $@


include Makefile.d


clean:
	-rm -f *.o $(TARGETS) $(IMAGING_SUBSET)


#PROGS_1 = \
		#example.1 \
		#example3.1 \
		#example4.1 \

PROGS_PDF = \
		example.pdf \
		example3.pdf \
		example4.pdf \

PROGS_PDF_LATEX = \
		sample.pdf \

PROGS =	\
		$(PROGS_1) \
		$(PROGS_PDF) \
		$(PROGS_PDF_LATEX) \

all: ${PROGS}


#$(PROGS_1): %.1: %.mp
%.1: %.mp
	mpost $<

$(PROGS_PDF): %.pdf: %.1
	epstopdf $<

$(PROGS_PDF_LATEX): %.pdf: %.tex
	pdflatex $<


clean:
	-rm -f $(PROGS)
	-rm -f *.log *.aux *.1

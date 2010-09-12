
PROGS =	test-yi.1 \
	hello/hello.html \
	hello.pdf

all:	${PROGS}


test-yi.1 : test-yi.mp
	mptopdf test-yi.mp

hello.pdf: hello.tex
	pdflatex hello.tex

hello/hello.html: hello.tex
	latex2html -split +0 hello.tex
#latex2html  -contents_in_navigation hello.tex
# 生成多个html文件

clean:
	rm -f *.pdf *.toc *.log *.aux *.rtf *.[0-9] *.keep *.dvi *temp* *.mpo *.mpx mp*
	rm -f hello/*.html

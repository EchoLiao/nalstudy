TARGET_DIR = ./public_html
ARGS = -m lang-zh_CN-autospace -m utf8 -m code-gvim -t bright.html --css bright -X

all: \
	$(TARGET_DIR)/*.html \
	update_filelist \


$(TARGET_DIR)/*.html: *.viki
	deplate -o $(TARGET_DIR)/*.html $(ARGS) *.viki
	echo *.html >> upload.txt
	rm -f ./public_html/*_code_* ./public_html/deplateCodeAuto*

update_filelist:
	mv upload.txt upload.bak
	sort upload.bak | uniq > upload.txt
	rm -f upload.bak

clean:
	rm -f $(TARGET_DIR)/*.html

cleanall:
	rm -f $(TARGET_DIR)/*.html
	rm -f $(TARGET_DIR)/*.css
	rm -f log*
	rm -f upload.txt
	rm -f Makefile

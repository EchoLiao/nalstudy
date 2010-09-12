TARGET_DIR = ./public_html
ARGS = -m lang-zh_CN-autospace -m utf8 -m code-gvim -t bright.html --css bright -X

all: \
	$(TARGET_DIR)/hello.html \
	$(TARGET_DIR)/hyperlink.html \
	$(TARGET_DIR)/MyHome.html \
	$(TARGET_DIR)/ViKi.html \
	update_filelist \


$(TARGET_DIR)/hello.html: hello.viki
	deplate -o $(TARGET_DIR)/hello.html $(ARGS) hello.viki
	echo hello.html >> upload.txt
	rm -f ./public_html/*_code_* ./public_html/deplateCodeAuto*

$(TARGET_DIR)/hyperlink.html: hyperlink.viki
	deplate -o $(TARGET_DIR)/hyperlink.html $(ARGS) hyperlink.viki
	echo hyperlink.html >> upload.txt
	rm -f ./public_html/*_code_* ./public_html/deplateCodeAuto*

$(TARGET_DIR)/MyHome.html: MyHome.viki
	deplate -o $(TARGET_DIR)/MyHome.html $(ARGS) MyHome.viki
	echo MyHome.html >> upload.txt
	rm -f ./public_html/*_code_* ./public_html/deplateCodeAuto*

$(TARGET_DIR)/ViKi.html: ViKi.viki
	deplate -o $(TARGET_DIR)/ViKi.html $(ARGS) ViKi.viki
	echo ViKi.html >> upload.txt
	rm -f ./public_html/*_code_* ./public_html/deplateCodeAuto*

update_filelist:
	mv upload.txt upload.bak
	sort upload.bak | uniq > upload.txt
	rm -f upload.bak

clean:
	rm -f $(TARGET_DIR)/hello.html
	rm -f $(TARGET_DIR)/hyperlink.html
	rm -f $(TARGET_DIR)/MyHome.html
	rm -f $(TARGET_DIR)/ViKi.html

cleanall:
	rm -f $(TARGET_DIR)/*.html
	rm -f $(TARGET_DIR)/*.css
	rm -f log*
	rm -f upload.txt
	rm -f Makefile

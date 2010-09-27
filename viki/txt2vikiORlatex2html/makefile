TARGET_DIR = ./public_html
ARGS = -m lang-zh_CN-autospace -m utf8 -m code-gvim -t bright.html --css bright -X

all: \
    pre_note.txt \
    pre_note.viki \
    note.viki \
    $(TARGET_DIR)/note.html \


pre_note.txt: note.txt pre_txt2viki.sed
	sed -f pre_txt2viki.sed note.txt > pre_note.txt

pre_note.viki: pre_note.txt txt2viki.sed
	sed -f txt2viki.sed pre_note.txt > pre_note.viki

note.viki: pre_note.viki las_txt2viki.sed
	sed -f las_txt2viki.sed pre_note.viki > note.viki

$(TARGET_DIR)/note.html: note.viki
	deplate -o $(TARGET_DIR)/note.html $(ARGS) note.viki
	echo note.html >> upload.txt
	rm -f ./public_html/*_code_* ./public_html/deplateCodeAuto*

update_filelist:
	mv upload.txt upload.bak
	sort upload.bak | uniq > upload.txt
	rm -f upload.bak

clean:
	rm -f pre_*.txt
	rm -f *.viki
	rm -f upload.txt
	rm -rf public_html

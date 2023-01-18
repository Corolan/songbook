DAT:=`date +"%Y%m%d"`
SONGLIST:=./tmp/songlist.tmp
TMP_SONGLIST:=`find ./src/songs/ -type f -name "*.tex"`



tex: clean
	mkdir ./tmp
	touch ${SONGLIST}
	for i in ${TMP_SONGLIST} ; do echo "\subfile{$${i}}" '\\newpage' >> ${SONGLIST};	done	
	cat ./src/songbook_1.tex ${SONGLIST} ./src/songbook_2.tex > ./tmp/songbook.tex
	
pdf: tex
	pdflatex ./tmp/songbook.tex
	mv songbook.aux  ./tmp/
	mv songbook.log  ./tmp/  
	mv songbook.toc  ./tmp/
	

clean:
	rm -rf ./tmp

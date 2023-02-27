DAT:=`date +"%Y-%m-%d"`
SONGLIST:=./tmp/songlist.tmp
TMP_SONGLIST=`find ./src/songs/ -type f -name "*.tex" | grep -v Religijne | grep -v Koledy | grep -v Dzieciece | grep -v Inne | sort; find ./src/songs/Religijne/ -type f -name "*.tex" | sort; find ./src/songs/Koledy/ -type f -name "*.tex" | sort; find ./src/songs/Dzieciece/ -type f -name "*.tex" | sort; find ./src/songs/Inne/ -type f -name "*.tex" | sort`
NUMBER_OF_SONGS:=`find ./src/songs/ -type f -name "*.tex" | wc -l`

clean:
	@rm -rf ./tmp
	@rm -rf ./*.pdf

tex: clean
	@mkdir ./tmp
	@./bin/stats.sh
	@touch ${SONGLIST}
	@for i in ${TMP_SONGLIST} ; do echo "\subfile{$${i}}" '\\newpage' >> ${SONGLIST}; done	
	@cat ./src/songbook_1.tex | sed -e "s/XXX/${DAT}/" -e "s/YYY/${NUMBER_OF_SONGS}/"  > ./tmp/songbook_1.tmp
	@cat ./tmp/songbook_1.tmp ${SONGLIST} ./tmp/songbook_2.tmp > ./tmp/songbook.tex
	@cp ./tmp/songbook.tex .

pdf: tex
	@pdflatex ./tmp/songbook.tex  # > /dev/null
	@pdflatex ./tmp/songbook.tex  > /dev/null 2>&1 #second time is necessary for toc
	@mv songbook.aux  ./tmp/
	@mv songbook.log  ./tmp/  
	@mv songbook.toc  ./tmp/
	@mv songbook.out  ./tmp/

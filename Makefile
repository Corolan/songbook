SHELL=/bin/bash
DAT:=`date +"%Y-%m-%d"`
PREV_DAT:=`tail -n 1 ./releases/releases.log`
SONGLIST:=./tmp/songlist.tmp
SONGLIST_ERRATA:=./tmp/songlist_errata.tmp
TMP_SONGLIST:=`find ./src/songs/ -type f -name "*.tex" | grep -v Religijne | grep -v Koledy | grep -v Dzieciece | grep -v Inne | sort; find ./src/songs/Religijne/ -type f -name "*.tex" | sort; find ./src/songs/Koledy/ -type f -name "*.tex" | sort; find ./src/songs/Dzieciece/ -type f -name "*.tex" | sort; find ./src/songs/Inne/ -type f -name "*.tex" | sort`
NUMBER_OF_SONGS:=`find ./src/songs/ -type f -name "*.tex" | wc -l`

clean:
	@rm -rf ./tmp
	@rm -rf ./output
	@rm -rf ./*.pdf
	@rm -rf ./*.tex

tex: clean
	@mkdir -p output
	@mkdir -p  ./tmp
	@./bin/stats.sh
	@touch ${SONGLIST}
	@for i in ${TMP_SONGLIST} ; do echo "\subfile{$${i}}" '\newpage' >> ${SONGLIST}; done	
	@cat ./src/songbook_1.tex | sed -e "s/XXX/${DAT}/" -e "s/YYY/${NUMBER_OF_SONGS}/"  > ./tmp/songbook_1.tmp
	@cat ./tmp/songbook_1.tmp ${SONGLIST} ./tmp/songbook_2.tmp > ./tmp/songbook.tex
	@cp ./tmp/songbook.tex ./output/

pdf: tex
	@pdflatex -output-directory=./output ./tmp/songbook.tex  # > /dev/null
	@pdflatex -output-directory=./output ./tmp/songbook.tex  > /dev/null 2>&1 #second time is necessary for toc
	@mv ./output/songbook.aux  ./tmp/
	@mv ./output/songbook.log  ./tmp/  
	@mv ./output/songbook.toc  ./tmp/
	@mv ./output/songbook.out  ./tmp/

release: pdf
	@echo release
	@mkdir -p releases/${DAT}
	@echo ${DAT} >> releases/releases.log
	@echo ${TMP_SONGLIST} | tr " " "\n" > ./releases/${DAT}/songlist.log
	@cp ./output/songbook.pdf ./releases/${DAT}/
	@cp ./output/songbook.tex ./releases/${DAT}/
	
check-for-changes:
	@echo Poprzedni release wykonano ${PREV_DAT}
	@echo ${TMP_SONGLIST} | tr " " "\n" > /tmp/sng.tmp
	@-diff /tmp/sng.tmp ./releases/${PREV_DAT}/songlist.log | grep "src" | tr -d " " | tr -d "<" > /tmp/diff.log
	@if [[ `cat /tmp/diff.log` == "" ]]; then \
		echo "Brak zmian względem poprzedniego release'u"; \
	else \
		echo "Znaleziono nowe pliki względem poprzedniego release'u:"; cat /tmp/diff.log; \
	fi
	
errata: clean check-for-changes tex
	@touch ${SONGLIST_ERRATA}
	for i in `cat /tmp/diff.log`; do echo "\subfile{$${i}}" '\newpage' >> ${SONGLIST_ERRATA}; done	
	@cat ./tmp/songbook_1.tmp ${SONGLIST_ERRATA} ./tmp/songbook_2.tmp > ./tmp/songbook_errata.tex
	@pdflatex -output-directory=./output ./tmp/songbook_errata.tex  # > /dev/null 2>&1
	@cp ./tmp/songbook_errata.tex ./output/
	@mv ./output/songbook_errata.aux  ./tmp/
	@mv ./output/songbook_errata.log  ./tmp/  
	@mv ./output/songbook_errata.toc  ./tmp/
	@mv ./output/songbook_errata.out  ./tmp/
	


#!/bin/bash


echo -e 'Statystyki: \\newline' > ./tmp/songbook_2.tmp
echo -e '\\TabPositions{9cm}' >> ./tmp/songbook_2.tmp
echo -e '{\\footnotesize' >> ./tmp/songbook_2.tmp
echo -e '\\textbf{Wykonawca - Album  \\tab Liczba piosenek} \n\n' >> ./tmp/songbook_2.tmp
for i in $(find ./src/songs/ -type f -name "*.tex"); do grep -oP 'rightline{\(\K[^\)}]+' $i | grep -v capo | grep -vi tonacja; done | sort | uniq -c | sed 's/-"Nieznany"//g' | awk '{first = $1; $1=""; print $0, " \\tab", first " \\newline"}' >> ./tmp/songbook_2.tmp
echo -e '\\textbf{\nWykonawca \\tab Liczba piosenek} \n\n' >> ./tmp/songbook_2.tmp
for i in $(find ./src/songs/ -type f -name "*.tex"); do grep -oP 'rightline{\(\K[^-]+' $i | grep -v capo | grep -vi tonacja; done | sort | uniq -c | sed 's/-"Nieznany"//g' | awk '{first = $1; $1=""; print $0, " \\tab", first " \\newline"}' >> ./tmp/songbook_2.tmp
echo -e '\n }' >> ./tmp/songbook_2.tmp
echo -e '\n\n \\end{document}' >> ./tmp/songbook_2.tmp


exit 0

#/bin/bash

read -p 'Song title: ' TITLE
read -p 'Artist: ' ARTIST
read -p 'Album: ' ALBUM
read -p 'nazwa pliku: ' FILE
TITLE_BIG=`echo ${TITLE^^}`

echo -e "Artist: $ARTIST"
DIRECTORY=`echo $ARTIST | tr -d '' | sed 'y/ęóąśćłżźńĘÓĄŚĆŁŻŹŃ/eoasclzznEOASCLZZN/' | tr -d ' '`
echo -e "Song:   $TITLE --- ${TITLE_BIG}"
echo -e "Album:  $ALBUM"

SONG_DIR="src/songs/$DIRECTORY"

mkdir -p $SONG_DIR

cat ./bin/new-song-empty.txt | sed  -e "s/TITLE-BIG/${TITLE_BIG}/g" -e "s/ARTIST/${ARTIST}/g" -e "s/ALBUM/${ALBUM}/g" -e "s/TITLE/${TITLE}/g" > ${SONG_DIR}/${FILE}.tex


exit 0

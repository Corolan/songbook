# My songbook

# Introduction
This songbook was created to migrate my old songbook composed with sheets of paper, some printed pdfs, and other sources into one integrated file.
Ther are latex packeges made for songbooks, but i created this files because i got used to this layout.

## File structure
```bash
user@debian:~/songbook$ tree .
.
├── bin
│   ├── add-new-song.sh
│   └── new-song-empty.txt
├── images
│   └── **images-files**
├── Makefile
├── README.md
└── src
    ├── songbook_1.tex
    ├── songbook_2.tex
    └── songs
        └── **song-files**
```
## Usage
To add a song use `add-new-song.sh` script. It will add an empty file prepared to be filled in directory `src/songs/ARTIST`.


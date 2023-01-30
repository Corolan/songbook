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
├── src
│   ├── songbook_1.tex
│   ├── songbook_2.tex
│   └── songs
│       ├── **song-files**
└── tmp
    ├── songbook_1.tmp
    ├── songbook.aux
    ├── songbook.log
    ├── songbook.out
    ├── songbook.tex
    ├── songbook.toc
    └── songlist.tmp
```
##Usage

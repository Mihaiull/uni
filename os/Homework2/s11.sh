#!/bin/bash

# Write a shell script which takes as parameter a HTML file name.
# The script will convert the given HTML file to a text file (all HTML tags will be removed).

html2text=$1

sed 's/<[^>]*>//g' $html2text > $(basename $html2text .html).txt

#this is indeed a funky one:
# s/ - substitute
# <[^>]*> - any tag (yknow the </body> and stuff html uses)
# g - global (all tags)
# $(basename $html2text .html).txt - the output file (basename is a command that returns the filename without the extension) and the extension is changed to .txt

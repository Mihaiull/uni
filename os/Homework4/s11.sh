#!/bin/bash

# Write a shell script which takes as parameter a HTML file name.
# The script will convert the given HTML file to a text file (all HTML tags will be removed).

html2text=$1

sed 's/<[^>]*>//g' $html2text > $(basename $html2text .html).txt

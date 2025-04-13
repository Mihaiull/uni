#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will display the number of files, the average number of words per file and the total word count.

# # Initialize variables
# total_files=0
# total_words=0

# for file in "$@"; do
#     # Check if the file exists
#     if [[ -f "$file" ]]; then
#         # Increment the file count
#         total_files=$((total_files + 1))
#         # Get the word count for the file
#         total_words=$((total_words + $(wc -w < $file))) #why does this end up being 132 insteand of 15?
#     else
#         # Print an error message if the file does not exist
#         echo "File $file does not exist."
#     fi
# done

# echo "Total files: $total_files"
# echo "Total words: $total_words"
# if [[ $total_files -gt 0 ]]; then
#     average_words=$((total_words / total_files))
#     echo "Average words per file: $average_words"
# else
#     echo "No valid files provided."
# fi

# unfortunately i am obligated to use awk

# Check for at least one file argument
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 file1 [file2 ... fileN]"
    exit 1
fi

# Pass all files to awk
awk '
BEGIN {
    total_words = 0;
    file_count = 0;
}
FNR == 1 { # First line of a new file (used to count files since you only get to the first line once)
    file_count++; # New file started
}
{
    total_words += NF; # NF = number of fields (words) in the current line
}
END {
    if (file_count == 0) {
        avg = 0;
    } else {
        avg = total_words / file_count;
    }
    printf "Number of files: %d\n", file_count;
    printf "Average words per file: %.2f\n", avg;
    printf "Total word count: %d\n", total_words;
}
' "$@" # Pass all files to awk

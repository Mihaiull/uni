#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will display the number of files, the average number of words per file and the total word count.
# using awk


# Initialize variables
total_files=0
total_words=0

for file in "$@"; do
    # Check if the file exists
    if [[ -f "$file" ]]; then
        # Increment the file count
        total_files=$((total_files + 1))
        # Get the word count for the file
        total_words=$((total_words + $(wc -w < $file))) #why does this end up being 132 insteand of 15?
    else
        # Print an error message if the file does not exist
        echo "File $file does not exist."
    fi
done

echo "Total files: $total_files"
echo "Total words: $total_words"
if [[ $total_files -gt 0 ]]; then
    average_words=$((total_words / total_files))
    echo "Average words per file: $average_words"
else
    echo "No valid files provided."
fi

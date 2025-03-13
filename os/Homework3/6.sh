#!/bin/bash

# Write a shell script that reads words from keyboard
# (the reading stops when the user has entered the word "stop").
# The script will display the list of words entered from the keyboard.

words=()
while true; do
    read -p "Enter a word (stop to stop): " word
    if [ "$word" = "stop" ]; then
        break
    fi
    words+=("$word")
done

echo "Words entered: ${words[@]}"

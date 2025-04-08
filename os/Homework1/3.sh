#!/bin/bash

# Write a shell script which takes as parameter a natural number. The script
# will check wheather the given number is prime or not.

prime=$1

if [ $prime -lt 2 ]; then
    echo "$prime is not a prime number."
elif [ $prime -eq 2 ]; then
    echo "$prime is a prime number."
else
    is_prime=1
    for ((i=2; i*i<=prime; i++)); do
        if [ $((prime % i)) -eq 0 ]; then
            is_prime=0
            break
        fi
    done
    if [ $is_prime -eq 1 ]; then
        echo "$prime is a prime number."
    else
        echo "$prime is not a prime number."
    fi
fi

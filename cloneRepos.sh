#!/bin/bash

FILE="test.txt"

while read LINE; do 
        echo "line: $LINE"
        eval git clone $LINE 
done < $FILE

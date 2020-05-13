#!/bin/bash
#Simply places a line before any line taht contains the word Linux
line="The next line conatins the word Linux"
echo "Editing file"
output=$(cat $1 | sed '/Linux/i The next line contains the word Linux')
echo "Saving File..."
echo "$output" > $1
echo "All done!"

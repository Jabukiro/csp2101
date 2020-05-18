#!/bin/bash
#######################################
######## Author
######## Herve-Daniel Barihuta
######## 10414550
#######################################s

#Control script usage
if [ $# -lt 1 ]
then
	echo "Usage : $0 <filename>"
	exit 100
elif ! [ -f $1 ]
then
	echo "Error: $1 - No such file"
	exit 101
fi
outfile=rectangle_f.txt
echo "Parsing input file..."

# The script is ran with 3 options to sed
# With references allowed, with output suppressed and with Extended Regular Expressions enabled
# The command is a substitution of any line that matches the following pattern:
#### Line begins with a combination of letters and numbers, followed by a comma
#### Followed by one or more digits, followed by a comma -- x3
#### Followed by any combination of letters and numbers.
# 5 group patterns are then referenced in the substituing string.
# Finaly the result is printed and saved.

output=$(cat $1 | sed -rnE 's/(^[[:alnum:]]+),([[:digit:]]+),([[:digit:]]+),([[:digit:]]+),([[:alpha:]]+)/Name: \1\tHeight: \2\tWidth: \3\tArea: \4\tColour: \5/p')
echo "$output" > "$outfile"
echo -e "-----------------------------------------------------"
echo -e "\n$output\n"
echo -e "-----------------------------------------------------"
echo "Output above saved to $outfile"


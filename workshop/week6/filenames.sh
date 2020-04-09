#!/bin/bash
! [ -f $1 ] && echo "Input need ot be a file" && exit 0
while IFS= read -r line; do
	if [[ -f "$line" ]]; then
		echo "Text read from $1: $line is a file"
	elif [[ -d "$line" ]]; then
		echo  "Text read from $1: $line is a directory"
	else
		echo "Text read from $1: $line is of unknown type"
	fi
	read
done < "$1"

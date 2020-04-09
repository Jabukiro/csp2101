#!/bin/bash
#if there aren't two arguments to the script
if (( $#!=2 )); then
	echo "Error, provide tow numbers" && exit 1
fi

for ((i = $1; i <= $2; i++))
do 
	echo "Creating directory number $i"
	mkdir "week$i"
done

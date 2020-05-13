#!/bin/bash
#######################################
######## Author
######## Herve-Daniel Barihuta
######## 10414550
#######################################
#Extra: Generalise for comma separated values

#Control script usage
if [ $# -lt 1 ]
then
	echo "Usage : $0 filename"
	exit 100
elif ! [ -f $1 ]
then
	echo "Error: $1 - No such file"
	exit 101
fi

output = $(cat $1 | sed -n 

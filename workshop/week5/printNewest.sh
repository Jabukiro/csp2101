#!/bin/bash
echo $0
echo $1
echo $2
echo $3
[ -v 3 ] || echo "Error: 3 arguments needed master. Bye." && exit 1
[ -f $1 ] && [ -f $2 ] && [ -f $3 ] || echo "Not all 3 arguments are filenames B. Bye." && exit 1
if [ $1 -nt $2 ] && [ $2 -nt $3]; then
	cat "$1"
	exit 0
elif [ $2 -nt $1 ] && [ $2 -nt $3 ]; then
	cat "$2"
	exit 0
else
	cat "$3"
	exit 0


#!/bin/bash
[ -f secret.txt ] && target=$(cat secret.txt) && rm secret.txt
low=0
high=120
guess=60
steps=0
while [ $steps -lt 100 ]
do
	echo "$target | $guess --$low  $high--"
	steps=$((steps+1))
	if (( guess == target )); then
		echo "Found the guess in $steps Guesses. Beat me I dare ya!!"
		exit 0
	elif (( guess < target )); then
		low=$guess
		guess=$(python3 -c "print(($low+$high)//2)")
	elif (( guess > target )); then
		high=$guess
		guess=$(python3 -c "print(($low+$high)//2)")
	fi
done


		


#!/bin/bash
#Simple bot to play guessage.sh
#Number of guesses is usually and no worse than log2(n)
#n being the range of guesses.
# Author:
#	Herve-Daniel BARIHUTA
#	10414550
#	github.com/jabukiro

#Read target input and delete it.
[ -f secret.txt ] && target=$(cat secret.txt) && rm secret.txt
low=0
high=120
guess=60
steps=0

#Cap guessing attempts to 100.
while [ $steps -lt 100 ]
do
	#echo "$target | $guess --$low  $high--"
	steps=$((steps+1))
	#Taunt the player
	if (( guess == target )); then
		echo "The bot found the age in $steps Guesses. Beat it I dare ya!!"
		exit 0

	#Halve space search depending which side target is located.
	elif (( guess < target )); then
		low=$guess
		guess=$(( ($low+$high)/2 ))

		#guess=$(python3 -c "print(($low+$high)//2)")
		#guess=$(perl -E "say int(($low+$high)/2)")

	elif (( guess > target )); then
		high=$guess
		guess=$(( ($low+$high)/2 ))

		#guess=$(python3 -c "print(($low+$high)//2)")
		#guess=$(perl -E "say int(($low+$high)/2)")
	fi
done
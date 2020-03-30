#!/bin/bash
source ~/CSP2101/workshop/week5/colourSnippet.sh
f=$((120*RANDOM/32767))
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n
                                     Welcome to Guessing Game\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
echo $f > secret.txt
./guessageBot.sh
while true
do
	read -p "Enter guess for age >" guess
	if (( guess < 0 )); then
		echo "Bye Quiter!"
		exit 0
		break	
	fi
	if (( guess == f )); then
		echo "Your guess is correct!!!! $f yo"
		exit 0
	elif (( guess < f )); then
		echo "Your guess is too low"
	elif (( guess > f )); then
		echo "Your guess is too high"
	fi
done

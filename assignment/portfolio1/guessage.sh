#!/bin/bash
#############################
#	Author:
#		Herve-Daniel BARIHUTA
#		10414550
#		github.com/jabukiro
#############################
#Implement ability to set own range

#Set colours that will be used in output
source ../../workshop/week5/colourSnippet.sh
#get target in correct range
target=$((120*RANDOM/32767))
#Print nice-ish welcome message
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
echo -e "                                     Welcome to Guessing Game"
echo -e "                     Guess the age of a random person(between 0 and 120)\n"
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

#Input target to guessing bot
echo $target > secret.txt
#Run guessing bot
./guessageBot.sh

#Start infinite loop for user to guess target
while true
do
	read -p "Enter guess for age >" guess
	#Input validation
	if ! [[ $guess =~ ^[+-]?[0-9]+$ ]]; then
		echo "Input not a number."
		continue
	fi
	#Quit Game
	if (( guess < 0 )); then
		echo "Bye Quiter!"
		exit 0
		break	
	fi
	#Guess correct
	if (( guess == target )); then
		echo -e "${GREEN}Your guess is correct!!!! $target yo${NC}"
		exit 0
	#Guess lower than target
	elif (( guess < target )); then
		echo -e "${BLUE}Your guess is too low${NC}"
	#Guess higher than target
	elif (( guess > target )); then
		echo -e "${RED}Your guess is too high${NC}"
	fi
done
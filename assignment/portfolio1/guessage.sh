#!/bin/bash
#Implement --help
#
source ../../workshop/week5/colourSnippet.sh
target=$((120*RANDOM/32767))
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n
                                     Welcome to Guessing Game\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
echo $target > secret.txt
./guessageBot.sh
numberReg='^[0-9]$'
while true
do
	read -p "Enter guess for age >" guess
	if ! [[ $guess =~ ^[+-]?[0-9]+$ ]]; then
		echo "Input not a number."
		continue
	fi

	if (( guess < 0 )); then
		echo "Bye Quiter!"
		exit 0
		break	
	fi
	if (( guess == target )); then
		echo -e "${GREEN}Your guess is correct!!!! $target yo${NC}"
		exit 0
	elif (( guess < target )); then
		echo -e "${BLUE}Your guess is too low${NC}"
	elif (( guess > target )); then
		echo -e "${RED}Your guess is too high${NC}"
	fi
done

#!/bin/bash
source colourSnippet.sh
float=$(echo "$1$3" | grep .)

case $2 in
	+)
		echo -e "${BLUE}$(($1+$3))"
		;;
        -)
                echo -e "${GREEN}$(($1-$3))"
		;;
        x)
                echo -e "${RED}$(($1*$3))"
		;;
        /)
                echo -e "${PURPLE}$(($1/$3))"
		;;
	*)
		echo "No such Opperation";;
esac

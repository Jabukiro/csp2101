#!/bin/bash
#######################################
######## Herve-Daniel Barihuta
######## 10414550
#######################################s

#Set constants
first=1533
last=2042
saveDir="thumbnails"
baseDir="https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/"
prefix="DSC0"
suffix=".jpg"

#Create saving directory if doesn't exists
if ! [[ -d "$saveDir" ]]; then
	mkdir "$saveDir"
fi
function interpret {
	case "$1" in
		all)
			getAll $first $last
			output
			;;
		DSC0[0-9][0-9][0-9][0-9])
			getSpecific $1
			output
			;;
		range)
			getRange $2 $3
			output
			;;
		*)
			echo "Usage: $0 {all|range|rand|<thumbnail>}"
			echo -e "\n\t<thumbnail> is of the form: DSC0xxxx, with x a digit. Downloads single file."
			exit 100

	esac
}

function getSize {
#Assumes file wget.log exists and last download was completed successfully
currSize=$( cat wget.log | sed -rnE 's/^Length: ([0-9]+) .*/\1/p' )
if [[ $currsize -gt 1000000000 ]]; then
	currSize=$(perl -E "say $currSize/1000000000 . 'GB'")
elif [[ $currsize -gt 999999 ]]; then
	currSize=$(perl -E "say $currSize/1000000 . 'MB'")
else
	currSize=$(perl -E "say $currSize/1000 . 'KB'")

fi
}

function exists {
	if [[ -f "$1" ]]; then
		echo -e "Skipping file $1 already downloaded..."
		return 1
	else
		return 0
	fi
}

function output {
	case "$1" in
		DSC0*)
			echo -e "Downloading $1, with the file name $2, with a file size of $currSize..."
			echo -e "File Download Complete\n"
			;;
		404)
			echo -e "Error: $2 No Such File On Server..."
			;;

		*)
			echo "PROGRAM FINISHED"
			exit 0
			;;
	esac

}

function getAll {
	curr=$1
	result=1
	for (( i = 0; i <= $(($2-$1)); i++ )); do
		#Firs check if file already exists
		exists "$saveDir/$prefix$curr$suffix"
		if [[ $? == 0 ]]; then
			wget -o wget.log --directory-prefix="$saveDir" "$baseDir$prefix$curr$suffix"	
			
			case "$?" in
				0)
					getSize
					rm wget.log
					output "$prefix$curr" "$prefix$curr$suffix"
					#At least one image downloaded
					result=0
					;;
				*)
			esac
		else
			#File exists on server but already downloaded
			result=0
		fi
		curr=$((curr+1))

	done
	return $result
}

function getSpecific {
	curr=$1
	#first check if file already exists
	exists "$saveDir/$curr$suffix"
	if [[ $? == 0 ]]; then
		wget -o wget.log --directory-prefix="$saveDir" "$baseDir$curr$suffix"
		case "$?" in
			0)
				getSize
				rm wget.log
				output "$curr" "$curr$suffix"
				;;
			8)#wget 404 Error
				output 404 "$curr$suffix"
				;;
				
		esac
	fi
}

function getRange {
	if echo "$1$2" | grep -Eq '[0-9]{8,}'; then
		if ! [[ $1 -gt $2 ]]; then
			getAll $1 $2
			if [[ $? -eq 1 ]]; then echo -e "No File found in given range."; fi
		else
			echo -e "<end> must be greater than <start>"

		fi

	else

		echo -e "Usage - range: ./thumbnail.sh range <start> <end>"
		echo -e "\n\t <start> and <end> of the form xxxx; where x is a digit"	
	fi
}
interpret $1 $2 $3

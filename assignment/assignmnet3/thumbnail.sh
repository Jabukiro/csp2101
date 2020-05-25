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
echo "$#; $1"
if ! [[ -d "$saveDir" ]]; then
	mkdir "$saveDir"
fi
function interpret {
	echo $#
	case "$1" in
		all)
			getAll
			;;
		*)
			echo $"Usage: $0 {all|range|<integer>|<thumbnail>}"
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
		echo -e "Skipping file $1 already exists..."
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

		*)
			echo "PROGRAM FINISHED"
			;;
	esac

}

function getAll {
	curr=$first
	for (( i = 0; i <= $(($last-$first)); i++ )); do
		#Firs check if file already exists
		exists "$saveDir/$prefix$curr$suffix"
		if [[ $? == 0 ]]; then
			wget -o wget.log --directory-prefix="$saveDir" "$baseDir$prefix$curr$suffix"	
			
			case "$?" in
				0)
					getSize
					rm wget.log
					output "$prefix$curr" "$prefix$curr$suffix"
					;;
				*)
			esac
		fi
		curr=$((curr+1))

	done
}

interpret $1

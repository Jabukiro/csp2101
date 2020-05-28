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
declare -A filesArray
#Create saving directory if doesn't exists
if ! [[ -d "$saveDir" ]]; then
        mkdir "$saveDir"
fi

#Entry point of script
#Simply interprets option and calls appropriate function
function main {
	echo -e "---------------------------------------------------------------------------"
        echo -e "\n                      Ultimate Thumbnail Downloader                    \n"
	echo -e "---------------------------------------------------------------------------"
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
                rand)
                        getRandom $2
                        output
                        ;;
                *)
                        echo -e "\nUsage: $0 { all|range|rand|<thumbnail> }"
			echo -e "\n\tall: downloads all thumbnails."
			echo -e "\trange <start> <end>: Downloads all thumbnails within the <start> <end> range (inclusive)."
			echo -e "\trand <pick>: Downloads random number of thumbnails specified by <pick>."
                        echo -e "\t<thumbnail>: is of the form DSC0xxxx, with x a digit. Downloads a single file.\n"
                        exit 100

        esac
}

#Formats the size of downloaded file
#Available in currSize after being called
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

#Checks if file has already been downloaded
function exists {
        if [[ -f "$1" ]]; then
                echo -e "Skipping file $1 already downloaded..."
                return 1
        else
                return 0
        fi
}

#Output to screen the status of the download
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

#Downloads all available thumbnails
function getAll {
        #first := $1
        #Last := $2
        curr=$1
        result=1
        for (( i = 0; i <= $(($2-$1)); i++ )); do
                #First check if file already exists
                exists "$saveDir/$prefix$curr$suffix"
                #Proceed with download if it doesn't
                if [[ $? == 0 ]]; then
                        wget -o wget.log --directory-prefix="$saveDir" "$baseDir$prefix$curr$suffix"

                        #Check whether Download was succesful or not
                        case "$?" in
                                #Succesfull case
                                0)
                                        getSize
                                        rm wget.log
                                        output "$prefix$curr" "$prefix$curr$suffix"
                                        #At least one image downloaded
                                        result=0
                                        ;;
                                #Unsuccesful case. Disregard.
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
                        exit 101

                fi

        else

                echo -e "Usage - range: ./thumbnail.sh range <start> <end>"
                echo -e "\n\t <start> and <end> of the form xxxx; where x is a digit"
                exit 102
        fi
}

function setSpace {
  if ! [[ -f "validFiles.txt" ]]; then
    #Download website and firgure out valid filenames
    wget -q -O validFiles.txt https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152
    #Sed used to target image name and replace it with the integer part.
    sed -rnE -i 's/^.*<p class="hidden-sm hidden-xs">DSC0([[:digit:]]+)<\/p>/\1/p' validFiles.txt
  fi

  #Store the integer in an array
  #Will be used to sample for random ones.
  length=0
  while read p; do
    filesArray[$length]=$p
    length=$(($length+1))
  done <validFiles.txt
}

function pop {
  #pop index := $1
  #array length :=$2
  unset filesArray[$1]
  local i
  for (( i = $1; i < $2; i++ )); do
    filesArray[$i]=${filesArray[$(($i+1))]}
  done
}
function getSample {
  #Random number over the range of valid filenames.
  #length := $1
  index=$(($1*RANDOM/32767))
  curr=${filesArray[$index]}
  pop index $1
}
function getRandom {
        # pick := $1
        #Check that options are correct
        if echo "$1" | grep -Eq '[0-9]{1}'; then
              setSpace
              local i
              for (( i = 0; i < $1; i++ )); do
                    getSample $length
                    getSpecific "$prefix$curr"
                    length=$(($length-1))
              done
        else
                echo -e "Usage - rand: ./thumbnail.sh rand <pick>"
                echo -e "\n\t <pick> being an integer lesser than the inclusive range from <start> to <end>"
                exit 105
        fi

}

#script entry point

main $1 $2 $3

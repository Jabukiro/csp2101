#!/bin/bash
#Copies folder content into a new folder
read -p "Copy folder into new folder >" ogFolder newFolder
#Exit with message if folder doesn't exist
! [ -d "$ogFolder" ] && echo "No such Folder in current directory:" && ls . && exit 1
#Get new folder
#Exit with message if folder exists
[ -d "$newFolder" ] && echo "File -$newFolder- already exists. Bye" && exit 1
#Create folder and copy contents from last week
mkdir "$newFolder"
cp -R "$ogFolder" "$newFolder/" && echo "Folder created! Bye." && exit 0

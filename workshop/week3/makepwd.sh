#!/bin/bash
read -p "Enter a folder name >" folderName
echo "Enter a *secret* Password: "
read -s $password
fileName=$folderName"/secret.txt"
mkdir -m 004 $fileName
echo $password >> $fileName

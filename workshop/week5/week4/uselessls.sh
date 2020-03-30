#!/bin/bash
#User Give FOlder name
echo Current folder structure
ls -la ./ 
read -p "Gimme a folder name> " folderName
#Display contents of folder
ls -la $folderName

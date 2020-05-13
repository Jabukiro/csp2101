#!/bin/bash
dashes="------------------------------------------------------------"
target=~/CSP2101/workshop
echo -e "All SED statements:\n$dashes"
grep --color -rw "sed" $target
echo -e "$dashes"
echo -e "\nAll lines that starts with the letter m:\n$dashes"
grep --color -r "^m" $target
echo -e "$dashes"
echo -e "\nAll lines that contain three digit numbers\n$dashes"
grep --color -rE "[[:digit:]]{3}" $target
echo -e "$dashes"
echo -e "\nAll lines that start with a vowel:\n$dashes"
grep --color -r "^[aieouy]" $target
echo -e "$dashes"
echo -e "\nAll lines that contain loops:\n$dashes"
grep --color -rE -e "for((each)|( \(\())" -e "while.*; do" $target
echo -e "\nAll echo statements with at least three words:\n$dashes"
grep --color -rE "echo .. \"(\<\w{1}){3,}" $target

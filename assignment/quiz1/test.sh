#!/bin/bash
read -p 'please type your name >' name
echo 'hello $name'
if [ "$name" == "Harriet" ]; then
	echo 'you have a very pretty name!'
fi

read -s -p 'please enter your password >' password
case "$password" in
'secret')
	echo "acccess granted"
	;;	
*)
	echo "access denied"
esac

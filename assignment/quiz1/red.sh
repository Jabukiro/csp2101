#!/bin/bash
read -p "bla" nu
until(( $nu <= 10 )); do
	echo "$nu"
done
if (( nu < 10 )); then
fi

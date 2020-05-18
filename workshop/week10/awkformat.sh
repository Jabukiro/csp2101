#!/bin/bash
echo "The items on your shopping list is as follows:"
awk 'BEGIN {
	FS=","
}
{
	print $1
}' shopping.csv

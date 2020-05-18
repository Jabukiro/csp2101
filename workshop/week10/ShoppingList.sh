#!/bin/bash
echo "Your shopping list is as follows:"
echo -e "Item               | Quantity               | Price"
echo -e "-------------------|------------------------|---------------"
awk 'BEGIN{
	FS=","
}
{


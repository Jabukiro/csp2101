#!/bin/bash
ipinfo="$(./IpInfo.sh)"

#Only output lines with IpAdress
output=$(echo "$ipinfo" | sed -n '/IP Address/ {
p
}')

echo "$output"

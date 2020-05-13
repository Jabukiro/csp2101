#!/bin/bash
output=$(curl -s http://example.com)
parsed=$(echo "$output" | sed -rEn 's/<h1>(.*)<\/h1>/\1/p; N; s/<p>(\w+.*)<\/p>/\1/p; D')
echo "$parsed"

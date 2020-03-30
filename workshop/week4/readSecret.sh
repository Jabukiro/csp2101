#!/bin/bash
#Tries to read file secrete.txt in same folder
#If can't print error message and exits
whoami
cat secret.txt || echo "Can't read secret.txt" && exit 1
exit 0

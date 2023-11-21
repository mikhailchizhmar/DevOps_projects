#!/bin/bash
if [[ $# -ne 1 ]]
then
echo "Must be 1 parameter"
elif [[ $1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]
then
echo "Incorrect input: enter a string, not a number"
else
echo "$1"
fi
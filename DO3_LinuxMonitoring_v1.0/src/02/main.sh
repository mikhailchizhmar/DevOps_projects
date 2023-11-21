#!/bin/bash

if [[ $# -ne 0 ]]; then
    echo "No parameters allowed"
else
    ./help.sh
    echo
    echo "Write data to a file? Y/N"
    read answer
    if [[ $answer == "Y" ]] || [[ $answer == "y" ]]; then
        name_of_file=$(date "+%d_%m_%y_%H_%M_%S.status")
        ./help.sh > $name_of_file
    fi
fi
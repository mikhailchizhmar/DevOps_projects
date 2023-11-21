#!/bin/bash

function try {
    echo "Do you want to try again? Y/N"
    read answer
    if [[ $answer == "Y" ]] || [[ $answer == "y" ]]; then
        echo "Input parameter"
        read d
        sudo ./main.sh $d
    fi
}
start_time=$(date +%s)

if [ $# -ne 1 ]; then
    echo -e "\033[91mHere must be 1 parameter\033[0m"
    try
elif [[ $1 != */ ]]; then
    echo -e "\033[91mName of directory must end with '/'\033[0m"
    try
elif ! [[ -d $1 ]]; then
    echo -e "\033[91m$1 is not a directory\033[0m"
    try
else
    sudo ./script.sh $1
    echo -e "Script execution time (in seconds) = \033[92m$(echo "$(date +%s) - $start_time" | bc)\033[0m"
fi
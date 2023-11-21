#!/bin/bash

param='[1-6]'

function try {
    echo "Do you want to try again? Y/N"
    read answer
    if [[ $answer == "Y" ]] || [[ $answer == "y" ]]; then
        echo "Input parameters"
        read a b c d
        sudo ./main.sh $a $b $c $d
    fi
}

if [[ $# -ne 4 ]]; then
    echo "Here must be 4 parameters"
    try
elif ! [[ $1 == $param ]] || ! [[ $2 == $param ]] || ! [[ $3 == $param ]] || ! [[ $4 == $param ]]; then
    echo "Parameters must be more than 0 and less than 7"
    try
elif [[ $1 -eq $2 ]] || [[ $3 -eq $4 ]]; then
    echo "Color of text and background must not be equal"
    try
else
    sudo ./script.sh $1 $2 $3 $4
fi

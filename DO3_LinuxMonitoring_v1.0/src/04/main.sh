#!/bin/bash

function num_to_color {
    color=""
    case "$1" in
    1) color="white" ;;
    2) color="red" ;;
    3) color="green" ;;
    4) color="blue" ;;
    5) color="purple" ;;
    6) color="black" ;;
    esac
    echo "$color"
}

function default_or_not {
    case "$1" in
    0) echo "$2" ;;
    1) echo "default" ;;
    esac
}

flag1=0
flag2=0
flag3=0
flag4=0
param='[1-6]'

if [[ $# -ne 0 ]]; then
    echo "No parameters allowed"
else
    b1="$(grep column1_background user.conf | awk -F= '{print $2}')"
    f1="$(grep column1_font_color user.conf | awk -F= '{print $2}')"
    b2="$(grep column2_background user.conf | awk -F= '{print $2}')"
    f2="$(grep column2_font_color user.conf | awk -F= '{print $2}')"

    if ! [[ $b1 == $param ]] || [[ -z "$b1" ]]; then
        b1="$(grep column1_background default.conf | awk -F= '{print $2}')"
        flag1=1
    fi
    if ! [[ $f1 == $param ]] || [[ -z "$f1" ]]; then
        f1="$(grep column1_font_color default.conf | awk -F= '{print $2}')"
        flag2=1
    fi
    if ! [[ $b2 == $param ]] || [[ -z "$b2" ]]; then
        b2="$(grep column2_background default.conf | awk -F= '{print $2}')"
        flag3=1
    fi
    if ! [[ $f2 == $param ]] || [[ -z "$f2" ]]; then
        f2="$(grep column2_font_color default.conf | awk -F= '{print $2}')"
        flag4=1
    fi

    sudo ../03/script.sh $b1 $f1 $b2 $f2

    echo
    echo "Column 1 background = $(default_or_not $flag1 $b1) ($(num_to_color $b1))"
    echo "Column 1 font color = $(default_or_not $flag2 $f1) ($(num_to_color $f1))"
    echo "Column 2 background = $(default_or_not $flag3 $b2) ($(num_to_color $b2))"
    echo "Column 2 font color = $(default_or_not $flag4 $f2) ($(num_to_color $f2))"
fi
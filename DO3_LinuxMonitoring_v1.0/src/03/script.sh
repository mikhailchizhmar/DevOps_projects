#!/bin/bash

function color_func {
    str=""
    case "$2" in
    1) str="\033[97m" ;; # white
    2) str="\033[91m" ;; # red
    3) str="\033[92m" ;; # green
    4) str="\033[94m" ;; # blue
    5) str="\033[95m" ;; # purple
    6) str="\033[30m" ;; # black
    esac
    case "$1" in
    1) str+="\033[107m" ;; # white
    2) str+="\033[101m" ;; # red
    3) str+="\033[102m" ;; # green
    4) str+="\033[104m" ;; # blue
    5) str+="\033[105m" ;; # purple
    6) str+="\033[40m" ;; # black
    esac
    echo "$str"
}

var=$(color_func $1 $2)
output=$(color_func $3 $4)
EOL="\033[0m"

echo -e "${var}HOSTNAME$EOL = ${output}$HOSTNAME$EOL"
echo -e "${var}TIMEZONE$EOL = ${output}$(cat /etc/timezone) UTC $(date +%:::z | sed 's/+0/+/;s/-0/-/')$EOL"
echo -e "${var}USER$EOL = ${output}$(whoami)$EOL"
echo -e "${var}OS$EOL = ${output}$(hostnamectl | grep Operating | awk '{print $3, $4}')$EOL"
echo -e "${var}DATE$EOL  = ${output}$(date | awk '{print $3, $2, $6, $4}')$EOL"
echo -e "${var}UPTIME$EOL = ${output}$(uptime -p)$EOL"
echo -e "${var}UPTIME_SEC$EOL = ${output}$(cat /proc/uptime | awk '{print $1}')$EOL"
echo -e "${var}IP$EOL = ${output}$(ifconfig | grep "inet" | awk '{print $2}' | head -1)$EOL"
echo -e "${var}MASK$EOL = ${output}$(ifconfig | grep "netmask" | awk '{print $4}' | head -1)$EOL"
echo -e "${var}GATEWAY$EOL = ${output}$(ip route | grep default | awk '{print $3}')$EOL"
echo -e "${var}RAM_TOTAL$EOL = ${output}$(free | grep Mem | awk '{printf "%.3f GB", $2/1024/1024}')$EOL"
echo -e "${var}RAM_USED$EOL = ${output}$(free | grep Mem | awk '{printf "%.3f GB", $3/1024/1024}')$EOL"
echo -e "${var}RAM_FREE$EOL = ${output}$(free | grep Mem | awk '{printf "%.3f GB", $4/1024/1024}')$EOL"
echo -e "${var}SPACE_ROOT$EOL = ${output}$(df --portability | awk '{ if($NF=="/") printf "%.2f MB", $2/1024/1024}')$EOL"
echo -e "${var}SPACE_USED$EOL = ${output}$(df --portability | awk '{ if($NF=="/") printf "%.2f MB", $3/1024/1024}')$EOL"
echo -e "${var}SPACE_FREE$EOL = ${output}$(df --portability | awk '{ if($NF=="/") printf "%.2f MB", $4/1024/1024}')$EOL"
#!/bin/bash

echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $(cat /etc/timezone) UTC $(date +%:::z | sed 's/+0/+/;s/-0/-/')"
echo "USER = $(whoami)"
echo "OS = $(hostnamectl | grep Operating | awk '{print $3, $4}')"
echo "DATE  = $(date | awk '{print $3, $2, $6, $4}')"
echo "UPTIME = $(uptime -p)"
echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
echo "IP = $(ifconfig | grep "inet" | awk '{print $2}' | head -1)"
echo "MASK = $(ifconfig | grep "netmask" | awk '{print $4}' | head -1)"
echo "GATEWAY = $(ip route | grep default | awk '{print $3}')"
echo "RAM_TOTAL = $(free | grep Mem | awk '{printf "%.3f GB", $2/1024/1024}')"
echo "RAM_USED = $(free | grep Mem | awk '{printf "%.3f GB", $3/1024/1024}')"
echo "RAM_FREE = $(free | grep Mem | awk '{printf "%.3f GB", $4/1024/1024}')"
echo "SPACE_ROOT = $(df --portability | awk '{ if($NF=="/") printf "%.2f MB", $2/1024/1024}')"
echo "SPACE_USED = $(df --portability | awk '{ if($NF=="/") printf "%.2f MB", $3/1024/1024}')"
echo -n "SPACE_FREE = $(df --portability | awk '{ if($NF=="/") printf "%.2f MB", $4/1024/1024}')"
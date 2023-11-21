#!/bin/bash

function type_of_file {
    str=$1
    output=""
    for ((i = ${#str} - 1; i >= 0; i--)); do
        char="${str:$i:1}"
        if [[ $char == '.' ]]; then
            index=$i
            break
        fi
    done

    for ((i = $(( $index + 1 )); i < ${#str}; i++)); do
        output+="${str:$i:1}"
    done
    echo $output
}

green="\033[92m"
EOL="\033[0m"
#exec 2>/dev/null

echo -e "Total number of folders (including all nested ones) = $green$(find "$1" -type d | wc -l)$EOL"
echo -e "TOP 5 folders of maximum size arranged in descending order (path and size):"
sudo du $1 -bhS | sort -hr | nl | awk '{printf "\033[92m%d - %s, %sB\n", $1, $3, $2}' | head -5
echo -e "\033[0mTotal number of files = $green$(find "$1" -type f | wc -l)$EOL"
echo "Number of:"
echo -e "Configuration files (with the .conf extension) = $green$(find "$1" -type f -name "*.conf" | wc -l)$EOL"
echo -e "Text files = $green$(find "$1" -type f -name "*.txt" | wc -l)$EOL"
echo -e "Executable files = $green$(find "$1" -type f -executable | wc -l)$EOL"
echo -e "Log files (with the extension .log) = $green$(find "$1" -type f -name "*.log" | wc -l)$EOL"
echo -e "Archive files = $green$(find "$1" -type f \( -name "*.tar" -o -name "*.zip" \) | wc -l)$EOL"
echo -e "Symbolic links = $green$(find "$1" -type l | wc -l)$EOL"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
find "$1" -type f -exec du -bh {} + | sort -rh | nl | head -n 10 | while IFS=$'\t' read -r -a fields; do
    file_type=$(type_of_file "${fields[2]}")
    printf "\033[92m%d - %s, %sB, %s\033[0m\n" "${fields[0]}" "${fields[2]}" "${fields[1]}" "$file_type"
done
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"

find "$1" -type f -executable -exec du -bh {} + | sort -rh | nl | head -n 10 | while IFS=$'\t' read -r -a fields; do
    printf "\033[92m%d - %s, %sB, %s\033[0m\n" "${fields[0]}" "${fields[2]}" "${fields[1]}" "$(md5sum "${fields[2]}" | awk '{print $1}')"
done
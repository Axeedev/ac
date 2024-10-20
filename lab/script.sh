#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Error. Path to folder and threshold should be given as arguments"
  exit 1
fi
if [ ! -d "$1" ]; then
 echo "1st argument is not a folder."
 exit 1
fi
if ! [[ "$2" =~ ^[0-9]+$ ]]; then
 echo "the second argument should be a number."
 exit 1
fi
folder_path="$1"
threshold="$2"
folder_size=$(du -sb "$folder_path" | awk '{print $1}')
res=$((threshold*500000))
if [ "$folder_size" -lt "$res" ]; then
	echo "Folder '$folder_path' filled with more than threshold %"
	echo "Archiving 5 oldest files"
	top_files=$(find "$folder_path" -type f -printf '%T@ %p\n' | sort -n | head -n 5 | awk '{print $2}')
	tar -czvf /home/nik/backup/$(date +%s%3N)backup.tar.gz --files-from <(echo "$top_files")
	rm $(echo "$top_files")
	echo "Archive has been created in /home/nik/backup. Files deleted from '%folder_path'"
else
  	echo "Folder '$folder_path' filled with less than $threshold %"
fi

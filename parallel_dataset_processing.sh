#!/usr/bin/bash

num_workers=$num_workers
links_index=$links_index
output_folder=$output_folder
input=$input

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi

  shift
done

folder_full_path=$(find "$(cd ..; pwd)" -type d -name "$output_folder")
echo $folder_full_path
awk -v INDEX="$links_index" 'BEGIN {FS=";"} NR>1 {print $INDEX}' $input \
 | xargs -P $num_workers wget -P $folder_full_path

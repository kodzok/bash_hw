#!/usr/bin/bash

input_file=$input_file
height=$height
width=$width

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi

  shift
done

jq --argjson HEIGHT "$height" \
   --argjson WIDTH "$width" \
   '.images[] | select(.height>$HEIGHT and .width>$WIDTH) | .id' $input_file

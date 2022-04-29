#!/usr/bin/bash

category_id=$category_id
input_file=$input_file

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi

  shift
done

jq --argjson id "$category_id" '.annotations[] | select(.category_id==$id) | .image_id' $input_file

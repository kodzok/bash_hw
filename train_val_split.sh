#!/usr/bin/bash

input=$input
train_ratio=$train_ratio
train_file=$train_file
val_file=$val_file
shuffle=${shuffle:-False}

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi

  shift
done

num_samples=$(cat $input | wc -l)
train_samples=$( printf "%.0f"  $(echo "$train_ratio * $num_samples" | bc -l) )

if [[ "$shuffle" == "False" ]]
then
head -n $train_samples $input > $train_file
tail -n +$(( $train_samples + 1 )) $input > $val_file
else
new_input="shuffled_dataset.csv"
cat $input | shuf > $new_input
head -n $train_samples $new_input > $train_file
tail -n +$(( $train_samples + 1 )) $new_input > $val_file
fi

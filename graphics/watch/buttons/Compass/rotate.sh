#!/bin/bash

#
# Will create $steps number of images by rotating the source image
# so that an animation can be later created that will show
# rotation of the source image by 360 degrees.
#
# Example:
#
#    ./rotate.sh map_arrow Watch_compass_arrows
#

c=0
steps=16
original_file_name=$1
destimation_dir_name=$2
steps_minus_one=$(( steps - 1 ))
step_angle=$(bc <<< "scale = 2; 360 / $steps")
mkdir $destimation_dir_name

while [ $c -le $steps_minus_one ]
do
  angle=$(bc <<< "scale = 2; $c * $step_angle")
  input_name="$original_file_name@2x.png"

  number_padded=$(printf "%02d" $c)
  output_name="${original_file_name}_$number_padded@2x.png"

  echo "Rotating $input_name to $output_name"
  convert $input_name -distort SRT $angle $destimation_dir_name/$output_name
  (( c++ ))
done


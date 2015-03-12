#!/bin/bash

#
# Will create $steps number of images by rotating the source image
# so that an animation can be later created that will show
# rotation of the source image by 360 degrees.
#
# Example:
#
#    ./rotate.sh map_arrow
#

c=0
steps=16
original_file_name=$1
steps_minus_one=$(( steps - 1 ))
step_angle=$(bc <<< "scale = 2; 360 / $steps")
mkdir rotated

while [ $c -le $steps_minus_one ]
do
  angle=$(bc <<< "scale = 2; $c * $step_angle")
  input_name="$original_file_name@2x.png"
  output_name="${original_file_name}_$c@2x.png"
  echo "Rotating $input_name to $output_name"
  convert $input_name -distort SRT $angle rotated/$output_name
  (( c++ ))
done


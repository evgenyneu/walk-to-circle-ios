#!/bin/sh

#
# Run pngcrush for all png images in the given directory.
#
# Example:
#
#    ./pngcrushall.sh somedir/
#


for png in `find $1 -name "*.png"`;
do
  echo "crushing $png"
  pngcrush -q -rem allb -reduce "$png" temp.png
  mv -f temp.png $png
done;
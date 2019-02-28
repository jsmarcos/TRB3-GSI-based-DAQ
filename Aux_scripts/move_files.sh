#!/bin/bash

find $1 -maxdepth 1 -type f -name "*.dat" |while read file  # -maxdepth 1 guarantees that files will not be searched in the sub-directories 
do
  mv $file ${file%/*}/Backup
done
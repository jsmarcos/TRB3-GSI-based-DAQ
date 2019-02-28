#!/bin/bash

mkdir $1/DAT_files

find $1 -maxdepth 1 -type f -name "*.dat" |while read file
do
	mv $file ${file%/*}/DAT_files
done 

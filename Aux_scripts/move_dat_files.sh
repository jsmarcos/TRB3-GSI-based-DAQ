#!/bin/bash

find $1 -maxdepth 1 -type f -name "*.dat" |while read file
do
	mv $file ${file%/*}/Backup
done 

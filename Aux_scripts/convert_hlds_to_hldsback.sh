#!/bin/bash

echo "Converting .hlds already shown to hldsback files..."

#mv "/home/jsm/Documents/Real-Time-Dat-Files-from-TRBReader/*.dat" "/home/jsm/Documents/Processed/"

mkdir $1/Backup

for file in $1/*.hld ; do
  mv "$file" "$file.back"
done 

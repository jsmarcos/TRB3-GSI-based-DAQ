#!/bin/bash

echo "Deleting .hlds..."

#mv "/home/jsm/Documents/Real-Time-Dat-Files-from-TRBReader/*.dat" "/home/jsm/Documents/Processed/"

for file in $1/*.hld ; do
  rm "$file"
done 

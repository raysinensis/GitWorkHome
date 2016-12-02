#!/bin/bash
#sync git folder between home and work computers

usage(){
  echo "Usage: pull/status/gc/zip"
  echo ""
  exit 2
}

dir=$(pwd)
today=$(date "+%m%d%Y")
##checking for correct arguments
  if [ "$#" != "1" ]
  then
	usage
	exit 1
  fi
  export function1=$1

  if [ $function1 = "zip" ]
  then 
	for entry in */
	do 
		echo "processing: " "$entry"
		cd $entry
		entryname=${entry%/}
		filename="$dir""/""$entryname""$today"".zip"
		git archive master --format zip -o "$filename"
		cd ..
	done
	
  else
	for entry in */
 	do
  		echo "processing: " "$entry"
		cd $entry
		git $function1
		cd ..
  	done
  fi




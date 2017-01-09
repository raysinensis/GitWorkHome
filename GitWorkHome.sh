#!/bin/bash
#sync git folder between home and work computers

usage(){
  echo "Usage: pull/status/gc/zip/undo"
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

##zip option to backup files with date in file name
  if [ $function1 = "zip" ]
  then 
	for entry in */
	do 
		echo "processing: " "$entry"
		cd $entry
		entryname=${entry%/}
		filename="$dir""/""$entryname""$today"".zip"
		git archive master --format zip -o "$filename"
		echo "-----------------------"
		cd ..
	done

##undo pull or edits
  elif [ $function1 = "undo" ]
  then
	for entry in */
	do 
		echo "checking last modified time:" "$entry"
		entryname=${entry%/}
		foldername="$dir""/""$entryname"
		modified=$(date -r "$foldername" +%s)
		##echo "$modified"
		timenow=$(date +%s)
		##echo "$timenow"
		timediff=$(($timenow-$modified))
		##echo "$timediff"
		mindiff=$(($timediff/60))
		echo "last modified ""$mindiff"" min ago"
		resettime=$(($mindiff+1))
		git reset --hard master@{"$resettime minutes ago"}
	done

##simply apply git commands to each folder
  else
	for entry in */
 	do
  		echo "processing: " "$entry"
		cd $entry
		git $function1
		echo "-----------------------"
		cd ..
	done
  fi

##date check/reminder for GC clean up  
  if [ $function1 = "gc" ]
  then
	echo "$today" >> gclog.txt

##if gclog.txt doesn't exist, prompt gc
  else
	lastd=$(awk 'END{print}' gclog.txt) || { echo "no gc records yet, consider clean up maintenance"; exit 3; }
	echo "no housekeeping since: ""$lastd""!"
  fi



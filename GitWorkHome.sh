#!/bin/sh
#sync git folder between home and work computers

usage(){
  echo "Usage: pull/status"
  echo ""
  exit 2
}

START=$(date +%s)
##checking for correct arguments
  if [ "$#" != "1" ]
  then
	usage
	exit 1
  fi
  export function1=$1

  for entry in */
  do
  	echo "syncing: " "$entry"
	cd $entry
	git $function1
	cd ..
  done




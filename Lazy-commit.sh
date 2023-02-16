#!/bin/bash

ARG2=""
ARG_P=""
echo $1
project_directory=~/Documents/CLionProjects


pull()
{
	if [ "$ARG_P" = "0" ]; then
		cd $directory
		git pull
		echo -e "\e[32mEntering in $directory to pull\e[0m"
	elif [ "$ARG_P" = "1" ]; then
		echo -e "\e[31m$directory is not a Git repo\n\e[0m"
	fi
}

push()
{
	if [ "$ARG_P" = "0" ]; then
		echo -e "\e[32mEntering in $directory to push\e[0m"
		cd $directory
		git add ./
		git commit -m "Lazy-commit"
		git push 
	elif [ "$ARG_P" = "1" ]; then
		echo -e "\e[31m$directory is not a Git repo\n\e[0m"
	fi
}

for directory in $project_directory/*/; do
  if [ -d "$directory" ] && [ -d "$directory/.git" ] && [ "$1" = "pull" ]; then
	ARG_P="0"
	pull &
  elif [ "$1" = "pull" ]; then
	ARG_P="1"
	pull &
  fi
done

wait

for directory in $project_directory/*/; do
  if [ -d "$directory" ] &&  [ -d "$directory/.git" ] && [ "$1" = "push" ]; then
	ARG_P="0"
	push &
  elif [ "$1" = "push" ] ; then
	ARG_P="1"
	push &
  fi
done

wait


#!/usr/bin/env bash

#For processing keys
k_path="$PWD";

with_dir="false"; git_ignore="false";

while [ -n "$1" ]
do
	case "$1" in
	-p)
		k_path="$2";
		shift;
	;;
	-n)
		name="$2";
		shift;
	;;
	-d)
		with_dir="true";
		shift;
	;;
	-ig)
		git_ignore="true";
		shift;
	;;
	*)
		echo "$1 is not an option" ;;
	esac
	shift;
done

if [ -d $k_path ]; then
	echo;
	echo "$k_path is exists.";
	echo;
else
	echo;
	echo "$k_path is not exist";
	mkdir $k_path;
	echo "$k_path has been create";
	echo;
fi

cd $k_path;

while [ -d $name ]; do
	echo;
	echo "$name project are exist.";
	echo "Please, enter new name of project.";
	echo;
	echo -n "Do you want it now? (y/n): "; read ans;

	if [ $ans = "y" ]; then
		echo "The old name - $name"
		echo -n "New project name: "; read name;
	else
		exit 1;
	fi
done

mkdir "$name";
echo "dir $name - create";

path="$k_path/$name";
cd $path;

if [[ $with_dir = "true" ]]; then
	mkdir resources;
	echo "$name/resources - create";

	mkdir debug;
	echo "$name/debug - create";
fi


touch Makefile;
CC="CC=gcc";
CFLAGS="CFLAGS=-c -Wall -std=c99 -O0 -g";

echo -e "$CC\n$CFLAGS\n" >> Makefile;
echo -e "all : $name.elf\n" >> Makefile;
echo -e "$name.elf : main.o\n\t\$(CC) main.o -o $name.elf\n" >> Makefile;
cat /home/st/bin/mkproj_res/default_MakeF >> Makefile;

#cp /home/st/bin/mkproj_res/default_MakeF $path;
#cat default_MakeF >> Makefile;
#rm default_MakeF;
echo "Makefile - create";

touch main.c
cat /home/st/bin/mkproj_res/default_main >> main.c;
#cp /home/st/bin/mkproj_res/default_main $path/main.c;
echo "main.c - create";

if [[ $git_ignore = "true" ]]
then
	touch .gitignore
	cat /home/st/bin/mkproj_res/default_gitIgnore >> .gitignore;
	#cp /home/st/bin/mkproj_res/default_main $path/main.c;
	echo ".gitignore - create";
fi

echo;
echo "Script completed";
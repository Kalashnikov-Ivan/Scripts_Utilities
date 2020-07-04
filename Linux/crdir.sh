#!/usr/bin/env bash

#For processing keys
while [ -n "$1" ]
do
	case "$1" in
	-p)
		k_path="$2";
		shift;
	;;
	-a)
		absol="1";
	;;
	-d)
		dir="$2";
		shift;
		d="$2";
		shift;
	;;
	-f) 
		file="$2";
		shift;
		f="$2";
		shift;
	;;
	*) 
		echo "$1 is not an option" ;;
	esac
	shift
done

#Working with path of catalog
if [[ $absol -eq "1" ]]; then
	path="$k_path";
else
	#cur_PWD=`pwd`;
	path="$PWD/$k_path";
fi

if [ -d $path ]; then
	echo;
	echo "$path is exists";
	echo;
else
	echo;
	echo "$path is not exist";
	mkdir $path;
	echo "$path has been create"; 
	echo;
fi

cd $path;


for ((i=0;i<d;i++)) 
do 
	mkdir $dir$i;
	chmod 755 $dir$i;
	cd $dir$i;
	for ((j=0;j<f;j++)) 
	do
		touch $file$j;
		echo "$file$j in $dir$i - done";
	done
	cd ../;
	echo "$dir$i - comleted";
	echo;
done 

echo;
echo "Script comleted";
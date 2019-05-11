#!/bin/sh

# Note: ID is the filename

dir=$HOME/.mplan

# Create the directory if it doesn't exist already
if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
fi

case "$1" in
    "ls")
	for f in $(ls $dir)
	do
	    echo "[0;31m----------------[0m" # Red line before every note
	    echo "[0;32mID: $f[0m"	         # Note ID in blue
	    cat $dir/$f                          # Show the actual content
	done
	echo "[0;31m----------------[0m"     # Single red line at the end
	;;

    "add")
	ID=$RANDOM
	echo $2 > $dir/$ID
	echo "[0;32mID: $ID[0m"	             # ID in green
	echo $2
	;;

    "rm")
	echo -e "[0;31mX[0m\t[0;32mID: $2[0m" # Red X and ID in green
	echo -e "\t`cat $dir/$2`"		              # Content of the note
	[ "$2" = '*' ] && rm $dir/* || rm $dir/$2
	;;

    *)
	echo
    echo 'Note: only one-line notes are supported'
    echo 
	echo 'Usage:'
	echo '      mplan ls                 list current tasks'
	echo '      mplan add content        create a new task'
	echo '      mplan rm id              remove task by id (use \* for all)'
	echo '      mplan help               print this help'
	echo
esac

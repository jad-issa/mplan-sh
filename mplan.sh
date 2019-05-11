#!/bin/sh

# Create the directory if it doesn't exist already
dir=$HOME/.mplan
[ ! -d "$dir" ] && mkdir -p "$dir"

case "$1" in
    "ls")
	for f in $(ls $dir); do
	    echo "[0;31m----------------[0m" # Red line before every note
	    echo "[0;32mID: $f[0m"	         # Note ID in blue
	    cat $dir/$f                          # Show the actual content
	done
	echo "[0;31m----------------[0m"     # Single red line at the end
	;;

    "add")
	ID=$RANDOM # It's not worth complicating things to safely verify no overlap.
    if [ -z "$2" ]; then
        cat > $dir/$ID
    else
        echo $2 > $dir/$ID
    fi
    echo "[0;32mID: $ID[0m"	             # ID in green
	cat $dir/$ID
	;;

    "rm")
	echo -e "[0;31mX[0m\t[0;32mID: $2[0m" # Red X and ID in green
	if [ "$2" = "all" ]; then
        rm $dir/*
    else
        cat $dir/$2
        rm $dir/$2
    fi
	;;

    *)
    echo 
	echo 'Usage:'
	echo '      mplan ls                 list current tasks'
	echo '      mplan add content        create a new task'
    echo '            NOTE:   if you omit `content`,'
    echo '                    then standard input'
    echo '                    is considered (using cat)'
    echo
	echo '      mplan rm id              remove task by id (possibly: `rm all`)'
	echo '      mplan help               print this help'
	echo
esac
